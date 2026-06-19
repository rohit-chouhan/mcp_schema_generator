import 'dart:async';
import 'package:mcp_schema_generator/src/mcp_server_generator.dart';
import 'package:source_gen_test/source_gen_test.dart';

Future<void> main() async {
  final reader = await initializeLibraryReaderForDirectory(
    'test/src',
    'test_inputs.dart',
  );

  initializeBuildLogTracking();
  testAnnotatedElements(
    reader,
    McpServerGenerator(),
    expectedAnnotatedTests: _expectedAnnotatedTests,
  );
}

const _expectedAnnotatedTests = [
  'TestServer',
];
