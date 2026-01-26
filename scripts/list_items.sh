#!/usr/bin/env bash
set -e

TOKEN="$1"
WORKSPACE_ID="$2"

curl -s \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  "https://api.fabric.microsoft.com/v1/workspaces/$WORKSPACE_ID/items" \
| jq '.value'