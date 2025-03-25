FROM swift:6.0.3-jammy
WORKDIR /app
COPY . .

# 1. Single build with testability and release
RUN swift build \
    -c release \
    --product LiturgicalDocker \
    -Xswiftc -enable-testing  # Allows testing if needed

# 2. [Optional] Add test step (comment out if not needed)
#RUN swift test --enable-test-discovery --parallel

#ENTRYPOINT ["./.build/release/LiturgicalDocker"]
CMD ["./.build/release/LiturgicalDocker"]