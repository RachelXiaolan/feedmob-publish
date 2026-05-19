---
name: feedmob-publish
description: Publish HTML files to FeedMob's internal site with access control. Use when team members want to publish, share, list, or manage HTML pages on the internal platform. Triggers on "publish HTML", "发布HTML", "upload to internal site", "发布到内部站点", "list my pages", "我的页面", or manage published content.
---

# FeedMob Publish

Publish HTML files to FeedMob's internal platform. Published pages are protected by Cloudflare Access — only @feedmob.com email holders can view them via OTP verification.

## Setup

Users need the environment variable `FEEDMOB_PUBLISH_KEY` set in their shell profile.

If not set, run the self-registration script:

```bash
bash scripts/register.sh
```

This will ask for name and @feedmob.com email, send a verification code, and return an API key. The user then adds it to ~/.zshrc:

```bash
export FEEDMOB_PUBLISH_KEY=<returned_key>
```

## Commands

### Publish HTML

When the user wants to publish an HTML file:

```bash
bash scripts/publish.sh <file_path> [--title "Page Title"] [--access otp|oauth]
```

- `file_path`: path to the HTML file (required)
- `--title`: display title (defaults to filename)
- `--access`: access level, `otp` (default) or `oauth` for stricter control

Returns a URL that can be shared with @feedmob.com team members.

### List My Pages

```bash
bash scripts/list.sh
```

Shows all pages published by the current user.

### Delete a Page

```bash
bash scripts/delete.sh <page_id>
```

### Admin Commands (Rachel only)

```bash
bash scripts/admin.sh create-user --email user@feedmob.com --name "User Name"
bash scripts/admin.sh list-users
bash scripts/admin.sh list-pages
bash scripts/admin.sh logs [--page-id <id>] [--limit 50]
bash scripts/admin.sh delete-user <user_id>
```

## Workflow

1. User says "publish this HTML" or "发布这个页面"
2. Check `FEEDMOB_PUBLISH_KEY` env var exists
3. Run `publish.sh` with the file path
4. Return the generated URL to the user
5. Inform them: "链接已生成，@feedmob.com 邮箱的同事打开后通过邮箱验证即可访问"
