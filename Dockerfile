FROM nginx:alpine

LABEL org.opencontainers.image.title="Prototype Pipeline Template"
LABEL org.opencontainers.image.description="Reusable Docker/GitHub Actions starter for echofoxx prototype web apps"
LABEL org.opencontainers.image.source="https://github.com/echofoxx/prototype-pipeline-template"

COPY app/ /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost/health || exit 1
