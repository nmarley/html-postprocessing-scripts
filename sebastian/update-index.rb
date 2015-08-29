#! /usr/bin/env ruby

require './sebastian'
require 'pp'

Sebastian::DB.connect

known = 0

page_num = 1
while (0 == known)
  url  = Sebastian.archive_page_url(page_num)
  html = Sebastian.fetch(url).body
  posts = Sebastian.parse_archive_page(html)

  page_num += 1


  posts.each do |meta|
    post = Sebastian::Post.find_by(post_uid: meta[:post_uid])

    if post
      known += 1
    else
      post = Sebastian::Post.create!(meta)
    end

  end

end

