import 'package:flutter/material.dart';
import 'package:flutter_package_interview/flutter_package_interview.dart';

class StateManagerExample extends StatelessWidget {
  final String title;
  const StateManagerExample({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final counterState = StateManager<int>(0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: StateListener<int>(
          stateManager: counterState,
          builder: (context, count) => Text('Đếm: $count'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterState.setState(counterState.value + 1),
        tooltip: 'Tăng',
        child: const Icon(Icons.add),
      ),
    );
  }
}
