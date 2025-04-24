import 'package:flutter/material.dart';
import 'package:flutter_package_interview/flutter_package_interview.dart';

class StateManagerListExample extends StatelessWidget {
  final String title;
  const StateManagerListExample({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final counterState = StateManager<int>(0);
    final listState = StateManager<List<int>>([]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: StateListener<List<int>>(
          stateManager: listState,
          builder: (context, list) => Text(list.toString()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterState.setState(counterState.value + 1);
          listState.addItem(counterState.value);
        },
        tooltip: 'Thêm',
        child: const Icon(Icons.add),
      ),
    );
  }
}
