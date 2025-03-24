import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class YamlUtils {
  Map<dynamic, dynamic> yamlToMap(dynamic node) {
    return Map<dynamic, dynamic>.of(
      node.map(
        (dynamic key, dynamic value) => MapEntry<dynamic, dynamic>(
          key.toString(),
          getModifiableNode(value),
        ),
      ),
    );
  }

  dynamic getModifiableNode(dynamic node) {
    if (node is Map) {
      return Map<String, dynamic>.from(yamlToMap(node));
    } else if (node is List) {
      return node.map((dynamic entry) {
        if (entry is Map) {
          return Map<String, dynamic>.from(yamlToMap(entry));
        }
        return entry;
      }).toList();
    }
    return node;
  }

  Future<Map<String, dynamic>> loadYamlFromString(String yaml) async {
    final dynamic result = await loadYaml(yaml);
    return Map<String, dynamic>.from(getModifiableNode(result));
  }

  Future<Map<String, dynamic>> loadYamlFromPath(String path) async {
    final String yamlString = await rootBundle.loadString(path);
    return loadYamlFromString(yamlString);
  }
}
