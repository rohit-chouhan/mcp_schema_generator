## 1.0.0-beta.1

- Initial MVP Release.
- Zero-boilerplate generation of MCP Tools using `@McpTool` and `@McpParam`.
- Robust support for generating schemas from primitive Dart types, Lists, Enums, and Nullable properties.
- **Added `@McpResource` annotation:** Declare MCP Resources by annotating methods with a required `uriTemplate`.
- **Added `@McpPrompt` annotation:** Expose reusable AI Prompt definitions natively through Dart methods.
- **DartDoc Metadata Extraction:** The schema generator now extracts standard Dart documentation comments (`///`) to populate JSON Schema descriptions automatically.
- **Unified Definitions Mapping:** Introducing the `McpDefinitions` runtime class that encapsulates tools, resources, and prompts together for easier downstream adapter use.
- **Strict Validation:** Added checks for URI structure and duplicate tool/resource/prompt names.