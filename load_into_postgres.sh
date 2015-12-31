#!/bin/bash -ex
python add_lemmas.py | tugboat ssh vocabincontext -c "sudo -u postgres /usr/bin/psql"
ruby generate_sql.rb | tugboat ssh vocabincontext -c "sudo -u postgres /usr/bin/psql"
