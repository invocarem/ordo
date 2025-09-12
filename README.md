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

can you follow psalm150tests as a sample to update psalm149tests? a)  to test if the text has  a total  9 verses based on benedict office. b) line by line check lemmas for the 9 verses. c) create structure themes, that is every 2 verses make one theme, name is a -> b pattern, comment is for general meaning, comment 2 is for augustine's expositions.
