#!/usr/bin/env bash
# Validate a temporary snapshot before updating any repository files.
set -euo pipefail
cd "$(dirname "$0")"
exec python3 scripts/sync.py
