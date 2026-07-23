param(
    [string]$Message = "Update app"
)

$ErrorActionPreference = "Continue"

# 关键修复:git add -A 会把仓库里所有改动一起加入,包括 bobo\index.html(真正的 App 文件)。
# 之前的清单 (git add index.html README.md publish.ps1 word-app.html) 漏了 bobo\index.html,
# 所以每次发布 App 都没被推上去,手机端一直停在旧版本。
git add -A
git commit -m $Message
git push

Write-Host ""
Write-Host "===================================================================="
Write-Host " 看上面 git push 的结果:"
Write-Host "  出现 'main -> main'      = App 已成功推送,1-2 分钟后线上更新"
Write-Host "  出现 'Everything up-to-date' 且没有 main->main = 这次没有新改动"
Write-Host "  出现 'Failed to connect'  = 网络没连上,过一会儿再跑一次本命令"
Write-Host "===================================================================="
