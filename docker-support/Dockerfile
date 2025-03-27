# Stage 1: Builder (ARM-aware)
FROM --platform=linux/amd64 swift:6.0.3-jammy as builder
COPY . .

# Build for Linux explicitly (Intel binary via Rosetta 2)
RUN swift build -c release --product LiturgicalDocker --static-swift-stdlib

# Stage 2: Runtime (ARM-compatible base image)
FROM ubuntu:22.04
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y libatomic1 && rm -rf /var/lib/apt/lists/*

# Copy Intel binary (works via Rosetta 2)
COPY --from=builder /app/.build/x86_64-unknown-linux-gnu/release/LiturgicalDocker .
COPY --from=builder /app/.build/x86_64-unknown-linux-gnu/release/LiturgicalService_*.resources .

CMD ["./LiturgicalDocker"]


#RUN swift test --filter LiturgicalServiceTests 
#RUN swift test --filter PsalmServiceTests 
#RUN swift test --filter HoursServiceTests
