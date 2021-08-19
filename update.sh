#!/bin/bash

current_date=$(date +"%d%m%Y%H%M%S")
git add -A
git commit -m "backup current datetime is: $current_date"
git push
