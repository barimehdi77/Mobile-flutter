import 'package:flutter/material.dart';

class ListContainerWidget extends StatelessWidget {
  const ListContainerWidget({
    super.key,
    required this.child,
    this.width = 50,
    this.height = 210,
    this.padding = const EdgeInsets.all(10),
    this.margin = const EdgeInsets.only(top: 0),
  });

  final double width;
  final double height;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: MediaQuery.of(context).size.width - width,
      height: MediaQuery.of(context).size.height - height,
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
