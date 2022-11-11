import 'package:flutter/material.dart';

class FinalResultWidget extends StatefulWidget {
  const FinalResultWidget({Key? key}) : super(key: key);

  @override
  State<FinalResultWidget> createState() => _FinalResultWidgetState();
}

class _FinalResultWidgetState extends State<FinalResultWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Final result'),
    );
  }
}
