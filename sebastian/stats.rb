#! /usr/bin/env ruby

require './sebastian'
require 'awesome_print'

Sebastian::DB.connect

total = Sebastian::Post.count
pp [:total, total]

to_fetch = Sebastian::Post.where(orig_html: '').count
pp [:to_fetch, to_fetch]

pct = ((to_fetch.to_d / total.to_d) * 100).to_f.round(2)
puts "Percent Unfinished: #{pct}%"

posts = Sebastian::Post.arel_table

length = Arel::Nodes::NamedFunction.new("LENGTH", [posts[:orig_html]], 'lenn')

p = Sebastian::Post.where("length(orig_html) > 0")
  .order("posted_at desc")
  .limit(1)
  .select(:id, :slug, :post_uid, :posted_at, length).first

pp p, p.lenn

