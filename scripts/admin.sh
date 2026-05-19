#!/bin/bash
set -e

API_URL="https://feedmob-publish.rachel-lu.workers.dev"
API_KEY="${FEEDMOB_PUBLISH_KEY:-}"

if [ -z "$API_KEY" ]; then
  echo "ERROR: FEEDMOB_PUBLISH_KEY not set"
  exit 1
fi

COMMAND="$1"
shift || true

case "$COMMAND" in
  create-user)
    EMAIL=""
    NAME=""
    while [[ $# -gt 0 ]]; do
      case $1 in
        --email) EMAIL="$2"; shift 2 ;;
        --name) NAME="$2"; shift 2 ;;
        *) shift ;;
      esac
    done
    if [ -z "$EMAIL" ] || [ -z "$NAME" ]; then
      echo "ERROR: --email and --name required"
      echo "Usage: admin.sh create-user --email user@feedmob.com --name \"Name\""
      exit 1
    fi
    RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_URL/api/admin/users" \
      -H "Authorization: Bearer $API_KEY" \
      -H "Content-Type: application/json" \
      -d "{\"email\":\"$EMAIL\",\"name\":\"$NAME\"}")
    ;;
  list-users)
    RESPONSE=$(curl -s -w "\n%{http_code}" "$API_URL/api/admin/users" \
      -H "Authorization: Bearer $API_KEY")
    ;;
  list-pages)
    RESPONSE=$(curl -s -w "\n%{http_code}" "$API_URL/api/admin/pages" \
      -H "Authorization: Bearer $API_KEY")
    ;;
  logs)
    QUERY=""
    while [[ $# -gt 0 ]]; do
      case $1 in
        --page-id) QUERY="?page_id=$2"; shift 2 ;;
        --limit) QUERY="${QUERY:+$QUERY&}limit=$2"; shift 2 ;;
        *) shift ;;
      esac
    done
    RESPONSE=$(curl -s -w "\n%{http_code}" "$API_URL/api/admin/logs$QUERY" \
      -H "Authorization: Bearer $API_KEY")
    ;;
  delete-user)
    USER_ID="$1"
    if [ -z "$USER_ID" ]; then
      echo "ERROR: user_id required"
      exit 1
    fi
    RESPONSE=$(curl -s -w "\n%{http_code}" -X DELETE "$API_URL/api/admin/users/$USER_ID" \
      -H "Authorization: Bearer $API_KEY")
    ;;
  *)
    echo "Usage: admin.sh <command>"
    echo "Commands: create-user, list-users, list-pages, logs, delete-user"
    exit 1
    ;;
esac

HTTP_CODE=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | sed '$d')

if [ "$HTTP_CODE" -ge 200 ] && [ "$HTTP_CODE" -lt 300 ]; then
  echo "$BODY"
else
  echo "ERROR (HTTP $HTTP_CODE): $BODY"
  exit 1
fi
