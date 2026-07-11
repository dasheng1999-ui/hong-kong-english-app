param(
    [string]$Message = "Update BoBo app"
)

$ErrorActionPreference = "Stop"

# 用完整路徑調用 git(唔依賴系統 PATH);搵唔到先退回 PATH 裡嘅 git
$git = "C:\Program Files\Git\cmd\git.exe"
if (-not (Test-Path $git)) { $git = "git" }

& $git status --short
& $git add -A
& $git commit -m $Message
& $git push

Write-Host "Published. GitHub Pages will update in 1-2 minutes."
