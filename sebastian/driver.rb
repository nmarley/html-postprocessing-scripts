#! /usr/bin/env ruby

require './sebastian'
require 'httparty'
Sebastian::DB.connect

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
# html = File.read('data/me-im-a-strategist.html')
# puts Sebastian.transform(html)

html = File.read('data/146.html')
posts = Sebastian.parse_archive_page(html)

posts.each do |meta|
  post = Sebastian::Post.find_or_initialize_by(slug: meta[:slug])
  post[:posted_at] = meta[:posted_at]
  post.save!
end
