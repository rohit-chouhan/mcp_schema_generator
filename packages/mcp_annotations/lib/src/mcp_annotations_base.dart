/// Marks a class as an MCP server.
class McpServer {
  /// The optional name of the server.
  final String? name;

  /// The optional version of the server.
  final String? version;

  /// The optional description of the server.
  final String? description;

  const McpServer({this.name, this.version, this.description});
}

/// Marks a method as an MCP tool.
class McpTool {
  /// The optional name of the tool. If not provided, the method name is used.
  final String? name;

  /// The description of the tool.
  final String? description;

  /// Optional tags for the tool.
  final List<String>? tags;

  const McpTool({this.name, this.description, this.tags});
}

/// Parameter metadata for MCP tools.
class McpParam {
  /// The description of the parameter.
  final String? description;

  /// The minimum value (for numbers).
  final num? minimum;

  /// The maximum value (for numbers).
  final num? maximum;

  /// The regex pattern (for strings).
  final String? pattern;

  /// Whether the parameter is required.
  final bool? required;

  const McpParam({
    this.description,
    this.minimum,
    this.maximum,
    this.pattern,
    this.required,
  });
}

/// Marks a method as an MCP resource.
class McpResource {
  /// The URI template for the resource.
  final String uriTemplate;

  /// The optional name of the resource.
  final String? name;

  /// The description of the resource.
  final String? description;

  /// The optional MIME type of the resource.
  final String? mimeType;

  const McpResource({
    required this.uriTemplate,
    this.name,
    this.description,
    this.mimeType,
  });
}

/// Marks a method as an MCP prompt.
class McpPrompt {
  /// The optional name of the prompt.
  final String? name;

  /// The description of the prompt.
  final String? description;

  const McpPrompt({this.name, this.description});
}
