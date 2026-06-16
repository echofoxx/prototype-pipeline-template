# Install Guide

## 1. Prerequisites

Install or confirm:

- Docker Desktop
- Git for Windows
- PowerShell
- GitHub account: `echofoxx`

Start Docker Desktop before running the scripts.

## 2. Extract the package

Recommended location:

```powershell
C:\docker\prototype-pipeline-template
```

## 3. Run the local pipeline

```powershell
cd C:\docker\prototype-pipeline-template
.\ci\local-build.ps1
```

Open:

```text
http://localhost:8088
```

## 4. Customize for a new prototype

Rename the folder and adjust these values:

- `docker-compose.yml`
- `Dockerfile` labels
- `.github/workflows/ci.yml` image naming, if needed
- `README.md`

For most prototypes, you only need to replace files in `app/`.

## 5. Create the GitHub repo

Create a new repo under:

```text
https://github.com/echofoxx
```

Example repo name:

```text
prototype-pipeline-template
```

## 6. Push to GitHub

```powershell
git init
git add .
git commit -m "Initial prototype CI/CD pipeline template"
git branch -M main
git remote add origin https://github.com/echofoxx/prototype-pipeline-template.git
git push -u origin main
```

## 7. Confirm GitHub Actions

In GitHub:

```text
Repo → Actions
```

You should see `Prototype CI/CD` running.

## 8. Confirm GitHub Container Registry package

In GitHub:

```text
Profile → Packages
```

You should see an image package for the repo.

## 9. Tag a release

```powershell
.\ci\release.ps1 -Version v0.1.0
```

## 10. Pull and deploy image later

```powershell
.\scripts\deploy-latest.ps1
```
