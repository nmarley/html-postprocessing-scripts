require 'nokogiri'
require 'awesome_print'
require 'pp'

fn = 'index.html'
html = File.read(fn)

#ap html


def strip_crap(html)
  re = /(.*)<!--\ BEGIN\ PREHEADER\ \/\/\ -->(?:[^\n]*\n)
        (.*)<!--\ \/\/\ END\ PREHEADER\ -->(?:[^\n]*\n)(.*)
       /sxum
        # (.*)END(.*)
        # <!--\ END\ PRE/sxu
  # re = /<!--\ BEGIN\ PREHEADER\ \/\/\ -->(?:[^\n]*\n)(.*?)<!--\ \/\/\ END\ PREHEADER\ -->\n/msxu

  new_html = html.sub(re) do |m|
    puts $3
    puts 'hi'
  end
end


strip_crap(html)

__END__
<!-- BEGIN PREHEADER // -->
<!-- // END PREHEADER -->
<!-- BEGIN HEADER // -->
<!-- // END HEADER -->
<!-- BEGIN FOOTER // -->
<!-- // END FOOTER -->
