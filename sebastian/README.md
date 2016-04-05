# Sebastian posts - 3 main phases of processing

### To update database with new posts (scrapes sebastianmarshall.com):

( Run all these in this order )

1. ruby update-index.rb
2. ruby fetcher.rb
3. clean.rb

### To generate HTML files from DB:

(First, remove files in site/html/ if you want them to be re-generated.)

1. build.rb

### To deploy site:

1. ./deploy.sh

