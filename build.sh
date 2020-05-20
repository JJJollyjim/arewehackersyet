#!/bin/sh
cd "$(mktemp -d)"

wget https://mirror.fsmg.org.nz/kali/dists/kali-rolling/main/binary-amd64/Packages

ruby parse-kali.rb Packages > kali-groups.json
ruby parse-kali-descs.rb Packages > kali-descriptions.json
