#! /usr/bin/env ruby

require './sebastian'
require 'pp'

Sebastian::DB.connect

# select posted_at, slug from posts order by posted_at limit 70;
Sebastian::Post.order(:posted_at).select(:posted_at, :slug, :post_uid).limit(7).each do |post|
  puts "<li>"
  ddate = post.posted_at.strftime("%Y-%m-%d %H%M")
  #furl = "file://#{Sebastian::HTML_DIR}/#{post.html_filename}"
  furl = "file://#{post.filesystem_path}"
  atext = "#{ddate} - #{post.slug}"
  a = "<a href=\"#{furl}\">#{atext}</a>"
  puts furl
  puts "</li>"
end

