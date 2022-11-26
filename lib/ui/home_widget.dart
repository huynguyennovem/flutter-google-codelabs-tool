import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_google_codelabs_tool/ui/guideline_widget.dart';
import 'package:flutter_google_codelabs_tool/ui/single_test_widget.dart';
import 'package:flutter_google_codelabs_tool/ui/final_result_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _navigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBarTheme(
      data: const BottomNavigationBarThemeData(
        unselectedItemColor: Colors.lightBlueAccent,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      child: AdaptiveScaffold(
        smallBreakpoint: const WidthPlatformBreakpoint(end: 700),
        mediumBreakpoint: const WidthPlatformBreakpoint(begin: 700, end: 1000),
        largeBreakpoint: const WidthPlatformBreakpoint(begin: 1000),
        useDrawer: false,
        destinations: const <NavigationDestination>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Final result'),
          NavigationDestination(icon: Icon(Icons.looks_one_outlined), label: 'Single test'),
          NavigationDestination(icon: Icon(Icons.book), label: 'Guideline'),
        ],
        onSelectedIndexChange: (p0) {
          if(_navigationIndex == p0) return;
          setState(() {
            _navigationIndex = p0;
          });
        },
        selectedIndex: _navigationIndex,
        body: (_) {
          switch (_navigationIndex) {
            case 0:
              return const FinalResultWidget();
            case 1:
              return const SingleTestWidget();
            case 2:
              return const GuidelineWidget();
          }
          return const SizedBox.shrink();
        },
        smallBody: null,
        secondaryBody: null,
        // Override the default secondaryBody during the smallBreakpoint to be
        // empty. Must use AdaptiveScaffold.emptyBuilder to ensure it is properly
        // overridden.
        smallSecondaryBody: null,
      ),
    );
  }
}
