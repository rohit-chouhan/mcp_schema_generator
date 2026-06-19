/// A definition of an MCP tool.
class ToolDefinition {
  /// The name of the tool.
  final String name;

  /// The description of the tool.
  final String description;

  /// The JSON Schema representing the input parameters of the tool.
  final Map<String, dynamic> inputSchema;

  const ToolDefinition({
    required this.name,
    required this.description,
    required this.inputSchema,
  });
}

/// A definition of an MCP resource.
class ResourceDefinition {
  final String uriTemplate;
  final String name;
  final String description;
  final String? mimeType;

  const ResourceDefinition({
    required this.uriTemplate,
    required this.name,
    required this.description,
    this.mimeType,
  });
}

/// An argument for an MCP prompt.
class PromptArgument {
  final String name;
  final String description;
  final String type;
  final bool required;

  const PromptArgument({
    required this.name,
    required this.description,
    required this.type,
    required this.required,
  });
}

/// A definition of an MCP prompt.
class PromptDefinition {
  final String name;
  final String description;
  final List<PromptArgument> arguments;

  const PromptDefinition({
    required this.name,
    required this.description,
    required this.arguments,
  });
}

/// Unified MCP metadata definitions.
class McpDefinitions {
  final List<ToolDefinition> tools;
  final List<ResourceDefinition> resources;
  final List<PromptDefinition> prompts;

  const McpDefinitions({
    required this.tools,
    required this.resources,
    required this.prompts,
  });
}
