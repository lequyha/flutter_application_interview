import 'package:flutter_package_interview/flutter_package_interview.dart';

extension NestedMapStateManagerExtension on StateManager<Map<String, dynamic>> {
  void addNestedValue(List<String> path, dynamic newValue) {
    final newMap = Map<String, dynamic>.from(value);
    Map<String, dynamic> current = newMap;

    for (int i = 0; i < path.length - 1; i++) {
      current =
          (current[path[i]] as Map<String, dynamic>?) ?? <String, dynamic>{};
    }

    current[path.last] = newValue;
    setState(newMap);
  }

  dynamic getNestedValue(List<String> path) {
    Map<String, dynamic> current = value;
    for (int i = 0; i < path.length - 1; i++) {
      current = current[path[i]] as Map<String, dynamic>;
    }
    return current[path.last];
  }

  void removeNestedKey(List<String> path) {
    final newMap = Map<String, dynamic>.from(value);
    Map<String, dynamic> current = newMap;

    for (int i = 0; i < path.length - 1; i++) {
      current =
          (current[path[i]] as Map<String, dynamic>?) ?? <String, dynamic>{};
    }

    current.remove(path.last);
    setState(newMap);
  }
}
