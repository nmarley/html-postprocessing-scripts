

Wanted to use a Ruby ORM and I like and am familiar with ActiveRecord, but
don't want to do a full-blown Rails app for this.

I also like Rails DB migrations as opposed to managing the DB schema myself.

So, as a result, went with standalone ActiveRecord to reduce (well, eliminate)
learning curve, and the [standalone-migrations](https://github.com/thuss
/standalone-migrations) gem.



# archive page url, currently the oldest
http://sebastianmarshall.com/page/146

# 3 phases (maybe 4)

1. Build index of all old posts, starting w/oldest (above), and going forward
   in time.
1. Fetch all old pages once index is built with URL list... space out fetches
   every few seconds/minutes or so.
1. Then convert all using our scripts.
1. Script the Chrome PDF rendering if possible


