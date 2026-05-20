# FeedMob Publish

内部 HTML 发布工具。通过 Claude Code Skill 一键发布 HTML 页面到受控访问的内部站点。

## 安装

```bash
git clone https://github.com/RachelXiaolan/feedmob-publish.git ~/.claude/skills/feedmob-publish
```

## 首次使用：注册

打开注册页面，使用公司 Google 账号登录即可完成注册：

https://feedmob-publish.rachel-lu.workers.dev/register

1. 点击链接 → 使用 @feedmob.com Google 账号登录
2. 输入你的名字
3. 页面显示 API Key（点击可复制）

然后添加到 shell 配置：

```bash
echo 'export FEEDMOB_PUBLISH_KEY=<你的key>' >> ~/.zshrc
source ~/.zshrc
```

或者直接把 Key 粘贴给 Claude agent，它会帮你配置。

## 使用

在 Claude Code 中直接说：

- "帮我发布这个 HTML"
- "列出我发布的页面"
- "删除某个页面"

## 浏览已发布页面

所有 @feedmob.com 成员可通过 Gallery 页面查看团队发布的所有内容：

https://feedmob-publish.rachel-lu.workers.dev/gallery

支持按作者筛选、按时间排序。

## 访问控制

发布后的页面链接只有 @feedmob.com 的同事才能访问（打开链接时需要 Google 账号登录验证，24 小时内有效）。

## 管理后台

管理员可通过以下页面查看发布记录、访问日志、管理用户和页面：

https://feedmob-publish.rachel-lu.workers.dev/admin
