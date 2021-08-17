#!/usr/bin/env bash
set -e
source /app/python/.env_vars

if [ -z ${API_PORT} ]; then
    API_PORT="8080"
fi

if [ -z ${API_HOST} ]; then
    API_HOST="127.0.0.1"
fi

uvicorn helloworld:api --host ${API_HOST} --port ${API_PORT}