@echo off
docker run --rm -it -v "%cd%:/app" -w /app swift:6.0.3-jammy bash