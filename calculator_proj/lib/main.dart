import 'package:calculator_proj/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Calculator',
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: MyHomePage(
        title: 'Calculator',
      ),
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
  var userInput = '0';
  var answer = '0';

  // Array of button
  final List<String> buttons = [
    'AC',
    'C',
    '%',
    '/',
    '7',
    '8',
    '9',
    'X',
    '4',
    '5',
    '6',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    '00',
    '=',
  ];

//   Numbers from 0 to 9.
// • “ . ” the decimal numbers.
// • “AC” will reinitialize the expression and result.
// • “C” will delete the last character of the expression.
// • “=” will display the result of the expression.
// • Operators : “ + ”, “ - ”, “ * ”, “ / ”.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.centerRight,
                  child: Text(
                    answer,
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 15.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      2.0, // Move to right 5  horizontally
                      2.0, // Move to bottom 5 Vertically
                    ),
                  ),
                ],
              ),
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  if (index == 0 || index == 1) {
                    return MyButton(
                      backgroudColor: const Color.fromRGBO(248, 248, 248, 1),
                      buttonText: buttons[index],
                      color: const Color.fromRGBO(254, 135, 136, 1),
                      onPress: () {
                        setState(() {
                          userInput = '0';
                          answer = '0';
                        });
                      },
                    );
                  }
                  if (index == 2 ||
                      index == 3 ||
                      index == 7 ||
                      index == 11 ||
                      index == 15) {
                    return MyButton(
                      backgroudColor: const Color.fromRGBO(248, 248, 248, 1),
                      buttonText: buttons[index],
                      color: const Color.fromRGBO(132, 239, 197, 1),
                      onPress: () {
                        setState(() {
                          userInput = '0';
                          answer = '0';
                        });
                      },
                    );
                  }
                  if (index == 19) {
                    return MyButton(
                      backgroudColor: const Color.fromRGBO(132, 239, 197, 1),
                      buttonText: buttons[index],
                      color: Colors.white,
                      onPress: () {
                        setState(() {
                          userInput = '0';
                          answer = '0';
                        });
                      },
                    );
                  } else {
                    return MyButton(
                      backgroudColor: const Color.fromRGBO(248, 248, 248, 1),
                      buttonText: buttons[index],
                      color: const Color.fromRGBO(92, 92, 92, 1),
                      onPress: () {
                        setState(() {
                          userInput = '0';
                          answer = '0';
                        });
                      },
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
