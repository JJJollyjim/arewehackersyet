#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash curl gzip ruby jq cacert
set -euo pipefail
packages="$(mktemp -u)"

curl -Ss --fail https://mirror.fsmg.org.nz/kali/dists/kali-rolling/main/binary-amd64/Packages.gz | gunzip - > "$packages"

ruby --encoding utf-8 parse-kali.rb < "$packages" > kali-groups.json
ruby --encoding utf-8 parse-kali-descs.rb < "$packages" > kali-descriptions.json

rm "$packages"
