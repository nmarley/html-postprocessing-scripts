#! /usr/bin/env ruby

require './sebastian'
require 'pp'

puts 'shouldnt have to run this ever again'
exit 2

Sebastian::DB.connect

stat = Sebastian::Stat.first
starting_page = stat.last_archive_page_fetched - 1

apages = Sebastian::ArchivePage.where(indexed_entries: false).order(number: :desc)

# special case
# ap = Sebastian::ArchivePage.find_by(number: 128)

apages.each do |ap|
  posts = Sebastian.parse_archive_page(ap.orig_html)
  posts.each do |meta|
    post = Sebastian::Post.find_or_initialize_by(post_uid: meta[:post_uid])
    post.attributes = meta
    post.save!

    # post = Post.find_by(slug: meta[:slug])
    # pp post
    # if post
    #   post.post_uid = meta[:post_uid]
    #   post.save!
    # else
    #   post = Post.find_or_initialize_by(post_uid: meta[:post_uid])
    #   post.update_attributes(meta)
    # end

  end

 ap.indexed_entries = true
 ap.save

end

