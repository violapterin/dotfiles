#!/usr/bin/env bash

# Credits: http://stackoverflow.com/a/750191

git filter-branch -f --env-filter "
    GIT_AUTHOR_NAME='Raven I. Pilot'
    GIT_AUTHOR_EMAIL='violapterin@gmail.com'
    GIT_COMMITTER_NAME='Raven I. Pilot'
    GIT_COMMITTER_EMAIL='violapterin@gmail.com'
  " HEAD
