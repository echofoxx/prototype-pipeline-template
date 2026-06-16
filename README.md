Local Dev on Docker Desktop
        ↓
Git commit / push to GitHub
        ↓
GitHub Actions CI
  - lint / test
  - build Docker image
  - scan image
  - publish image to GHCR
        ↓
Optional CD
  - deploy to local Docker Desktop
  - deploy to lab VM
  - deploy to VPS / internal server