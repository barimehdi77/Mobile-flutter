import 'package:ex03/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
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
  String userInput = '0';
  String answer = '0';
  bool isDouble = false;

  // Array of button
  final List<String> buttons = [
    'AC',
    'C',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '00',
    '=',
  ];

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
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
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
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
            flex: 2,
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
                physics: const NeverScrollableScrollPhysics(),
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: isPortrait ? 1 : 5,
                ),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return MyButton(
                      backgroudColor: const Color.fromRGBO(248, 248, 248, 1),
                      buttonText: buttons[index],
                      color: const Color.fromRGBO(254, 135, 136, 1),
                      onPress: () {
                        debugPrint('button pressed :${buttons[index]}');
                        setState(() {
                          isDouble = false;
                          userInput = '0';
                          answer = '0';
                        });
                      },
                    );
                  }
                  if (index == 1) {
                    return MyButton(
                      backgroudColor: const Color.fromRGBO(248, 248, 248, 1),
                      buttonText: buttons[index],
                      color: const Color.fromRGBO(254, 135, 136, 1),
                      onPress: () {
                        debugPrint('button pressed :${buttons[index]}');
                        setState(() {
                          if (userInput != '0') {
                            if (userInput[userInput.length - 1] == '.') {
                              isDouble = false;
                            }
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          }
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
                        debugPrint('button pressed :${buttons[index]}');
                        setState(() {
                          if (!isNumeric(userInput[userInput.length - 1])) {
                            userInput =
                                userInput.substring(0, userInput.length - 1) +
                                    buttons[index];
                          } else {
                            isDouble = false;
                            userInput += buttons[index];
                          }
                        });
                      },
                    );
                  }
                  if (index == 17) {
                    return MyButton(
                      backgroudColor: const Color.fromRGBO(248, 248, 248, 1),
                      buttonText: buttons[index],
                      color: const Color.fromRGBO(92, 92, 92, 1),
                      onPress: () {
                        debugPrint('button pressed :${buttons[index]}');
                        setState(() {
                          if (!isDouble) {
                            isDouble = true;
                            userInput += buttons[index];
                          }
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
                        debugPrint('button pressed :${buttons[index]}');
                        setState(() {
                          equalPressed();
                        });
                      },
                    );
                  } else {
                    return MyButton(
                      backgroudColor: const Color.fromRGBO(248, 248, 248, 1),
                      buttonText: buttons[index],
                      color: const Color.fromRGBO(92, 92, 92, 1),
                      onPress: () {
                        debugPrint('button pressed :${buttons[index]}');
                        setState(() {
                          if (userInput == '0') {
                            userInput = buttons[index];
                          } else if (userInput.length < 40) {
                            userInput += buttons[index];
                          }
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
