#!/bin/sh
ruby parse-kali.rb Packages > kali-groups.json
ruby parse-kali-descs.rb Packages > kali-descriptions.json
# < kali-groups.json jq -r '.[] | .[]' | sort | uniq > kali-tools
