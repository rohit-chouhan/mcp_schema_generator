# Graph Report - mcp_schema_generator  (2026-06-20)

## Corpus Check
- 23 files · ~3,798 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 106 nodes · 83 edges · 23 communities (19 shown, 4 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Community 0|Community 0]]
- [[_COMMUNITY_Community 1|Community 1]]
- [[_COMMUNITY_Community 2|Community 2]]
- [[_COMMUNITY_Community 3|Community 3]]
- [[_COMMUNITY_Community 4|Community 4]]
- [[_COMMUNITY_Community 5|Community 5]]
- [[_COMMUNITY_Community 6|Community 6]]
- [[_COMMUNITY_Community 7|Community 7]]
- [[_COMMUNITY_Community 8|Community 8]]
- [[_COMMUNITY_Community 9|Community 9]]
- [[_COMMUNITY_Community 10|Community 10]]
- [[_COMMUNITY_Community 11|Community 11]]
- [[_COMMUNITY_Community 12|Community 12]]
- [[_COMMUNITY_Community 13|Community 13]]
- [[_COMMUNITY_Community 14|Community 14]]
- [[_COMMUNITY_Community 19|Community 19]]
- [[_COMMUNITY_Community 20|Community 20]]
- [[_COMMUNITY_Community 21|Community 21]]

## God Nodes (most connected - your core abstractions)
1. `mcp_schema_generator` - 9 edges
2. `User` - 1 edges
3. `AnalyticsServer` - 1 edges
4. `summarize` - 1 edges
5. `package:mcp_annotations/mcp_annotations.dart` - 1 edges
6. `package:mcp_runtime/mcp_runtime.dart` - 1 edges
7. `McpServer` - 1 edges
8. `McpTool` - 1 edges
9. `McpParam` - 1 edges
10. `McpResource` - 1 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Import Cycles
- None detected.

## Communities (23 total, 4 thin omitted)

### Community 0 - "Community 0"
Cohesion: 0.40
Nodes (4): Additional information, Features, Getting started, Usage

### Community 1 - "Community 1"
Cohesion: 0.40
Nodes (4): Additional information, Features, Getting started, Usage

### Community 2 - "Community 2"
Cohesion: 0.33
Nodes (5): Additional information, Features, Getting started, Usage, Features

### Community 3 - "Community 3"
Cohesion: 0.20
Nodes (9): Annotations, Generated Output, Installation, Limitations, mcp_schema_generator, Features, Quick Start, Roadmap (+1 more)

### Community 4 - "Community 4"
Cohesion: 0.33
Nodes (5): package:mcp_annotations/mcp_annotations.dart, AnalyticsServer, summarize, User, package:mcp_runtime/mcp_runtime.dart

### Community 5 - "Community 5"
Cohesion: 0.11
Nodes (18): package:analyzer/dart/constant/value.dart, package:analyzer/dart/element/element.dart, package:analyzer/dart/element/nullability_suffix.dart, package:analyzer/dart/element/type.dart, package:build/build.dart, package:mcp_annotations/mcp_annotations.dart, package:source_gen/source_gen.dart, _extractDescription (+10 more)

### Community 9 - "Community 9"
Cohesion: 0.50
Nodes (3): 0.1.0, 0.2.0, 1.0.0

### Community 10 - "Community 10"
Cohesion: 0.50
Nodes (3): 0.1.0, 0.2.0, 1.0.0

### Community 11 - "Community 11"
Cohesion: 0.50
Nodes (3): 0.1.0, 0.2.0, 1.0.0

### Community 12 - "Community 12"
Cohesion: 0.29
Nodes (6): Awesome, McpParam, McpPrompt, McpResource, McpServer, McpTool

### Community 13 - "Community 13"
Cohesion: 0.29
Nodes (6): Awesome, McpDefinitions, PromptArgument, PromptDefinition, ResourceDefinition, ToolDefinition

### Community 14 - "Community 14"
Cohesion: 0.33
Nodes (5): mcp_server_generator.dart, package:build/build.dart, package:source_gen/source_gen.dart, Awesome, mcpServerBuilder

### Community 19 - "Community 19"
Cohesion: 0.33
Nodes (5): package:source_gen_test/annotations.dart, package:mcp_annotations/mcp_annotations.dart, summarize, testMethod, TestServer

### Community 20 - "Community 20"
Cohesion: 0.50
Nodes (3): dart:async, package:mcp_schema_generator/src/mcp_server_generator.dart, package:source_gen_test/source_gen_test.dart

## Knowledge Gaps
- **82 isolated node(s):** `User`, `AnalyticsServer`, `summarize`, `package:mcp_annotations/mcp_annotations.dart`, `package:mcp_runtime/mcp_runtime.dart` (+77 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **4 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What connects `User`, `AnalyticsServer`, `summarize` to the rest of the system?**
  _82 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Community 5` be split into smaller, more focused modules?**
  _Cohesion score 0.10526315789473684 - nodes in this community are weakly interconnected._