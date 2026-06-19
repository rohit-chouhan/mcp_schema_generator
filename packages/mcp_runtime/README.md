# mcp_runtime

[![Pub Version](https://img.shields.io/pub/v/mcp_runtime)](https://pub.dev/packages/mcp_runtime)
[![Pub Likes](https://img.shields.io/pub/likes/mcp_runtime)](https://pub.dev/packages/mcp_runtime)
[![GitHub Issues](https://img.shields.io/github/issues/rohit-chouhan/mcp_schema_generator)](https://github.com/rohit-chouhan/mcp_schema_generator/issues)

Runtime metadata models used by MCP Schema Generator.

## Installation

```yaml
dependencies:
  mcp_runtime: ^1.0.0-beta.1
```

## Included Types

- `ToolDefinition`
- `ResourceDefinition`
- `PromptDefinition`
- `PromptArgument`
- `McpDefinitions`

## Example

```dart
final definitions = server.mcpDefinitions;
```