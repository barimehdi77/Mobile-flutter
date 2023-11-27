import 'package:flutter/material.dart';

class DisplayErrorMessageWidget extends StatelessWidget {
  const DisplayErrorMessageWidget({
    super.key,
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.grey,
        ),
      ),
    );
  }
}
