#!/usr/bin/env bash
set -e

WORKSPACE_JSON="$1"
ITEMS_JSON="$2"
POLICY_FILE="config/policy.json"

capacityId=$(echo "$WORKSPACE_JSON" | jq -r '.capacityId // empty')

if [[ -z "$capacityId" ]]; then
  echo "FAIL: Workspace has no capacity"
  exit 1
fi

allowed=$(jq -r '.allowedCapacityIds[]' "$POLICY_FILE" | grep -c "$capacityId" || true)

if [[ "$allowed" -eq 0 ]]; then
  echo "FAIL: Workspace on unapproved capacity $capacityId"
  exit 1
fi

for disallowed in $(jq -r '.disallowedItemTypes[]' "$POLICY_FILE"); do
  count=$(echo "$ITEMS_JSON" | jq "[.[] | select(.type == \"$disallowed\")] | length")
  if [[ "$count" -gt 0 ]]; then
    echo "FAIL: Disallowed item type $disallowed found"
    exit 1
  fi
done

lakehouse_count=$(echo "$ITEMS_JSON" | jq '[.[] | select(.type=="Lakehouse")] | length')
max_lakehouses=$(jq -r '.maxLakehouses' "$POLICY_FILE")

if [[ "$lakehouse_count" -gt "$max_lakehouses" ]]; then
  echo "FAIL: Too many Lakehouses ($lakehouse_count)"
  exit 1
fi

echo "PASS"
