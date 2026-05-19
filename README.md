# FeedMob Publish

内部 HTML 发布工具。通过 Claude Code Skill 一键发布 HTML 页面到受控访问的内部站点。

## 安装

```bash
git clone https://github.com/RachelXiaolan/feedmob-publish.git ~/.claude/skills/feedmob-publish
```

## 首次使用：注册

运行注册脚本，用 @feedmob.com 邮箱验证身份：

```bash
bash ~/.claude/skills/feedmob-publish/scripts/register.sh
```

按提示输入名字和邮箱，收到验证码后输入，即可获得 API Key。

然后添加到 shell 配置：

```bash
echo 'export FEEDMOB_PUBLISH_KEY=<你的key>' >> ~/.zshrc
source ~/.zshrc
```

## 使用

在 Claude Code 中直接说：

- "帮我发布这个 HTML"
- "列出我发布的页面"
- "删除某个页面"

或手动调用脚本：

```bash
# 发布
bash scripts/publish.sh ./report.html --title "月度报告"

# 列表
bash scripts/list.sh

# 删除
bash scripts/delete.sh <page_id>
```

## 访问控制

发布后的页面链接只有 @feedmob.com 邮箱才能访问（通过邮箱 OTP 验证）。
