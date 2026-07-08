# 单词背诵 App

这是一个可直接部署到 GitHub Pages 的纯静态网页应用。

## 线上入口

普通单词背诵 App：

```text
https://dasheng1999-ui.github.io/hong-kong-english-app/
```

BoBoApp 网页版：

```text
https://dasheng1999-ui.github.io/hong-kong-english-app/bobo/
```

## 在线发布方式

首次发布需要：

1. 登录 GitHub CLI：
   ```powershell
   gh auth login
   ```
2. 创建 GitHub 仓库并推送代码。
3. 开启 GitHub Pages，发布分支选择 `main`，目录选择 `/root`。

发布完成后，访问地址一般是：

```text
https://你的GitHub用户名.github.io/仓库名/
```

## 更新单词

打开 `index.html`，找到这一段：

```js
const wordGroups = [
```

新增卡组时，在数组里添加：

```js
{
    name: "新卡组名称",
    words: [
        {
            word: "example",
            meanInText: "示例；例子",
            sentence: "This is an example sentence.",
            sentenceCn: "这是一个示例句子。",
            fullInfo: "n. 示例；例句：Please give me an example."
        }
    ]
}
```

新增或修改后，运行：

```powershell
.\publish.ps1 "新增一批单词"
```

脚本会提交代码并推送到 GitHub。GitHub Pages 通常会在几十秒到几分钟内自动更新网页。

## 本地预览

```powershell
python -m http.server 8787
```

然后打开：

```text
http://127.0.0.1:8787/
```
