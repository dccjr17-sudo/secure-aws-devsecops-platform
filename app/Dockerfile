FROM python:3.13-alpine

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8080

WORKDIR /app

RUN addgroup -S appgroup \
    && adduser -S -G appgroup -h /app appuser

COPY requirements.txt ./

RUN pip install --no-cache-dir --disable-pip-version-check --requirement requirements.txt

COPY --chown=appuser:appgroup src ./src
COPY --chown=appuser:appgroup tests ./tests

USER appuser

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD python -c "from urllib.request import urlopen; urlopen('http://127.0.0.1:8080/health', timeout=2)"

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "--workers", "2", "--access-logfile", "-", "--error-logfile", "-", "src.app:create_app()"]
