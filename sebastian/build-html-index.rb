#! /usr/bin/env ruby

require './sebastian'
require './arec'
require 'pp'

# select posted_at, slug from posts order by posted_at limit 70;
Post.order(:posted_at).select(:posted_at, :slug, :post_uid).limit(7).each do |post|
  puts "<li>"
  ddate = post.posted_at.strftime("%Y-%m-%d %H%M")
  furl = "file://#{Dir.pwd}/html/#{post.post_uid}.html"
  atext = "#{ddate} - #{post.slug}"
  a = "<a href=\"#{furl}\">#{atext}</a>"

  puts furl
  puts "</li>"
  #puts "="*72
end

