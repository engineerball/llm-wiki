#!/usr/bin/env bash
# Start Quartz dev server with hot reload
cd "$(dirname "$0")/../quartz" && npx quartz build -d ../wiki --serve