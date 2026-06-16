param(
    [string]$Image = "ghcr.io/echofoxx/prototype-pipeline-template:latest",
    [string]$ContainerName = "prototype-pipeline-template",
    [string]$Port = "8088"
)

$ErrorActionPreference = "Stop"

Write-Host "=== Deploy Latest Prototype Image ===" -ForegroundColor Cyan
Write-Host "Image: $Image"
Write-Host "Port:  $Port"

docker pull $Image

docker rm -f $ContainerName 2>$null | Out-Null

docker run -d `
  --name $ContainerName `
  --restart unless-stopped `
  -p "$Port`:80" `
  $Image

Start-Sleep -Seconds 5
Invoke-WebRequest -Uri "http://localhost:$Port/health" -UseBasicParsing | Out-Null

Write-Host "Deployment complete." -ForegroundColor Green
Write-Host "Open: http://localhost:$Port" -ForegroundColor Yellow
