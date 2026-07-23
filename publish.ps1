param(
    [string]$Message = "Update words"
)

$ErrorActionPreference = "Stop"

git status --short
git add index.html README.md publish.ps1 word-app.html
git commit -m $Message
git push

Write-Host "Published. GitHub Pages will update shortly."
