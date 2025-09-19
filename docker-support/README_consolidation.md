# Universal Consolidation Feature

This feature automatically combines all individual psalm files into consolidated JSON files for production use:

- `output_psalm*_themes.json` → `themes.json` (theme analysis data)
- `output_psalm*_texts.json` → `psalms.json` (Latin and English text data)

## How It Works

1. **Automatic Detection**: The Docker build process automatically detects when psalm files are generated during testing
2. **Consolidation**: All individual psalm files are combined into consolidated JSON files using gawk
3. **Verification**: The process verifies that all files were successfully consolidated
4. **Flexible Processing**: You can specify which types of files to process using command-line variables

## Files

- `docker-support/consolidate.awk` - GNU awk script that performs the consolidation
- `docker-support/README_consolidation.md` - This documentation

## Usage

### Automatic (Recommended)

The consolidation happens automatically during Docker builds when psalm files are present:

```bash
# Run tests that generate psalm files
swift test --filter "Psalm138ATests"

# The Docker build will automatically consolidate all files
docker build -f docker-support/Dockerfile .
```

### Manual

You can also run the consolidation script manually with flexible options:

```bash
# Process both themes and texts (default)
gawk -f docker-support/consolidate.awk

# Process only themes
gawk -v themes=1 -f docker-support/consolidate.awk

# Process only texts
gawk -v texts=1 -f docker-support/consolidate.awk

# Process themes but skip texts
gawk -v themes=1 -v texts=0 -f docker-support/consolidate.awk

# Process texts but skip themes
gawk -v themes=0 -v texts=1 -f docker-support/consolidate.awk
```

## Output

The consolidation process creates consolidated JSON files:

### themes.json

- All psalm themes combined into a single JSON array
- Themes sorted by psalm number
- Structural and conceptual theme analysis data
- Proper JSON formatting with indentation

### psalms.json

- All psalm texts combined into a single JSON array
- Latin and English text for each psalm
- Sorted by psalm number
- Proper JSON formatting with indentation

## Example Output

```
🚀 Starting consolidation process...
⏰ 2025-09-19 11:09:51

📁 Found 25 themes files:
   - output_psalm1_themes.json
   - output_psalm2_themes.json
   ...

🔄 Processing themes files...
   Processing: output_psalm1_themes.json (1/25)
     ✅ Loaded: output_psalm1_themes.json (Structural: 3, Conceptual: 7)
   ...

📊 themes Consolidation Summary:
   - Total psalms processed: 25
   - Total structural themes: 128
   - Total conceptual themes: 183
   - Output file size: 151901 bytes (0.14 MB)

📁 Found 19 texts files:
   - output_psalm1_texts.json
   - output_psalm2_texts.json
   ...

🔄 Processing texts files...
   Processing: output_psalm1_texts.json (1/19)
     ✅ Loaded: output_psalm1_texts.json (Latin: 7 verses, English: 7 verses)
   ...

📊 texts Consolidation Summary:
   - Total psalms processed: 19
   - Total verses: 133
   - Output file size: 45678 bytes (0.04 MB)

🎉 Consolidation complete!
```

## Integration with Docker

The Dockerfile includes the consolidation step:

```dockerfile
# ✅ Step 3: Consolidate psalm files (if any were generated)
RUN if ls output_psalm*_themes.json 1> /dev/null 2>&1; then \
        echo "📁 Found psalm files, consolidating..."; \
        gawk -f docker-support/consolidate.awk; \
    else \
        echo "ℹ️  No psalm files found to consolidate"; \
    fi
```

This ensures that whenever you run tests that generate psalm files, they will be automatically consolidated into the production-ready JSON files.

## Command-Line Variables

The script supports the following variables:

- `themes=1` - Process theme files (default: 1)
- `themes=0` - Skip theme files
- `texts=1` - Process text files (default: 1)
- `texts=0` - Skip text files

If no variables are specified, both themes and texts are processed by default.

## Why gawk?

- ✅ **Fast and efficient** - Excellent for text processing
- ✅ **No external dependencies** - gawk is standard on Linux systems
- ✅ **Handles large files well** - Perfect for processing many psalm files
- ✅ **Works perfectly in Docker** - Available in most Linux containers
- ✅ **Reliable JSON processing** - Robust parsing of complex JSON structures
- ✅ **Flexible variable support** - Command-line control over processing options
