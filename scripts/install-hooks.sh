#!/usr/bin/env bash
# scripts/install-hooks.sh — run from the repo root after cloning
set -euo pipefail
chmod +x hooks/*
git config core.hooksPath hooks
git config commit.template .gitmessage
echo "hooks and commit template installed"
