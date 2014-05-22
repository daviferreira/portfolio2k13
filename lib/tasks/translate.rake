namespace :translate do
  desc "Adds missing translations"
  task :projects => :environment do
    I18n.locale = :en
    Project.all.each do |project|
      if not project.name.present?
        I18n.locale = "pt-BR"
        name = project.name
        description = project.description
        puts project.to_json
        puts name
        puts description
        puts " =================== "
        I18n.locale = :en
        project.name = name
        project.description = description
        project.save!
      end

      if not project.cached_slug.present?
        project.generate_slug!
      end
    end
  end

end
