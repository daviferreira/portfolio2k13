#!/usr/bin/env ruby
require File.expand_path('../../config/boot', __FILE__)
require File.expand_path('../../config/environment', __FILE__)

# script/wxr_export.rb
# TODO: strip HTML, converting br to new line

xml = Builder::XmlMarkup.new(:target => STDOUT, :indent => 2)

xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"

xml.rss 'version' => "2.0",
        'xmlns:content' => "http://purl.org/rss/1.0/modules/content/",
        'xmlns:dsq' => "http://www.disqus.com/",
        'xmlns:dc' => "http://purl.org/dc/elements/1.1/",
        'xmlns:wp' => "http://wordpress.org/export/1.0/" do

  xml.channel do
      Legacy::Post.where(:published => true).each do |post|

        if not post.tableless.present?

        xml.item do

          xml.title { |x| x << post.title }
          xml.link { |x| x << "http://www.daviferreira.com/posts/#{post.cached_slug}" }
          xml.content(:encoded) { |x| x << "<![CDATA[" + post.body.encode(:xml => :text).gsub('--', '- -').gsub('--', '- -').chars.select{|i| i.valid_encoding?}.join + "]]>" }
          xml.dsq(:thread_identifier) { |x| x << post.id }
          xml.wp(:post_date_gmt) { |x| x << post.created_at.utc.to_formatted_s(:db) }
          xml.wp(:comment_status) { |x| x << "open" }


          post.comments.where(:published => true).each do |comment|

            xml.wp(:comment) do

              xml.wp(:comment_id) { |x| x << comment.id }

              xml.wp(:comment_author) do |x|
                x << comment.author
              end

              xml.wp(:comment_author_email) do |x|
                x << comment.email
              end

              xml.wp(:comment_author_url) do |x|
                if comment.url.start_with?('http')
                  x << comment.url
                else
                  x << ""
                end
              end

              xml.wp(:comment_author_IP) { |x| x << comment.ip }

              xml.wp(:comment_date_gmt) { |x| x << comment.created_at.utc.to_formatted_s(:db) }

              xml.wp(:comment_content) { |x| x << "<![CDATA[" + comment.body.encode(:xml => :text).gsub('--', '- -').gsub('--', '- -').chars.select{|i| i.valid_encoding?}.join + "]]>" }

              xml.wp(:comment_approved) { |x| x << 1 } #approve all comments

              xml.wp(:comment_parent) do |x|
                if comment.comment.present?
                  x << comment.comment.id
                else
                  x << 0
                end
              end

            end #xml.wp(:comment)

          end       #Comments.all.each

        end   #xml.item
        end #tableless
    end #Post.all.each
  end         #xml.channel
end           #xml.rss
