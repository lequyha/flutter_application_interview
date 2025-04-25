typedef StateListener<T> = void Function(T value);

class StateManager<T> {
  T _value;
  final List<StateListener<T>> _listeners = [];

  StateManager(this._value);

  T get value => _value;

  void setState(T newValue) {
    _value = newValue;
    _notifyListeners();
  }

  Future<void> setAsync(Future<T> Function() asyncFn) async {
    final result = await asyncFn();
    _value = result;
    _notifyListeners();
  }

  void addListener(StateListener<T> listener) {
    _listeners.add(listener);
  }

  void removeListener(StateListener<T> listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners() {
    for (final listener in List<StateListener<T>>.from(_listeners)) {
      listener(_value);
    }
  }

  void dispose() {
    _listeners.clear();
  }
}
