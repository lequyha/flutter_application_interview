import 'package:flutter_package_interview/flutter_package_interview.dart';

extension ListStateManagerExtension<T> on StateManager<List<T>> {
  void addItem(T item) {
    final newList = List<T>.from(value)..add(item);
    setState(newList);
  }

  void removeItem(T item) {
    final newList = List<T>.from(value)..remove(item);
    setState(newList);
  }

  void clear() {
    setState([]);
  }
}
