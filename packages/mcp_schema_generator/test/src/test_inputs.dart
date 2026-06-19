import 'package:source_gen_test/annotations.dart';
import 'package:mcp_schema_annotations/mcp_schema_annotations.dart';

enum Role { admin, user }

@ShouldGenerate(r'''
extension TestServerMcpExtension on TestServer {
  List<ToolDefinition> get mcpTools => [
    ToolDefinition(
      name: 'testTool',
      description: 'A test tool',
      inputSchema: {
        'type': 'object',
        'properties': {
          'stringParam': {'type': 'string'},
          'intParam': {'type': 'integer'},
          'doubleParam': {'type': 'number'},
          'boolParam': {'type': 'boolean'},
          'listParam': {
            'type': 'array',
            'items': {'type': 'string'},
          },
          'enumParam': {
            'type': 'string',
            'enum': ['admin', 'user'],
          },
          'nullableParam': {
            'description': 'A nullable param',
            'type': 'string',
          },
          'constrainedParam': {'minimum': 1, 'maximum': 10, 'type': 'integer'},
        },
        'required': [
          'stringParam',
          'intParam',
          'doubleParam',
          'boolParam',
          'listParam',
          'enumParam',
          'constrainedParam',
        ],
      },
    ),
  ];
  Map<String, ToolDefinition> get mcpToolMap => {
    for (final tool in mcpTools) tool.name: tool,
  };
  List<ResourceDefinition> get mcpResources => [
    ResourceDefinition(
      uriTemplate: 'users://{id}',
      name: 'currentUser',
      description: 'User profile resource',
    ),
  ];
  Map<String, ResourceDefinition> get mcpResourceMap => {
    for (final resource in mcpResources) resource.name: resource,
  };
  List<PromptDefinition> get mcpPrompts => [
    PromptDefinition(
      name: 'summarize',
      description: 'Summarize text prompt',
      arguments: [
        PromptArgument(
          name: 'text',
          description: '',
          type: 'string',
          required: true,
        ),
      ],
    ),
  ];
  Map<String, PromptDefinition> get mcpPromptMap => {
    for (final prompt in mcpPrompts) prompt.name: prompt,
  };
  McpDefinitions get mcpDefinitions => McpDefinitions(
    tools: mcpTools,
    resources: mcpResources,
    prompts: mcpPrompts,
  );
}
''')
@McpServer()
class TestServer {
  @McpTool(name: 'testTool', description: 'A test tool')
  void testMethod(
    String stringParam,
    int intParam,
    double doubleParam,
    bool boolParam,
    List<String> listParam,
    Role enumParam,
    @McpParam(description: 'A nullable param') String? nullableParam,
    @McpParam(minimum: 1, maximum: 10) int constrainedParam,
  ) {}

  /// User profile resource
  @McpResource(uriTemplate: 'users://{id}')
  Future<void> currentUser() async {}

  /// Summarize text prompt
  @McpPrompt()
  String summarize(String text) => text;
}
