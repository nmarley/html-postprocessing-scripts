require 'nokogiri'
require 'awesome_print'
require 'pp'

class Sebastian
  class << self
    # def strip_crap(html, thing)
    #   re = /(.*)<!--\ BEGIN\ #{thing}\ \/\/\ -->(?:[^\n]*\n)
    #         (.*)<!--\ \/\/\ END\ #{thing}\ -->(?:[^\n]*\n)(.*)
    #        /sxum

    #   new_html = html.sub(re) do |m|
    #     return $1 + $3
    #   end
    # end

    def transform(html)

      # html = strip_crap(html, 'PREHEADER')
      # html = strip_crap(html, 'HEADER')
      # html = strip_crap(html, 'FOOTER')
      # puts html

      doc = Nokogiri::HTML(html)
      doc.css('#awesomewrap').remove
      # ap doc.methods
      doc.css('script').remove                             # Remove <script>…</script>


      # doc.css('link[href="http://us5.campaign-archive2.com/css/archivebar-desktop.css"]').remove
      # link rel="stylesheet" href="http://us5.campaign-archive1.com/css/archivebar-desktop.css

      bad = []
      doc.css('link').each do |link|
        href = link['href']
        if href.match(/archivebar.*?css/)
          bad.push( href )
        end
      end

      bad.each do |href|
        link_match = 'link[href="' + href + '"]'
        doc.css(link_match).remove
      end

      doc.css('table.mcnShareBlock').remove
      doc.css('table.mcnDividerBlock').remove

      # TODO: change width attr from 600 to 900 where:...
      # <table class="mcnTextContentContainer"
      doc.css('table.mcnTextContentContainer')[0]['width'] = '900'

      html = doc.to_html
    end
  end
end

