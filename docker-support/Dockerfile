# Stage 1: Build and Test
FROM swift:6.0.3-jammy as builder

# Install dependencies
RUN apt-get update && apt-get install -y dos2unix libxml2-dev

WORKDIR /app
RUN mkdir -p /app/psalm_progress

COPY . .

# Fix line endings
RUN find . -type f -name "*.swift" -exec dos2unix {} \; && dos2unix Package.swift

# ✅ Step 1: Build for testing (with testability)
# New syntax for enabling testability
RUN swift build -Xswiftc -enable-testing

# ✅ Step 2: Run tests
RUN swift test

# ✅ Step 3: Consolidate psalm files (if any were generated)
RUN if ls output_psalm*_themes.json 1> /dev/null 2>&1 || ls output_psalm*_texts.json 1> /dev/null 2>&1; then \
    echo "📁 Found psalm files, consolidating..."; \
    gawk -f docker-support/consolidate.awk; \
    else \
    echo "ℹ️  No psalm files found to consolidate"; \
    fi

# ✅ Step 4: Build release (only if tests pass)
RUN swift build -c release --product LiturgicalDocker --static-swift-stdlib

# Stage 2: Runtime
FROM swift:6.0.3-jammy
WORKDIR /app
COPY --from=builder /app/.build/*/release/LiturgicalDocker .
COPY --from=builder /app/ordo/Services/PsalmService/psalms.json /app/LiturgicalService_PsalmService.resources/
COPY --from=builder /app/ordo/Services/HoursService/horas.json /app/LiturgicalService_HoursService.resources/
COPY --from=builder /app/ordo/Services/LitergicalService/office.json /app/LiturgicalService_HoursService.resources/
CMD ["./LiturgicalDocker"]

#RUN swift test --filter LiturgicalServiceTests 