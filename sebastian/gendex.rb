#! /usr/bin/env ruby

require 'pp'
require 'erb'

Dir.chdir('site')
entries = Dir.glob("page*")

@gendex = ""
entries.sort_by { |ent| (ent.sub /^page/, '').to_i }.each do |p|
  @gendex += "<a href=\"#{p}\">#{p}</a><br>\n"
end

fn = "index.html"
File.open(fn, 'w') do |f|
  erb = ERB.new(File.read('../gendex.html.erb'))
  f.puts erb.result binding
end

