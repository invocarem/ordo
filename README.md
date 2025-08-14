# ordo


# remove all images
```
docker system prune -af
rm -rf .build
swift package clean
```

# build docker images
```
docker build -f docker-support/Dockerfile -t liturgical-service .
```

# how to run 
```
# app/.build/release/LiturgicalDocker

# Enter container to debug:
docker run -it --rm --entrypoint bash liturgical-service

```

# docker build and run test
```

# Build and run tests in one step
docker build -f docker-support/Dockerfile.test -t liturgical-test .
docker run --rm liturgical-test
```

# test in docker
```
 docker run --rm -it -v "$(pwd):/app" -w /app swift:6.0.3-jammy bash
 # swift test --filter "Psalm144Tests"
```


# build
```
 xcrun xctrace list devices
security find-identity -v -p codesigning

```


