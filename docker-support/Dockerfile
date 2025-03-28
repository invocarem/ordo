
#RUN swift test --filter LiturgicalServiceTests 
#RUN swift test --filter PsalmServiceTests 
#RUN swift test --filter HoursServiceTests
# Stage 1: Builder


FROM swift:6.0.3-jammy as builder

# Handle line endings across platforms
RUN apt-get update && apt-get install -y dos2unix

WORKDIR /app
COPY . .

# Convert line endings for Windows compatibility
RUN find . -type f -name "*.swift" -exec dos2unix {} \; && \
    dos2unix Package.swift

RUN swift build -c release --product LiturgicalDocker --static-swift-stdlib


FROM swift:6.0.3-jammy

WORKDIR /app
COPY --from=builder /app/.build/x86_64-unknown-linux-gnu/release/LiturgicalDocker .

# Create resource directory structure
RUN mkdir -p /app/LiturgicalService_PsalmService.resources
RUN mkdir -p /app/LiturgicalService_HoursService.resources

# Copy resources (adjust paths as needed)
COPY --from=builder /app/ordo/Services/PsalmService/psalms.json /app/LiturgicalService_PsalmService.resources/
COPY --from=builder /app/ordo/Services/HoursService/horas.json /app/LiturgicalService_HoursService.resources/

CMD ["./LiturgicalDocker"]