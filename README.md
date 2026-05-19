# FeedMob Publish

内部 HTML 发布工具。通过 Claude Code Skill 一键发布 HTML 页面到受控访问的内部站点。

## 安装

```bash
git clone https://github.com/RachelXiaolan/feedmob-publish.git ~/.claude/skills/feedmob-publish
```

## 首次使用：注册

打开注册页面，用 @feedmob.com 邮箱验证身份：

https://feedmob-publish.rachel-lu.workers.dev/register

1. 输入名字和公司邮箱
2. 收到验证码后输入
3. 页面会显示你的 API Key（点击可复制）

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

## 访问控制

发布后的页面链接只有 @feedmob.com 邮箱才能访问（打开链接时需要邮箱 OTP 验证，24 小时内有效）。
