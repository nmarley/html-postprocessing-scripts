#! /bin/bash

echo 'select slug, post_uid, posted_at, length(orig_html) as size, fetched_at
from posts
where 1 = 1
--  and length(orig_html) > 0
--  and post_uid is null
-- where length(orig_html) = 0
order by posted_at
\x\g\x' | psql -U sebastmarsh sebastmarsh_dev

