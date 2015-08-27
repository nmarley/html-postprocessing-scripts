#! /usr/bin/env ruby

require './sebastian'
require 'httparty'

# usage: echo 'sebastian-url' | script > out.html
# then view 'out.html' in browser ( echo file://`pwd`/out.html | pbcopy )
# then adjust/remove extra elements and cmd-P
# then save as PDF
# then move to PC
# and then print.

# url = ARGF.read
# url.chomp!
# resp = HTTParty.get(url)
# html = resp.body

# from an HTML file...
# html = File.read('me-im-a-strategist.html')
# puts Sebastian.transform(html)

html = File.read('146.html')
puts Sebastian.parse_archive_page(html)


