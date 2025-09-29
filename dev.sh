#!/bin/bash

# Auto-detect Windows and convert path if needed
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    echo "Windows detected"
    if command -v cygpath &> /dev/null; then
        HOST_PATH=$(cygpath -w "$(pwd)")
        echo "Using cygpath: $HOST_PATH"
    elif pwd -W &> /dev/null; then
        HOST_PATH=$(pwd -W)
        echo "Using pwd -W: $HOST_PATH"
    else
        HOST_PATH=$(pwd)
        echo "Using regular pwd: $HOST_PATH"
    fi
    export MSYS2_ARG_CONV_EXCL="*" 2>/dev/null || true

     docker run --rm -it \
      -v "${HOST_PATH}:/app" \
      -w /app \
      -p 8084:8080 \
      swift:6.0.3-jammy \
      bash
else
    # Linux/macOS
    HOST_PATH=$(pwd)
    echo "Unix detected: $HOST_PATH"
    docker run --rm -it \
      -v "${HOST_PATH}:/app" \
      -w /app \
      -p 8084:8080 \
      swift:6.0.3-jammy \
      bash
fi

