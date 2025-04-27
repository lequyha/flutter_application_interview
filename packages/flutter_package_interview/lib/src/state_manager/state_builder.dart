import 'package:flutter/widgets.dart';
import 'state_manager.dart';

class StateBuilder<T> extends StatefulWidget {
  final StateManager<T> stateManager;
  final Widget Function(BuildContext context, T value) builder;
  final bool Function(T previous, T current)? buildWhen;

  const StateBuilder({
    super.key,
    required this.stateManager,
    required this.builder,
    this.buildWhen,
  });

  @override
  State<StateBuilder<T>> createState() => _StateBuilderState<T>();
}

class _StateBuilderState<T> extends State<StateBuilder<T>> {
  late T _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.stateManager.value;
    widget.stateManager.addListener(_onValueChanged);
  }

  void _onValueChanged(T newValue) {
    final shouldRebuild =
        widget.buildWhen?.call(_currentValue, newValue) ?? true;

    if (shouldRebuild) {
      setState(() {
        _currentValue = newValue;
      });
    } else {
      _currentValue = newValue; // Cập nhật giá trị, nhưng không rebuild UI
    }
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
