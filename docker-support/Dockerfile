FROM swift:5.9-jammy
WORKDIR /app
COPY . .

# 1. Build main library with testability
RUN swift build \
    --target LiturgicalService \
    -Xswiftc -enable-testing

# 2. Run specific test target (correct syntax)
RUN swift test \
    --enable-test-discovery \
    --parallel \
    --filter LiturgicalServiceTests  # 👈 Correct way to specify test target

# 3. Build release executable
RUN swift build -c release --product LiturgicalDocker

ENTRYPOINT ["./.build/release/LiturgicalDocker"]
