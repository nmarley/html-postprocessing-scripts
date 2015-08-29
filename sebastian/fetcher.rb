#! /usr/bin/env ruby

require './sebastian'
require 'pp'
Sebastian::DB.connect

posts = Sebastian::Post.where(orig_html: '').order(:posted_at)

posts.each do |post|
  url = post.get_full_uri

  html = Sebastian.fetch(url).body
  fetched_at = Time.now.getutc
  post.orig_html = html
  post.fetched_at = fetched_at
  post.save!
end

