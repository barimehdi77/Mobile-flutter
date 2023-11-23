import 'package:flutter/material.dart';

class SizedBotton extends StatelessWidget {
  // factoy constractor used to display icon next to label
  factory SizedBotton.icon({
    required Widget icon,
    required Function() onPressed,
    String? label,
    double iconWidth = 30,
    Color iconColor = Colors.white,
    double width = 300,
    double height = 60,
    double borderRadius = 10,
    Color backgroundColor = Colors.white,
    double borderWidth = 0,
    Color borderColor = Colors.black,
    Color textColor = Colors.white,
  }) =>
      SizedBotton(
        useIcon: true,
        label: label,
        onPressed: onPressed,
        icon: icon,
        width: width,
        height: height,
        borderColor: borderColor,
        borderRadius: borderRadius,
        textColor: textColor,
        borderWidth: borderWidth,
        backgroundColor: backgroundColor,
      );

  // defualt constractor for the sizedBotton
  const SizedBotton({
    super.key,
    required this.label,
    required this.onPressed,
    this.useIcon = false,
    this.width = 300,
    this.height = 60,
    this.borderRadius = 10,
    this.backgroundColor = Colors.white,
    this.borderWidth = 0,
    this.borderColor = Colors.black,
    this.textColor = Colors.white,
    this.icon = const Icon(Icons.abc_outlined),
    this.textStyle = const TextStyle(
      color: Colors.white,
    ),
  });

  final bool useIcon;
  final Widget icon;
  final String? label;
  final double width;
  final double height;
  final double borderWidth;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final Function() onPressed;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    Widget normalBotton = ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: borderWidth == 0 ? backgroundColor : borderColor,
              width: borderWidth,
            ),
          ),
        ),
        backgroundColor: MaterialStateColor.resolveWith((states) {
          return backgroundColor;
        }),
      ),
      onPressed: onPressed,
      child: FittedBox(
        child: Text(
          label ?? "",
          style: textStyle,
        ),
      ),
    );

    Widget iconBotton = ElevatedButton.icon(
      icon: icon,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: borderWidth == 0 ? backgroundColor : borderColor,
              width: borderWidth,
            ),
          ),
        ),
        backgroundColor: MaterialStateColor.resolveWith((states) {
          return backgroundColor;
        }),
      ),
      onPressed: onPressed,
      label: FittedBox(
        child: Text(
          label ?? "",
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );

    return SizedBox(
      width: width,
      height: height,
      child: useIcon ? iconBotton : normalBotton,
    );
  }
}
