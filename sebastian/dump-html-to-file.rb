#! /usr/bin/env ruby

require './sebastian'
require 'pp'

uid = ARGV.shift
if (uid.nil? || (0 == uid.length))
  $stderr.puts "error: no arg given."
  exit 2
end

Sebastian::DB.connect
p = Sebastian::Post.find_by(post_uid: uid)
p.write_html


