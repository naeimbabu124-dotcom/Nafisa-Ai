#!/usr/bin/env bash
set -e
pip install -q -r requirements.txt
if [ ! -d frontend/dist ]; then (cd frontend && npm install && npm run build); fi
exec uvicorn app.main:app --app-dir backend --host 0.0.0.0 --port "${PORT:-8000}" --proxy-headers --forwarded-allow-ips="*"
