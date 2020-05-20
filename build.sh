#!/bin/sh
ruby parse-kali.rb Packages > kali-groups.json
# < kali-groups.json jq -r '.[] | .[]' | sort | uniq > kali-tools
