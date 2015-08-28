#! /usr/bin/env ruby

require './sebastian'
Sebastian::DB.connect

# http://sebastianmarshall.com/page/146

# fetch stats/metadata
stat = Sebastian::Stat.first
starting_page = stat.last_archive_page_fetched - 1

(1..starting_page).to_a.reverse.each do |num|
  url = Sebastian::ROOT + "page/#{num}"
  html = Sebastian.fetch(url).body
  fetched_at = Time.now.getutc
  stat.last_archive_page_fetched = num

  ap = Sebastian::ArchivePage.find_or_initialize_by(number: num)
  ap.fetched_at = fetched_at
  ap.orig_html = html
  ap.save!

  stat.save

  sleep rand(3..8)
end
