---
description: Swift coding rule
---

# Swift Coding Standards

---

## Primary Directive: Code Snippets Only

- **Always provide code snippets**, never attempt to modify, edit, or replace existing files.  
- The AI agent does not have the capability to safely perform file edits — all changes must be manually reviewed and applied by the developer.  
- Format snippets clearly with language and file name annotations:  
  ```swift Sources/MyModel.swift
  struct MyModel {
      private var counter = 0
      
      mutating func increment() { counter += 1 }
  }
  ```
- Never use `edit_existing_file`, `single_find_and_replace`, or similar tools — even if the file content is known.  
- If asked to “fix” or “update” code, respond with a complete, correctly indented snippet showing the desired state.

---
