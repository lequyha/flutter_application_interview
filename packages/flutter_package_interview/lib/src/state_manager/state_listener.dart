import 'package:flutter/widgets.dart';
import 'state_manager.dart';

class StateListener<T> extends StatefulWidget {
  final StateManager<T> stateManager;
  final Widget Function(BuildContext context, T value) builder;

  const StateListener({
    super.key,
    required this.stateManager,
    required this.builder,
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
    setState(() {
      _currentValue = newValue;
    });
  }

  @override
  void dispose() {
    widget.stateManager.removeListener(_onValueChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _currentValue);
  }
}
