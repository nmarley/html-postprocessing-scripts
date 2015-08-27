require 'nokogiri'
require 'date'
require 'time'
require 'awesome_print'
require 'httparty'
require 'pp'

class Sebastian

  # Chrome UA
  UA = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.118 Safari/537.36'
  ROOT = 'http://sebastianmarshall.com/'

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

        meta = {
          slug: div['data-slug'],
          posted_at: post_time,
        }

        posts.push(meta)
      end

      posts
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

