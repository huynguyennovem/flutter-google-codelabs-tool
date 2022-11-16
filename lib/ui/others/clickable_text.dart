import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final Function? onTapAction;

  const ClickableText({
    Key? key,
    this.text,
    this.textStyle,
    this.onTapAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: textStyle ??
            TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.lightBlueAccent.shade200,
              fontSize: 16.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal,
            ),
        recognizer: TapGestureRecognizer()..onTap = () => onTapAction?.call(),
      ),
    );
  }
}
