#!/bin/bash
set -e

API_URL="https://feedmob-publish.rachel-lu.workers.dev"
API_KEY="${FEEDMOB_PUBLISH_KEY:-}"

if [ -z "$API_KEY" ]; then
  echo "ERROR: FEEDMOB_PUBLISH_KEY not set"
  exit 1
fi

RESPONSE=$(curl -s -w "\n%{http_code}" "$API_URL/api/pages" \
  -H "Authorization: Bearer $API_KEY")

HTTP_CODE=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | sed '$d')

if [ "$HTTP_CODE" -eq 200 ]; then
  echo "$BODY"
else
  echo "ERROR (HTTP $HTTP_CODE): $BODY"
  exit 1
fi
