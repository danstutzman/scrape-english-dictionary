#!/bin/bash -ex
echo 'select word from words' | /Applications/Postgres.app/Contents/MacOS/bin/psql -t -U postgres > words.txt
