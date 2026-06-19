# mcp_schema_generator

[![Pub Version](https://img.shields.io/pub/v/mcp_schema_generator)](https://pub.dev/packages/mcp_schema_generator)
[![Pub Likes](https://img.shields.io/pub/likes/mcp_schema_generator)](https://pub.dev/packages/mcp_schema_generator)
[![GitHub Issues](https://img.shields.io/github/issues/rohit-chouhan/mcp_schema_generator)](https://github.com/rohit-chouhan/mcp_schema_generator/issues)
Annotation-driven MCP server generation for Dart & Flutter.

Eliminates Model Context Protocol (MCP) boilerplate by generating tool registration, JSON schemas, parameter parsing, and error handling from simple Dart annotations.

## Features

* **Zero Boilerplate:** Automatically map Dart methods to MCP Tools.
* **JSON Schema Generation:** Converts Dart types (`String`, `int`, `List`, `Enum`, nullables) into strictly typed JSON schemas.
* **Built-in Validation:** Specify boundaries with `@McpParam(minimum: 1)`.
* **Type Safety:** The generated code provides strongly typed `ToolDefinition` metadata maps.

## Installation

Add the dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  mcp_schema_annotations: ^1.0.0-beta.1
  mcp_schema_runtime: ^1.0.0-beta.1

dev_dependencies:
  mcp_schema_generator: ^1.0.0-beta.1
  build_runner: ^2.15.0
```

## Quick Start

1. Annotate your server class and methods.

```dart
import 'package:mcp_schema_annotations/mcp_schema_annotations.dart';
import 'package:mcp_schema_runtime/mcp_schema_runtime.dart';

part 'server.g.dart'; // The generated file

@McpServer(name: 'analytics_server')
class AnalyticsServer {

  @McpTool(description: 'Get user details')
  Future<User> getUser(
    @McpParam(description: 'User ID', minimum: 1) int id,
  ) async {
    return User(id);
  }
}
```

2. Run the generator

```bash
dart run build_runner build
```

3. Access the generated metadata!

```dart
final server = AnalyticsServer();
print(server.mcpTools); // List of generated ToolDefinitions!
print(server.mcpToolMap); // Map of tool names to ToolDefinitions!
```

## Annotations

- `@McpServer(name: 'server_name')`: Marks a class as an MCP server.
- `@McpTool(name: 'toolName', description: '...')`: Marks a method as an MCP Tool.
- `@McpParam(description: '...', minimum: 0, maximum: 10, pattern: r'^[A-Z]$')`: Provides additional JSON Schema metadata constraints for parameters.

## Generated Output

The generator produces a Dart extension on your server class:

```dart
extension AnalyticsServerMcpExtension on AnalyticsServer {
  List<ToolDefinition> get mcpTools => [
    ToolDefinition(
      name: 'getUser',
      description: 'Get user details',
      inputSchema: {
        'type': 'object',
        'properties': {
          'id': {
             'description': 'User ID',
             'minimum': 1,
             'type': 'integer',
          }
        },
        'required': ['id']
      }
    )
  ];

  Map<String, ToolDefinition> get mcpToolMap => { ... };
}
```

## Supported Types

- `String` -> `string`
- `int` -> `integer`
- `double` / `num` -> `number`
- `bool` -> `boolean`
- `List<T>` -> `array`
- `Enum` -> `string` (with `enum` list)
- Nullable types (e.g. `String?`) are omitted from the `required` array.

## Limitations

- **Custom DTO generation:** Custom classes in parameters currently fallback to `{"type": "object"}`. Deep nested schema generation for custom DTOs is not yet supported.
- **Unsupported Types:** Core classes like `Stream`, `Socket`, `File`, and `Future` cannot be used as tool parameters.