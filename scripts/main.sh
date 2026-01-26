#!/usr/bin/env bash
set -e

TOKEN=$(./scripts/auth.sh)

workspaces=$(./scripts/list_workspaces.sh "$TOKEN")

for row in $(echo "$workspaces" | jq -r '.[] | @base64'); do
  ws=$(echo "$row" | base64 --decode)
  ws_id=$(echo "$ws" | jq -r '.id')
  ws_name=$(echo "$ws" | jq -r '.displayName')

  echo "Evaluating workspace: $ws_name"

  items=$(./scripts/list_items.sh "$TOKEN" "$ws_id")

  ./scripts/evaluate_policy.sh "$ws" "$items"
done
