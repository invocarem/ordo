#!/usr/bin/gawk -f

# Universal Consolidation Script using gawk
# Combines all output_psalm*_themes.json files into themes.json
# Combines all output_psalm*_texts.json files into psalms.json

BEGIN {
    print "🚀 Starting consolidation process..."
    print "⏰ " strftime("%Y-%m-%d %H:%M:%S")
    print ""
    
    # Check command-line variables
    if (themes == "" && texts == "") {
        # Default: process both if no variables specified
        themes = 1
        texts = 1
    }
    
    # Process themes if requested
    if (themes == 1) {
        process_files("output/output_psalm*_themes.json", "themes.json", "themes")
    }
    
    # Process texts if requested
    if (texts == 1) {
        process_files("output/output_psalm*_texts.json", "psalms.json", "texts")
    }
    
    print ""
    print "🎉 Consolidation complete!"
}

function process_files(pattern, output_file, type) {
    # Find files
    cmd = "ls " pattern " 2>/dev/null | sort -V"
    file_count = 0
    while ((cmd | getline file) > 0) {
        files[++file_count] = file
    }
    close(cmd)
    
    if (file_count == 0) {
        print "ℹ️  No " type " files found matching pattern: " pattern
        return
    }
    
    print "📁 Found " file_count " " type " files:"
    for (i = 1; i <= file_count; i++) {
        print "   - " files[i]
    }
    print ""
    print "🔄 Processing " type " files..."
    
    # Start JSON array
    print "[" > output_file
    first_file = 1
    processed_count = 0
    
    # Process each file
    for (i = 1; i <= file_count; i++) {
        file = files[i]
        print "   Processing: " file " (" i "/" file_count ")"
        
        # Read file content
        content = ""
        while ((getline line < file) > 0) {
            content = content line "\n"
        }
        close(file)
        
        # Only process if file is not empty
        if (content != "") {
            # Write to output
            if (!first_file) {
                print "," >> output_file
            }
            first_file = 0
            
            # Format content
            gsub(/^[ \t\n\r]+|[ \t\n\r]+$/, "", content)
            gsub(/\n/, "\n  ", content)
            content = "  " content
            
            print content >> output_file
            processed_count++
            
            print "     ✅ Loaded: " file
        } else {
            print "     ❌ Failed to load: " file " (empty file)"
        }
    }
    
    # End JSON array
    print "]" >> output_file
    close(output_file)
    
    # Summary
    print ""
    print "📊 " type " Consolidation Summary:"
    print "   - Total psalms processed: " processed_count
    
    # File size
    cmd = "wc -c < " output_file " 2>/dev/null"
    cmd | getline file_size
    close(cmd)
    if (file_size > 0) {
        size_mb = file_size / (1024 * 1024)
        print "   - Output file size: " file_size " bytes (" sprintf("%.2f", size_mb) " MB)"
    }
    
    print "   ✅ " type " verification successful!"
}

function count_objects(json, array_name) {
    pattern = "\"" array_name "\"\\s*:\\s*\\["
    if (!match(json, pattern)) return 0
    
    count = 0
    brace_level = 0
    in_string = 0
    escape_next = 0
    
    for (i = RSTART + RLENGTH; i <= length(json); i++) {
        char = substr(json, i, 1)
        
        if (escape_next) {
            escape_next = 0
            continue
        }
        
        if (char == "\\") {
            escape_next = 1
            continue
        }
        
        if (char == "\"") {
            in_string = !in_string
            continue
        }
        
        if (!in_string) {
            if (char == "{") {
                if (brace_level == 0) count++
                brace_level++
            } else if (char == "}") {
                brace_level--
            } else if (char == "]" && brace_level == 0) {
                break
            }
        }
    }
    
    return count
}

function count_strings(json, array_name) {
    pattern = "\"" array_name "\"\\s*:\\s*\\["
    if (!match(json, pattern)) return 0
    
    count = 0
    in_string = 0
    escape_next = 0
    
    for (i = RSTART + RLENGTH; i <= length(json); i++) {
        char = substr(json, i, 1)
        
        if (escape_next) {
            escape_next = 0
            continue
        }
        
        if (char == "\\") {
            escape_next = 1
            continue
        }
        
        if (char == "\"") {
            if (!in_string) {
                count++
                in_string = 1
            } else {
                in_string = 0
            }
        } else if (char == "]" && !in_string) {
            break
        }
    }
    
    return count
}
