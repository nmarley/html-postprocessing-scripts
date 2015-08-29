#! /usr/bin/env ruby

require 'pp'
require 'erb'

def build_root_index
  entries = Dir.glob("site/page*")
  @gendex = ""
  entries.sort_by { |ent| (ent.sub /^site\/page/, '').to_i }.each do |p|
    @gendex += "<a href=\"#{p}\">#{p}</a><br>\n"
  end

  fn = "site/index.html"
  File.open(fn, 'w') do |f|
    erb = ERB.new(File.read('gendex.html.erb'))
    f.puts erb.result binding
  end
end

build_root_index()

