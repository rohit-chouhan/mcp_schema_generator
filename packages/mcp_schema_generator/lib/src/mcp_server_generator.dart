import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:mcp_annotations/mcp_annotations.dart';

class McpServerGenerator extends GeneratorForAnnotation<McpServer> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '@McpServer can only be applied to classes.',
        element: element,
      );
    }

    final className = element.name;
    final buffer = StringBuffer();

    buffer.writeln('extension ${className}McpExtension on $className {');

    _generateTools(element, buffer);
    _generateResources(element, buffer);
    _generatePrompts(element, buffer);

    buffer.writeln('  McpDefinitions get mcpDefinitions => McpDefinitions(');
    buffer.writeln('    tools: mcpTools,');
    buffer.writeln('    resources: mcpResources,');
    buffer.writeln('    prompts: mcpPrompts,');
    buffer.writeln('  );');

    buffer.writeln('}');

    return buffer.toString();
  }

  DartObject? _getAnnotation(Element element, String annotationName) {
    final checker = TypeChecker.fromUrl(
      'package:mcp_annotations/src/mcp_annotations_base.dart#$annotationName',
    );
    return checker.firstAnnotationOf(element);
  }

  String _extractDescription(Element element, DartObject? annotation) {
    final annotationDesc = annotation?.getField('description')?.toStringValue();
    if (annotationDesc != null && annotationDesc.isNotEmpty) {
      return annotationDesc;
    }

    final docComment = element.documentationComment;
    if (docComment != null) {
      return docComment
          .replaceAll(RegExp(r'^///\s?', multiLine: true), '')
          .trim();
    }
    return '';
  }

  void _generateTools(ClassElement element, StringBuffer buffer) {
    buffer.writeln('  List<ToolDefinition> get mcpTools => [');
    final toolNames = <String>{};

    for (var method in element.methods) {
      final toolAnnotation = _getAnnotation(method, 'McpTool');
      if (toolAnnotation != null) {
        final name =
            toolAnnotation.getField('name')?.toStringValue() ??
            method.name ??
            '';
        final description = _extractDescription(method, toolAnnotation);

        if (toolNames.contains(name)) {
          throw InvalidGenerationSourceError(
            'Duplicate tool name "$name" found on method "${method.name}".',
            element: method,
          );
        }
        toolNames.add(name);

        buffer.writeln('    ToolDefinition(');
        buffer.writeln('      name: \'$name\',');
        buffer.writeln('      description: \'$description\',');
        buffer.writeln('      inputSchema: {');
        buffer.writeln('        \'type\': \'object\',');
        buffer.writeln('        \'properties\': {');

        final requiredParams = <String>[];

        for (var param in method.formalParameters) {
          _generateParameterSchema(param, buffer);

          final paramAnnotation = _getAnnotation(param, 'McpParam');
          bool isRequired = true;

          if (paramAnnotation != null) {
            final requiredField = paramAnnotation.getField('required');
            if (requiredField != null && !requiredField.isNull) {
              isRequired = requiredField.toBoolValue()!;
            } else {
              isRequired =
                  param.type.nullabilitySuffix != NullabilitySuffix.question;
            }
          } else {
            isRequired =
                param.type.nullabilitySuffix != NullabilitySuffix.question;
          }

          if (isRequired && param.name != null && param.name!.isNotEmpty) {
            requiredParams.add(param.name!);
          }
        }

        buffer.writeln('        },');
        if (requiredParams.isNotEmpty) {
          buffer.writeln(
            '        \'required\': [${requiredParams.map((p) => '\'$p\'').join(', ')}],',
          );
        }
        buffer.writeln('      },');
        buffer.writeln('    ),');
      }
    }

    buffer.writeln('  ];');
    buffer.writeln('  Map<String, ToolDefinition> get mcpToolMap => {');
    buffer.writeln('    for (final tool in mcpTools) tool.name: tool,');
    buffer.writeln('  };');
  }

  void _generateResources(ClassElement element, StringBuffer buffer) {
    buffer.writeln('  List<ResourceDefinition> get mcpResources => [');
    final resourceNames = <String>{};

    for (var method in element.methods) {
      final resourceAnnotation = _getAnnotation(method, 'McpResource');
      if (resourceAnnotation != null) {
        final uriTemplate = resourceAnnotation
            .getField('uriTemplate')
            ?.toStringValue();
        if (uriTemplate == null ||
            uriTemplate.isEmpty ||
            !uriTemplate.contains('://')) {
          throw InvalidGenerationSourceError(
            'Invalid uriTemplate "$uriTemplate". It must be non-empty and contain "://".',
            element: method,
          );
        }

        final name =
            resourceAnnotation.getField('name')?.toStringValue() ??
            method.name ??
            '';
        final description = _extractDescription(method, resourceAnnotation);
        final mimeType = resourceAnnotation
            .getField('mimeType')
            ?.toStringValue();

        if (resourceNames.contains(name)) {
          throw InvalidGenerationSourceError(
            'Duplicate resource name "$name" found on method "${method.name}".',
            element: method,
          );
        }
        resourceNames.add(name);

        buffer.writeln('    ResourceDefinition(');
        buffer.writeln('      uriTemplate: \'$uriTemplate\',');
        buffer.writeln('      name: \'$name\',');
        buffer.writeln('      description: \'$description\',');
        if (mimeType != null) {
          buffer.writeln('      mimeType: \'$mimeType\',');
        }
        buffer.writeln('    ),');
      }
    }

    buffer.writeln('  ];');
    buffer.writeln('  Map<String, ResourceDefinition> get mcpResourceMap => {');
    buffer.writeln(
      '    for (final resource in mcpResources) resource.name: resource,',
    );
    buffer.writeln('  };');
  }

  void _generatePrompts(ClassElement element, StringBuffer buffer) {
    buffer.writeln('  List<PromptDefinition> get mcpPrompts => [');
    final promptNames = <String>{};

    for (var method in element.methods) {
      final promptAnnotation = _getAnnotation(method, 'McpPrompt');
      if (promptAnnotation != null) {
        final name =
            promptAnnotation.getField('name')?.toStringValue() ??
            method.name ??
            '';
        final description = _extractDescription(method, promptAnnotation);

        if (promptNames.contains(name)) {
          throw InvalidGenerationSourceError(
            'Duplicate prompt name "$name" found on method "${method.name}".',
            element: method,
          );
        }
        promptNames.add(name);

        buffer.writeln('    PromptDefinition(');
        buffer.writeln('      name: \'$name\',');
        buffer.writeln('      description: \'$description\',');
        buffer.writeln('      arguments: [');

        for (var param in method.formalParameters) {
          final paramName = param.name;
          final paramDesc = _extractDescription(
            param,
            _getAnnotation(param, 'McpParam'),
          );
          final isRequired =
              param.type.nullabilitySuffix != NullabilitySuffix.question;
          final typeString = _getPromptArgumentTypeString(param.type);

          buffer.writeln('        PromptArgument(');
          buffer.writeln('          name: \'$paramName\',');
          buffer.writeln('          description: \'$paramDesc\',');
          buffer.writeln('          type: \'$typeString\',');
          buffer.writeln('          required: $isRequired,');
          buffer.writeln('        ),');
        }

        buffer.writeln('      ],');
        buffer.writeln('    ),');
      }
    }

    buffer.writeln('  ];');
    buffer.writeln('  Map<String, PromptDefinition> get mcpPromptMap => {');
    buffer.writeln('    for (final prompt in mcpPrompts) prompt.name: prompt,');
    buffer.writeln('  };');
  }

  String _getPromptArgumentTypeString(DartType type) {
    if (type.isDartCoreString) return 'string';
    if (type.isDartCoreInt) return 'integer';
    if (type.isDartCoreDouble || type.isDartCoreNum) return 'number';
    if (type.isDartCoreBool) return 'boolean';
    if (type.isDartCoreList) return 'array';
    if (type.element is EnumElement) return 'string';
    return 'object';
  }

  void _generateParameterSchema(
    FormalParameterElement param,
    StringBuffer buffer,
  ) {
    buffer.writeln('          \'${param.name}\': {');

    final paramAnnotation = _getAnnotation(param, 'McpParam');
    if (paramAnnotation != null) {
      final desc = paramAnnotation.getField('description')?.toStringValue();
      if (desc != null) {
        buffer.writeln('            \'description\': \'$desc\',');
      }

      final minObj = paramAnnotation.getField('minimum');
      final min = minObj?.toDoubleValue() ?? minObj?.toIntValue();
      if (min != null) buffer.writeln('            \'minimum\': $min,');

      final maxObj = paramAnnotation.getField('maximum');
      final max = maxObj?.toDoubleValue() ?? maxObj?.toIntValue();
      if (max != null) buffer.writeln('            \'maximum\': $max,');

      final pattern = paramAnnotation.getField('pattern')?.toStringValue();
      if (pattern != null) {
        buffer.writeln('            \'pattern\': r\'$pattern\',');
      }
    }

    _generateTypeSchema(param.type, buffer, indent: 12);

    buffer.writeln('          },');
  }

  void _generateTypeSchema(
    DartType type,
    StringBuffer buffer, {
    required int indent,
  }) {
    final indentStr = ' ' * indent;
    if (type.isDartCoreString) {
      buffer.writeln('$indentStr\'type\': \'string\',');
    } else if (type.isDartCoreInt) {
      buffer.writeln('$indentStr\'type\': \'integer\',');
    } else if (type.isDartCoreDouble || type.isDartCoreNum) {
      buffer.writeln('$indentStr\'type\': \'number\',');
    } else if (type.isDartCoreBool) {
      buffer.writeln('$indentStr\'type\': \'boolean\',');
    } else if (type.isDartCoreList) {
      buffer.writeln('$indentStr\'type\': \'array\',');
      buffer.writeln('$indentStr\'items\': {');
      if (type is ParameterizedType && type.typeArguments.isNotEmpty) {
        _generateTypeSchema(
          type.typeArguments.first,
          buffer,
          indent: indent + 2,
        );
      }
      buffer.writeln('$indentStr},');
    } else if (type.element is EnumElement) {
      buffer.writeln('$indentStr\'type\': \'string\',');
      final enumElement = type.element as EnumElement;
      final enumValues = enumElement.fields
          .where((f) => f.isEnumConstant)
          .map((f) => f.name)
          .toList();
      buffer.writeln(
        '$indentStr\'enum\': [${enumValues.map((e) => '\'$e\'').join(', ')}],',
      );
    } else {
      final typeName = type.element?.name;
      if (type.isDartAsyncStream ||
          type.isDartAsyncFuture ||
          typeName == 'Socket' ||
          typeName == 'File' ||
          typeName == 'HttpRequest') {
        throw InvalidGenerationSourceError(
          'Unsupported parameter type: ${type.toString()}',
          element: type.element,
        );
      }
      buffer.writeln('$indentStr\'type\': \'object\',');
    }
  }
}
