# Stage 1: Build and test
#FROM swift:5.9-jammy as builder  
FROM swift:6.0.3-jammy as builder
WORKDIR /app
COPY . .

# First build dependencies (faster rebuilds when only code changes)
# RUN swift build --product LiturgicalDocker --build-tests


RUN swift build \
    -c release \
    --product LiturgicalDocker \
    -Xswiftc -enable-testing  # Allows testing if needed


# Then run tests


#RUN swift test --filter LiturgicalServiceTests 
#RUN swift test --filter PsalmServiceTests 
#RUN swift test --filter HoursServiceTests
#RUN swift test \
#    --filter "PsalmService*" \
#    -Xswiftc -swift-version -Xswiftc 5.9 
    

# Production build
RUN swift build -c release --product LiturgicalDocker

# Copy resources to release directory
RUN mkdir -p .build/release/ && \
    cp ordo/psalms.json .build/release/ && \
    cp ordo/horas.json .build/release/

# Stage 2: Production image
FROM swift:6.0.3-jammy
WORKDIR /app
COPY --from=builder /app/.build/release/LiturgicalDocker .
COPY --from=builder /app/.build/release/psalms.json .
COPY --from=builder /app/.build/release/horas.json .

CMD ["./LiturgicalDocker"]

