param(
    [string]$TargetPath = "C:\docker\prototype-pipeline-template",
    [string]$RepoName = "prototype-pipeline-template",
    [string]$GitHubOwner = "echofoxx"
)

$ErrorActionPreference = "Stop"

Write-Host "=== Prototype Pipeline Template Install ===" -ForegroundColor Cyan
Write-Host "Target: $TargetPath"
Write-Host "Repo:   $GitHubOwner/$RepoName"

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Error "Docker was not found. Install/start Docker Desktop and try again."
    exit 1
}

if (-not (Test-Path $TargetPath)) {
    New-Item -ItemType Directory -Force -Path $TargetPath | Out-Null
}

Write-Host "`nCopy the extracted package contents into: $TargetPath" -ForegroundColor Yellow
Write-Host "Then run:" -ForegroundColor Yellow
Write-Host "  cd $TargetPath"
Write-Host "  .\ci\local-build.ps1"
Write-Host ""
Write-Host "To connect to GitHub:" -ForegroundColor Yellow
Write-Host "  git init"
Write-Host "  git add ."
Write-Host "  git commit -m 'Initial prototype CI/CD pipeline template'"
Write-Host "  git branch -M main"
Write-Host "  git remote add origin https://github.com/$GitHubOwner/$RepoName.git"
Write-Host "  git push -u origin main"
