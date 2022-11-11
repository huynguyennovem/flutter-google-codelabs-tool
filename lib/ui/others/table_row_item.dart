import 'package:flutter/material.dart';

class TableRowItem extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Alignment? childAlignment;

  const TableRowItem(
      {Key? key,
      required this.child,
      this.padding,
      this.childAlignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(4.0),
      child: Align(
        alignment: childAlignment ?? Alignment.center,
        child: child,
      ),
    );
  }
}
