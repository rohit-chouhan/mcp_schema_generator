import 'package:mcp_annotations/mcp_annotations.dart';
import 'package:mcp_runtime/mcp_runtime.dart';

part 'server.g.dart';

class User {
  final int id;
  User(this.id);
}

@McpServer(name: 'analytics')
class AnalyticsServer {
  @McpTool(description: 'Get user by ID')
  Future<User> getUser(@McpParam(minimum: 1) int id) async {
    return User(id);
  }

  /// Returns current user profile.
  @McpResource(uriTemplate: 'users://{id}')
  Future<User> userResource() async {
    return User(1); // placeholder
  }

  /// Summarize given text.
  @McpPrompt()
  String summarize(String text) => 'Summarize: $text';
}
