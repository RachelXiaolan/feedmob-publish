#!/bin/bash
set -e

API_URL="https://feedmob-publish.rachel-lu.workers.dev"
API_KEY="${FEEDMOB_PUBLISH_KEY:-}"

if [ -z "$API_KEY" ]; then
  echo "ERROR: FEEDMOB_PUBLISH_KEY not set"
  echo "请联系 Rachel 获取 API Key，然后添加到 ~/.zshrc:"
  echo "  export FEEDMOB_PUBLISH_KEY=your_key_here"
  exit 1
fi

FILE_PATH=""
TITLE=""
ACCESS_LEVEL="otp"

while [[ $# -gt 0 ]]; do
  case $1 in
    --title) TITLE="$2"; shift 2 ;;
    --access) ACCESS_LEVEL="$2"; shift 2 ;;
    *) FILE_PATH="$1"; shift ;;
  esac
done

if [ -z "$FILE_PATH" ]; then
  echo "ERROR: No file path provided"
  echo "Usage: publish.sh <file_path> [--title \"Title\"] [--access otp|oauth]"
  exit 1
fi

if [ ! -f "$FILE_PATH" ]; then
  echo "ERROR: File not found: $FILE_PATH"
  exit 1
fi

if [ -z "$TITLE" ]; then
  TITLE="$(basename "$FILE_PATH" .html)"
fi

RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_URL/api/publish" \
  -H "Authorization: Bearer $API_KEY" \
  -F "file=@$FILE_PATH" \
  -F "title=$TITLE;type=text/plain;charset=utf-8" \
  -F "access_level=$ACCESS_LEVEL")

HTTP_CODE=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | sed '$d')

if [ "$HTTP_CODE" -eq 201 ]; then
  echo "$BODY"
else
  echo "ERROR (HTTP $HTTP_CODE): $BODY"
  exit 1
fi
