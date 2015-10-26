#! /bin/bash

. ./.env

# copy
rsync -avz -e ssh --delete html/ "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}"

