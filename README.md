# ordo


# remove all images
```
docker system prune -af
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
