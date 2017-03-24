#!/usr/bin/env bash

set -x
tmp=$(dirname ./digital_communication_1/xxx)
set +x
hold=$(find "${tmp}" -name '*.tex')
echo ${hold}