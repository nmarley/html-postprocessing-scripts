#! /usr/bin/env ruby

require './arec'
require './sebastian'
require 'pp'

#posts = Post.where(orig_html: '').order(:posted_at).limit(10)
posts = Post.where(orig_html: '').order(:posted_at)

posts.each do |post|
  url = Sebastian::ROOT + post.get_url

  html = Sebastian.fetch(url).body
  fetched_at = Time.now.getutc
  post.orig_html = html
  post.fetched_at = fetched_at
  post.save!

  # sleep rand(3..5)
  # sleep 1
end

