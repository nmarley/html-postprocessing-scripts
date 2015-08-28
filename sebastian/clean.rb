#! /usr/bin/env ruby

require './sebastian'
require 'pp'
Sebastian::DB.connect

posts = Sebastian::Post.where(cleaned_html: '').each do |post|
  html = post.orig_html
  clean = Sebastian.transform(html)

  post[:cleaned_html] = clean
  post.save!
end
