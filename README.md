# HTML Post-Processing Scripts

System for stripping "junk" from HTML and making it easy to print/render to PDF
format. Because blue light from computer screens is hard on my eyes, I like to
print longer web pages/posts and read them on paper. But sometimes it's hard to
print without using the developer tools and stripping away elements from the
HTML. Sometimes lots of elements.  People should really consider print
stylesheets. But alas, we're not there yet.

### For the specific scripts in the 'sebastian' directory:

These are to read Sebastian Marshall's posts from his blog,
sebastianmarshall.com. I get a lot of value out of his writing, but the current
setup doesn't render correctly when trying to print the page(s). Specifically,
there's a big line through the page. I think it has to do with the platform
(Sett), but nevertheless, need to be able to print these and read them.

Wanted to use a Ruby ORM and I like and am familiar with ActiveRecord, but
don't want to do a full-blown Rails app for this.

I also like Rails DB migrations as opposed to managing the DB schema myself.

So, as a result, went with standalone ActiveRecord to reduce (well, eliminate)
learning curve, and the [standalone-migrations](https://github.com/thuss
/standalone-migrations) gem.


#### Sebastian posts - 3 phases of processing (maybe 4)

1. Build index of all old posts, starting w/oldest (above), and going forward
   in time.
1. Fetch all old pages once index is built with URL list... space out fetches
   every few seconds/minutes or so.
1. Then convert all using our scripts.
1. Script the Chrome PDF rendering if possible
