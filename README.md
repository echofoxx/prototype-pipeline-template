# Prototype Pipeline Template

Reusable Docker Desktop + GitHub Actions + GitHub Container Registry starter kit for `echofoxx` prototype web apps.

This package is intended for quick prototype efforts such as:

- Standalone HTML dashboards
- SPOG proof-of-concept dashboards
- AI-ready standards assessment tools
- SharePoint-hosted HTML prototypes
- Small web apps that can be containerized behind NGINX

## What is included

```text
prototype-pipeline-template/
  app/
    index.html
  ci/
    local-build.ps1
    release.ps1
  scripts/
    install-template.ps1
    deploy-latest.ps1
  .github/
    workflows/
      ci.yml
  Dockerfile
  docker-compose.yml
  nginx.conf
  README.md
  INSTALL.md
  CHANGELOG.md
```

## Quick start on Windows with Docker Desktop

Extract the ZIP to:

```powershell
C:\docker\prototype-pipeline-template
```

Then run:

```powershell
cd C:\docker\prototype-pipeline-template
.\ci\local-build.ps1
```

Open:

```text
http://localhost:8088
```

## Replace the sample app

Put your prototype web app files in:

```text
app/
```

For a single-file app, replace:

```text
app/index.html
```

Then rebuild:

```powershell
.\ci\local-build.ps1
```

## Push to GitHub

Create a GitHub repo named:

```text
prototype-pipeline-template
```

Then run:

```powershell
git init
git add .
git commit -m "Initial prototype CI/CD pipeline template"
git branch -M main
git remote add origin https://github.com/echofoxx/prototype-pipeline-template.git
git push -u origin main
```

## Create a release tag

```powershell
.\ci\release.ps1 -Version v0.1.0
```

GitHub Actions will build the image and publish it to:

```text
ghcr.io/echofoxx/prototype-pipeline-template:latest
ghcr.io/echofoxx/prototype-pipeline-template:v0.1.0
```

## Deploy the latest GHCR image

After the GitHub Actions workflow publishes the image:

```powershell
.\scripts\deploy-latest.ps1
```

## Recommended versioning

```text
v0.1.0 = first runnable prototype
v0.2.0 = import/export and dashboard enhancements
v0.3.0 = role views/security/hardening
v1.0.0 = demo-ready release
```

## Notes

- Docker Desktop must be running.
- The default local port is `8088`.
- If port `8088` is already in use, edit `docker-compose.yml` and the script parameter.
- The GitHub Actions workflow publishes to GitHub Container Registry under the `echofoxx` namespace.
