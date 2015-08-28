#! /usr/bin/env ruby

require './sebastian'
require 'pp'

uid = ARGV.shift
if (uid.nil? || (0 == uid.length))
  $stderr.puts "error: no arg given."
  exit 2
end

require './arec'

# select posted_at, slug from posts order by posted_at limit 70;
p = Post.find_by(post_uid: uid)

html_dir = "#{Dir.pwd}/html"
Dir.exists?(html_dir) || Dir.mkdir(html_dir)

abs = File.join(html_dir, uid + '.html')
File.open(abs, 'w') { |f| f.write( p.cleaned_html ) }

#p.cleaned_html


