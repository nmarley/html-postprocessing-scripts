#! /usr/bin/env ruby

require './sebastian'
require './arec'

# http://sebastianmarshall.com/page/146

# fetch stats/metadata
stat = Stat.first
starting_page = stat.last_archive_page_fetched - 1

(1..starting_page).to_a.reverse.each do |num|
  url = Sebastian::ROOT + "page/#{num}"
  html = Sebastian.fetch(url).body
  stat.last_archive_page_fetched = num

  posts = Sebastian.parse_archive_page(html)
  posts.each do |meta|
   post = Post.find_or_initialize_by(slug: meta[:slug])
   post[:posted_at] = meta[:posted_at]
   post.save!
  end

  stat.save

  sleep rand(3..8)
end
