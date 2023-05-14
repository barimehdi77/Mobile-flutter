import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const FirstEx(),
      home: const SecondEx(),
    );
  }
}

class FirstEx extends StatelessWidget {
  const FirstEx({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("A simple text"),
            ElevatedButton(
              onPressed: () {
                debugPrint('Button Pressed');
              },
              child: const Text('Click me'),
            )
          ],
        ),
      ),
    );
  }
}

class SecondEx extends StatefulWidget {
  const SecondEx({super.key});

  @override
  State<SecondEx> createState() => _SecondExState();
}

class _SecondExState extends State<SecondEx> {
  String? _text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_text ?? "A simple text"),
            ElevatedButton(
              onPressed: () {
                debugPrint(_text);
                if (_text == null) {
                  setState(() {
                    _text = 'Hello World';
                  });
                  debugPrint('Setting state of text to Hello World');
                } else {
                  setState(() {
                    _text = null;
                  });
                }
              },
              child: const Text('Click me'),
            )
          ],
        ),
      ),
    );
  }
}
