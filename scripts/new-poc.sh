#!/usr/bin/env bash
# usage: scripts/new-poc.sh 01-framing "Telemetry Collector" go|rust
set -euo pipefail
slug=$1 title=$2 lang=$3
platform=$(cd "$(dirname "$0")/.." && pwd)
DS_WORKSPACE=/Users/asadhayat/dev/ds-pocs
dest=$DS_WORKSPACE/ds-poc-$slug

echo $platform
echo $DS_WORKSPACE
echo $dest

cp -r "$platform/template" "$dest"
cp "$platform"/{.gitignore,.gitmessage} "$dest"/
cp -r "$platform/hooks" "$platform/scripts/install-hooks.sh" "$dest"/
sed -i.bak "s/{{POC_TITLE}}/POC $slug — $title/" "$dest/README.md" && rm "$dest/README.md.bak"

cd "$dest" && git init -q
bash install-hooks.sh
case $lang in
  go)   go mod init "github.com/$(gh api user -q .login)/ds-poc-$slug" ;;
  rust) cargo init --name "poc_${slug//-/_}" --vcs none ;;
  *)    echo "lang must be go or rust"; exit 1 ;;
esac