# mcp_schema_annotations

[![Pub Version](https://img.shields.io/pub/v/mcp_schema_annotations)](https://pub.dev/packages/mcp_schema_annotations)
[![Pub Likes](https://img.shields.io/pub/likes/mcp_schema_annotations)](https://pub.dev/packages/mcp_schema_annotations)
[![GitHub Issues](https://img.shields.io/github/issues/rohit-chouhan/mcp_schema_generator)](https://github.com/rohit-chouhan/mcp_schema_generator/issues)

Annotation package for MCP Schema Generator.

## Installation

```yaml
dependencies:
  mcp_schema_annotations: ^1.0.0-beta.3
```

## Available Annotations

- `@McpServer`
- `@McpTool`
- `@McpResource`
- `@McpPrompt`
- `@McpParam`

## Example

```dart
@McpServer(name: 'analytics')
class AnalyticsServer {
  @McpTool()
  Future<String> hello(String name) async {
    return 'Hello $name';
  }
}
```