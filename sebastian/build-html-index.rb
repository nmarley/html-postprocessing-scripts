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


build_page_indexes()


