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

  void updateItem(bool Function(T item) test, T newItem) {
    final newList = List<T>.from(value);
    final index = newList.indexWhere(test);
    if (index != -1) {
      newList[index] = newItem;
      setState(newList);
    }
  }

  void clear() {
    setState([]);
  }
}
