#! /usr/bin/env ruby

require './arec'
require './sebastian'
require 'pp'

posts = Post.where(cleaned_html: '').each do |post|
  html = post.orig_html
  clean = Sebastian.transform(html)

  post[:cleaned_html] = clean
  post.save!
end
