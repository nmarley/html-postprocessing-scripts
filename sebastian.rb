require 'nokogiri'
require 'awesome_print'
require 'pp'

class Sebastian
  class << self

    def transform(html)
      doc = Nokogiri::HTML(html)

      # Remove <script>…</script>
      doc.css('script').remove

      # remove nav elements and contents
      doc.css('nav').remove

      # rm iframes
      doc.css('iframe').remove

      doc.css('div#side_panel').remove
      doc.css('div#codeholder').remove
      doc.css('ul.post-actions').remove
      doc.css('div.responses').remove

      doc.css('div#footer').remove
      doc.css('#readnext').remove

      doc.css('div.modal').remove
      doc.css('div.modal-dialog').remove
      doc.css('div.modal-content').remove

      doc.css('.byline-author-extended').remove
      doc.css('.post-admin').remove


      html = doc.to_html
    end
  end
end

