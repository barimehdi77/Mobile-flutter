import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color color;
  final Color backgroudColor;
  final String buttonText;
  final Function onPress;

  const MyButton({
    super.key,
    required this.color,
    required this.backgroudColor,
    required this.buttonText,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            width: 2,
            color: const Color.fromRGBO(245, 245, 245, 1),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            color: backgroudColor,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: color,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
