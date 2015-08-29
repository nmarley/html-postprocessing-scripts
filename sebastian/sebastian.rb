require 'nokogiri'
require 'date'
require 'time'
require 'awesome_print'
require 'httparty'
require 'pp'
require 'active_record'
require 'will_paginate'
require 'will_paginate/active_record'

class Sebastian
  class ArchivePage < ActiveRecord::Base
  end

  class Post < ActiveRecord::Base
    def get_url
      "uid/#{self.post_uid}"
    end

    def get_full_uri
      Sebastian::ROOT + self.get_url
    end


    # pass the dir to which to write the HTML file -
    # filename is <UID>.html
    # def write_html(dir, overwrite=false)
    def write_html(overwrite=false)
      Dir.exists?(Sebastian::HTML_DIR) || Dir.mkdir(Sebastian::HTML_DIR)

      abs = File.join(Sebastian::HTML_DIR, html_filename)
      if (!File.exists?(abs) || (File.exists?(abs) && overwrite))
        File.open(abs, 'w') { |f| f.write( self.cleaned_html ) }
      end
    end

    def filesystem_path
      File.join( Sebastian::HTML_DIR, html_filename )
    end

    def html_filename
      self.post_uid.to_s + '.html'
    end
  end

  class Stat < ActiveRecord::Base
  end

  class DB
    def self.connect
      ActiveRecord::Base.establish_connection(
        adapter:  'postgresql',
        database: 'sebastmarsh_dev',
        username: 'sebastmarsh'
      )
    end
  end

  # Chrome UA
  UA = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36'
  ROOT = 'http://sebastianmarshall.com/'
  PROJECT_ROOT = '/Users/nmarley/projects/altucher-proc/sebastian'
  HTML_DIR = PROJECT_ROOT + "/html"

  class << self
    def fetch(url)
      resp = HTTParty.get(url, headers: {"User-Agent" => Sebastian::UA})
    end

    def transform(html)
      doc = Nokogiri::HTML(html)

      # remove crap...
      doc = remove_crap(doc)

      # get the Sett post ID (in case we need it later?)
      uid = doc.search('div[data-uid]').first['data-uid']

      # gets a handle to the span element with the time...
      time_span = doc.search('span[title]').first

      # parses the time so that we can format it our way...
      post_time = Time.parse(time_span['title'])

      # now we put it back into the page, formatted!
      time_span.content = post_time.strftime('%Y-%m-%d %H:%M:%S')

      html = doc.to_html
    end

    def parse_archive_page(html)
      doc = Nokogiri::HTML(html)

      doc.css('#post-0-0').remove

      posts = []

      doc.search('div[data-type="post"]').each do |div|
        time_span = div.search('span[title]').first
        post_time = Time.parse(time_span['title'] + " UTC") # assume UTC
        post_uid = div['data-uid']

        meta = {
          slug: div['data-slug'],
          posted_at: post_time,
          post_uid: post_uid,
        }

        posts.push(meta)
      end

      posts
    end

    def archive_page_url(num)
      url = Sebastian::ROOT + "page/#{num}"
      url
    end

    private
    def remove_crap(doc)
      bad_css_selectors = %w[
        script
        nav
        iframe
        div#side_panel
        div#codeholder
        ul.post-actions
        div.responses
        div#footer
        #readnext
        div.modal
        div.modal-dialog
        div.modal-content
        .byline-author-extended
        .post-admin
        div#post-0-0
      ]

      bad_css_selectors.each do |bad|
        doc.css(bad).remove
      end

      return doc
    end


  end
end

