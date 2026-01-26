#!/usr/bin/env bash
set -e

TOKEN="$1"

curl -s \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  https://api.fabric.microsoft.com/v1/workspaces \
| jq '[.value[] | select(.type != "Personal")]'