import 'package:flutter/material.dart';

class ListContainerWidget extends StatelessWidget {
  const ListContainerWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 30),
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height - 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 20,
          )
        ],
      ),
      child: child,
    );
  }
}
