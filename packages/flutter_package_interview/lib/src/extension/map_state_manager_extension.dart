import 'package:flutter_package_interview/flutter_package_interview.dart';

extension MapStateManagerExtension<K, V> on StateManager<Map<K, V>> {
  void addEntry(K key, V value) {
    final newMap = Map<K, V>.from(this.value)..[key] = value;
    setState(newMap);
  }

  void removeKey(K key) {
    final newMap = Map<K, V>.from(value)..remove(key);
    setState(newMap);
  }

  void clear() {
    setState({});
  }
}
