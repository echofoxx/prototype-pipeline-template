param(
    [Parameter(Mandatory=$true)]
    [string]$Version,

    [string]$Remote = "origin"
)

$ErrorActionPreference = "Stop"

if ($Version -notmatch '^v\d+\.\d+\.\d+$') {
    Write-Error "Version must use semantic tag format like v0.1.0"
    exit 1
}

Write-Host "=== Creating release tag $Version ===" -ForegroundColor Cyan

$dirty = git status --porcelain
if ($dirty) {
    Write-Error "Working tree has uncommitted changes. Commit or stash changes before tagging."
    exit 1
}

git tag $Version
git push $Remote $Version

Write-Host "Release tag pushed: $Version" -ForegroundColor Green
Write-Host "GitHub Actions should now build and publish the image." -ForegroundColor Yellow
