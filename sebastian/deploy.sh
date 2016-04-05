#! /bin/bash

. ./.env

# copy
rsync -avz -e ssh --delete site/ "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}"

