import 'package:flutter/material.dart';
import 'package:flutter_google_codelabs_tool/provider/participant_provider.dart';
import 'package:provider/provider.dart';

import 'di/di.dart';
import 'ui/home_widget.dart';

void main() {
  setupDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ParticipantProvider()),
      ],
      child: MaterialApp(
        title: 'Google codelabs tool',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeWidget(),
      ),
    );
  }
}
