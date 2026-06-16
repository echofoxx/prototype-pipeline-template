param(
    [string]$AppName = "prototype-pipeline-template",
    [string]$Port = "8088"
)

Write-Host "=== Building $AppName ==="

docker compose down
docker compose up -d --build

if ($LASTEXITCODE -ne 0) {
    Write-Error "Docker Compose build/start failed."
    exit 1
}

Start-Sleep -Seconds 3

Write-Host "=== Smoke Test ==="

try {
    $response = Invoke-WebRequest -Uri "http://localhost:$Port" -UseBasicParsing
    Write-Host "App is reachable. HTTP Status: $($response.StatusCode)"
}
catch {
    Write-Error "Smoke test failed at http://localhost:$Port"
    exit 1
}

Write-Host "=== Local pipeline completed successfully ==="