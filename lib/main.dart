import 'package:flutter/material.dart';
import 'package:flutter_application_interview/src/screens/state_manager_example.dart';
import 'package:flutter_application_interview/src/screens/state_manager_list_example.dart';
import 'package:flutter_package_interview/flutter_package_interview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counterState = StateManager<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const StateManagerExample(
                            title: 'Ví dụ dạng biến bình thường',
                          ),
                    ),
                  ),
              child: Text('Ví dụ dạng biến bình thường'),
            ),
            TextButton(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const StateManagerListExample(
                            title: 'Ví dụ dạng list',
                          ),
                    ),
                  ),
              child: Text('Ví dụ dạng list'),
            ),
          ],
        ),
      ),
    );
  }
}
