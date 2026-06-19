import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'mcp_server_generator.dart';

Builder mcpServerBuilder(BuilderOptions options) =>
    SharedPartBuilder([McpServerGenerator()], 'mcp_server');
