#! /usr/bin/env ruby

require './arec'
require './sebastian'
require 'pp'

# TODO: remove limit here & let fly... (INCREASE SLEEP BELOW, ALSO)
posts = Post.where(orig_html: '').order(:posted_at).limit(10)

posts.each do |post|
  url = Sebastian::ROOT + post.slug
  html = Sebastian.fetch(url).body
  fetched_at = Time.now.getutc
  post.orig_html = html
  post.fetched_at = fetched_at
  post.save!

  sleep rand(3..7)
end

