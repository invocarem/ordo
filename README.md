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

can you define conceptual themes?
I have defined 7 categories in the level  good to bad: divine, justice,  worship, virtue, sin, conflict, opposition. divine and justice are for God, worship or virtual are for saints or freeman, sin, conflict and opposition are for slaves of god, opposition is worst.

@Psalm148Tests.swift, verify line 6 the lemma for statuto? is it statuo?

```
nohup ollama serve > ~/ollama.log 2>&1 &
```

Generate @Psalm78Tests.swift following @Psalm1Tests.swift. psalm Latin text can be found in  PsalmService/psalms.json, englishText can be found in the same file. the first test is make sure verse total is 15 according to Benedictine Office. the second test is line by line lemma. The third test is build structural themes, that is group every two verses into one theme, 1-2,3-4,5-6,..., if the psalm has odd numbers, you can group last 3 as one theme. name as a->b pattern, description please do NOT use From..To pattern.  'comment' is general meaning of the 2 verses, 'comment2' is Augustine's theogy lens (expositions). The 4th test is build concepture themes,  which mean see the psalm as different images or concepts, we define 7 ThemeCategory from highest to lowest: divine, justice, worship, virtue, sin, conflict, opposition. The last test will be generate JSON file for texts and themes.