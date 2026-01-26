#!/usr/bin/env bash
set -e

if [[ -z "$FABRIC_TOKEN" ]]; then
  echo "FABRIC_TOKEN not set"
  exit 1
fi

echo "$FABRIC_TOKEN"