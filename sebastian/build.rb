#! /usr/bin/env ruby

require './sebastian'
require 'erb'
require 'pp'

Sebastian::DB.connect
PerPage = 100

def get_ul(page_num, per_page = 10)
  ul = ''
  ul += '<ul class="post-list">' + "\n"
  get_page(page_num, per_page).each do |a|
    ul += "<li>" + a + "</li>\n"
  end
  ul += '</ul>' + "\n"
  ul
end

def get_page(page_num, per_page = 10)
  list = []
  Sebastian::Post.order(:posted_at)
    .select(:posted_at, :slug, :post_uid)
    .paginate(page: page_num, per_page: per_page)
    .each do |post|

    ddate = post.posted_at.strftime("%Y-%m-%d %H:%M")
    furl = "/html/#{post.html_filename}"
    atext = "#{ddate} | #{post.slug}"
    a = "<a href=\"#{furl}\">#{atext}</a>"
    list.push( a )
  end
  list
end


def write_posts_to_filesystem
  Sebastian::Post.find_each do |post|
    unless File.exists?("site/html/#{post.post_uid}.html")
      post.write_html
    end
  end
end


def build_page_indexes
  max_pages = (( Sebastian::Post.count - 1) / PerPage) + 1
  out_dir = './site'

  (1..max_pages).each do |page_num|
    @the_list = get_ul(page_num, PerPage)

    newdir = File.join(out_dir, "page#{page_num}")
    Dir.exists?(newdir) || Dir.mkdir(newdir)
    abs = File.join(newdir, "index.html")

    File.open(abs, 'w') do |f|
      erb = ERB.new(File.read('index.html.erb'))
      f.puts erb.result binding
    end
  end
end

def build_root_index
  entries = Dir.glob("site/page*")
  @gendex = ""
  entries.sort_by { |ent| (ent.sub /^site\/page/, '').to_i }.each do |page|
    page.sub! /^site\//, ''
    @gendex += "<a href=\"#{page}\">#{page}</a><br>\n"
  end

  fn = "site/index.html"
  File.open(fn, 'w') do |f|
    erb = ERB.new(File.read('gendex.html.erb'))
    f.puts erb.result binding
  end
end

write_posts_to_filesystem
build_page_indexes
build_root_index
