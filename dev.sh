#!/bin/bash
docker run --rm -it \
  -v "$(pwd):/app" \
  -w /app \
  -p 8080:8080 \
  swift:6.0.3-jammy \
  bash