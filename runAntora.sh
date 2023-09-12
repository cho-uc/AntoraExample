#!/bin/bash

export NODE_TLS_REJECT_UNAUTHORIZED=0
rm -rf public
rm -rf build

antora --fetch --attribute page-pagination= --to-dir public --stacktrace antora-playbook.yml
