#! /bin/bash

echo 'select slug, post_uid, posted_at, length(orig_html) as size, fetched_at
from posts
where length(orig_html) > 0
order by posted_at desc
limit 1
\x\g\x' | psql -U sebastmarsh sebastmarsh_dev

