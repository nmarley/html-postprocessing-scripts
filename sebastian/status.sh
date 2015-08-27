#! /bin/bash


echo 'select slug, posted_at, length(orig_html) as size, fetched_at from posts order by posted_at\x\g\x' | psql -U sebastmarsh sebastmarsh_dev


