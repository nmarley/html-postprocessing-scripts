require './altucher'
require 'httparty'

# usage: echo 'mailchimp-email-url' | script > out.html
# then view 'out.html' in browser ( echo file://`pwd`/out.html | pbcopy )
# then adjust/remove extra elements and cmd-P
# then save as PDF
# then move to PC
# and then print.

url = ARGF.read
resp = HTTParty.get(url)
html = resp.body
puts Altucher.transform(html)

