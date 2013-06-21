namespace :import do
  desc "Import legacy categories"
  task :categories => :environment do
    puts "Importing legacy categories"
    puts "---------------------------"
    Category.delete_all
    categories = Legacy::Category.where(:area => 1)
    categories.each do |category|
      Category.create!(:id => category.id,
                       :name => category.name,
                       :cached_slug => category.cached_slug)
      puts "#{category.name} imported"
    end
    puts "---------------------------"
  end

  desc "Import legacy projects"
  task :projects => :environment do
    website = Category.find_by_name("websites")
    puts "Importing legacy projects"
    puts "-------------------------"
    Project.delete_all
    projects = Legacy::Project.all
    projects.each do |project|
      category = Legacy::Category.find(project.category_id)
      category = Category.find_by_name(category.name)
      Project.create!(:name => project.name,
                      :description => project.description,
                      :url => project.url? ? project.url : "offline",
                      :due_date => project.due_date,
                      :published => project.published,
                      :category_id => category ? category.id : website.id,
                      :tags => project.tags,
                      :cached_slug => project.cached_slug)
      puts "#{project.name} imported"
    end
    puts "-------------------------"
  end

  desc "Import legacy photos"
  task :photos => :environment do
    puts "Importing legacy photos"
    puts "---------------------------"
    Photo.delete_all

    projects = Legacy::Project.all
    projects.each do |project|
      legacy_project = Legacy::Project.find(project.id)
      project = Project.find_by_name(legacy_project.name)
      if not project.photos
        Photo.create!(:title => "Screenshot #{project.name}",
                      :order => 0,
                      :project_id => project.id,
                      :file => File.new("#{Rails.root}/public/system/legacy/screenshots/#{legacy_project.id}/original/#{legacy_project.screenshot_file_name}"))
        puts "#{legacy_project.screenshot_file_name} imported"
      end
    end

    photos = Legacy::Photo.all
    photos.each do |photo|
      project = Legacy::Project.find(photo.project_id)
      project = Project.find_by_name(project.name)
      Photo.create!(:title => photo.title,
                    :order => photo.order,
                    :project_id => project.id,
                    :file => File.new("#{Rails.root}/public/system/legacy/photos/#{photo.id}/original/#{photo.photo_file_name}"))
      puts "#{photo.photo_file_name} imported"
    end
    puts "---------------------------"
  end

  desc "Import legacy posts"
  task :posts => :environment do
    puts "Importing legacy posts"
    puts "-------------------------"
    Post.delete_all
    posts = Legacy::Post.all
    posts.each do |post|
      Post.create!(:title => post.title,
                   :abstract => post.abstract,
                   :body => post.body,
                   :published_date => post.published_date,
                   :published => post.published,
                   :external_url => post.tableless,
                   :meta_title => post.meta_title,
                   :meta_description => post.meta_description,
                   :block_comments => post.block_comments,
                   :locale => post.locale,
                   :tags => post.categories.map { |c| c.name.downcase }.join(', '),
                   :cached_slug => post.cached_slug)
      puts "#{post.title} imported"
    end
    puts "-------------------------"
  end

  task :all => [:categories, :projects, :photos, :posts] do
    puts "---------------------------"
    puts "Done!"
    puts "---------------------------"
  end
end
