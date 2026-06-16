param(
    [string]$AppName = "prototype-pipeline-template",
    [string]$Port = "8088",
    [switch]$NoCache
)

$ErrorActionPreference = "Stop"

Write-Host "=== Prototype Local CI ===" -ForegroundColor Cyan
Write-Host "App:  $AppName"
Write-Host "Port: $Port"

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Error "Docker was not found. Start Docker Desktop and try again."
    exit 1
}

Write-Host "`n=== Docker Version ===" -ForegroundColor Cyan
docker version

Write-Host "`n=== Stopping existing container, if present ===" -ForegroundColor Cyan
docker compose down

Write-Host "`n=== Building and starting app ===" -ForegroundColor Cyan
if ($NoCache) {
    docker compose build --no-cache
    docker compose up -d
}
else {
    docker compose up -d --build
}

if ($LASTEXITCODE -ne 0) {
    Write-Error "Docker Compose build/start failed."
    exit 1
}

Write-Host "`n=== Smoke Test ===" -ForegroundColor Cyan
Start-Sleep -Seconds 5

$healthUrl = "http://localhost:$Port/health"
$appUrl = "http://localhost:$Port"

try {
    $health = Invoke-WebRequest -Uri $healthUrl -UseBasicParsing
    Write-Host "Health check: $($health.StatusCode) $($health.Content)" -ForegroundColor Green
}
catch {
    Write-Error "Health check failed at $healthUrl"
    docker compose logs --tail=80
    exit 1
}

try {
    $response = Invoke-WebRequest -Uri $appUrl -UseBasicParsing
    Write-Host "App check: $($response.StatusCode)" -ForegroundColor Green
}
catch {
    Write-Error "App smoke test failed at $appUrl"
    docker compose logs --tail=80
    exit 1
}

Write-Host "`n=== Running Containers ===" -ForegroundColor Cyan
docker compose ps

Write-Host "`nLocal pipeline completed successfully." -ForegroundColor Green
Write-Host "Open: $appUrl" -ForegroundColor Yellow
