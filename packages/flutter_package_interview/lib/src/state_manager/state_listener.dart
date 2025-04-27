import 'package:flutter/widgets.dart';
import 'state_manager.dart';

class StateListener<T> extends StatefulWidget {
  final StateManager<T> stateManager;
  final void Function(BuildContext context, T value) listener;
  final bool Function(T previous, T current)? listenWhen;
  final Widget child;

  const StateListener({
    super.key,
    required this.stateManager,
    required this.listener,
    required this.child,
    this.listenWhen,
  });

  @override
  State<StateListener<T>> createState() => _StateListenerState<T>();
}

class _StateListenerState<T> extends State<StateListener<T>> {
  late T _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.stateManager.value;
    widget.stateManager.addListener(_onValueChanged);
  }

  void _onValueChanged(T newValue) {
    final shouldListen =
        widget.listenWhen?.call(_currentValue, newValue) ?? true;

    if (shouldListen) {
      widget.listener(context, newValue);
    }

    _currentValue = newValue;
  }

  @override
  void dispose() {
    widget.stateManager.removeListener(_onValueChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
