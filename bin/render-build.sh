#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:clean
bundle exec rake tailwindcss:build
bundle exec rake assets:precompile
bundle exec rake db:migrate
