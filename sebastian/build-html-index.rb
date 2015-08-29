#! /usr/bin/env ruby

require './sebastian'
require 'pp'

Sebastian::DB.connect

Sebastian::Post.order(:posted_at)
  .select(:posted_at, :slug, :post_uid)
  .paginate(page: 2, per_page: 10)
  .each do |post|

  ddate = post.posted_at.strftime("%Y-%m-%d %H:%M")
  #furl = "#{post.filesystem_path}"
  furl = "#{post.html_filename}"
  atext = "#{ddate} | #{post.slug}"
  a = "<a href=\"#{furl}\">#{atext}</a>"
  puts "<li>#{a}</li>"
end


