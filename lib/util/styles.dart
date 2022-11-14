import 'package:flutter/material.dart';

class CommonTextStyle {
  static const textStyleNormal = TextStyle(
    color: Colors.black54,
    fontSize: 16.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const textStyleHeader = TextStyle(
    color: Colors.black54,
    fontSize: 16.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );
}

class CommonButtonStyle {
  static final buttonStyleNormal = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: const BorderSide(color: Colors.blue),
      ),
    ),
  );
}

