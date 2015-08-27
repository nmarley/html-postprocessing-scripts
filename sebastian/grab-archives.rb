#! /usr/bin/env ruby

require './sebastian'
require './arec'

# http://sebastianmarshall.com/page/146

# (1..139).to_a.reverse.each do |num|
  url = Sebastian::ROOT + "page/#{num}"
  html = Sebastian.fetch(url).body

  posts = Sebastian.parse_archive_page(html)
  posts.each do |meta|
   post = Post.find_or_initialize_by(slug: meta[:slug])
   post[:posted_at] = meta[:posted_at]
   post.save!
  end

  # TODO... change this one... maybe more frequent, and maybe less for the
  # actual fetcher
  sleep rand(3..8)
end
