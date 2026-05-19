#!/bin/bash
set -e

API_URL="https://feedmob-publish.rachel-lu.workers.dev"

echo "=== FeedMob Publish 注册 ==="
echo ""

read -p "你的名字: " NAME
read -p "公司邮箱 (@feedmob.com): " EMAIL

if [[ "$EMAIL" != *@feedmob.com ]]; then
  echo "ERROR: 只支持 @feedmob.com 邮箱"
  exit 1
fi

echo ""
echo "正在发送验证码到 $EMAIL ..."

RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_URL/api/register/request" \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"$EMAIL\",\"name\":\"$NAME\"}")

HTTP_CODE=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | sed '$d')

if [ "$HTTP_CODE" -ne 200 ]; then
  echo "ERROR: $BODY"
  exit 1
fi

echo "验证码已发送，请检查邮箱。"
echo ""
read -p "输入 6 位验证码: " CODE

RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_URL/api/register/verify" \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"$EMAIL\",\"name\":\"$NAME\",\"code\":\"$CODE\"}")

HTTP_CODE=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | sed '$d')

if [ "$HTTP_CODE" -ne 200 ]; then
  echo "ERROR: $BODY"
  exit 1
fi

API_KEY=$(echo "$BODY" | grep -o '"api_key":"[^"]*"' | cut -d'"' -f4)

echo ""
echo "注册成功！"
echo ""
echo "你的 API Key: $API_KEY"
echo ""
echo "请添加到 ~/.zshrc:"
echo "  export FEEDMOB_PUBLISH_KEY=$API_KEY"
echo ""
echo "然后运行: source ~/.zshrc"
