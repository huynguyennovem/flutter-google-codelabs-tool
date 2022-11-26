import 'dart:async';

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_google_codelabs_tool/data/api_service.dart';
import 'package:flutter_google_codelabs_tool/di/di.dart';
import 'package:flutter_google_codelabs_tool/entity/api_error.dart';
import 'package:flutter_google_codelabs_tool/entity/badge.dart';
import 'package:flutter_google_codelabs_tool/ui/child_pages/single_result_table_widget.dart';
import 'package:flutter_google_codelabs_tool/ui/others/error_widget.dart';
import 'package:flutter_google_codelabs_tool/util/extension.dart';
import 'package:flutter_google_codelabs_tool/util/styles.dart';

class SingleTestWidget extends StatefulWidget {
  const SingleTestWidget({Key? key}) : super(key: key);

  @override
  State<SingleTestWidget> createState() => _SingleTestWidgetState();
}

class _SingleTestWidgetState extends State<SingleTestWidget> {
  final _inputPublicProfileUrl = TextEditingController();
  Future? _badgeFuture;
  StreamSubscription? _badgeSubscription;

  @override
  void initState() {
    super.initState();

    //TODO: remove this when releasing
    _inputPublicProfileUrl.text =
        'https://www.cloudskillsboost.google/public_profiles/48f6fc57-ef42-47e1-90cb-7c6e59569939';
    _onPressStart();
    //TODO-END
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single test'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 32.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Profile url',
                      border: OutlineInputBorder(),
                    ),
                    controller: _inputPublicProfileUrl,
                  ),
                ),
                const SizedBox(width: 16.0),
                SizedBox(
                  width: 96.0,
                  height: 48.0,
                  child: OutlinedButton(
                    style: CommonButtonStyle.buttonStyleNormal,
                    onPressed: () => _onPressStart(),
                    child: Text(
                      'Start',
                      style: CommonTextStyle.textStyleNormal.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            FutureBuilder(
              future: _badgeFuture,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  case ConnectionState.done:
                    if (snapshot.data is dartz.Left<ApiError, List<Badge>>) {
                      debugPrint(snapshot.data.value.toString());
                      return const CustomErrorWidget();
                    }
                    final value = snapshot.data as dartz.Either<ApiError, List<Badge>>;
                    final badges = value.asRight();
                    return Flexible(child: SingleResultTable(badges: badges));
                  default:
                    if (snapshot.hasError) {
                      return const CustomErrorWidget();
                    }
                    return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onPressStart() {
    final url = _inputPublicProfileUrl.text;
    if (url.isEmpty) return;
    try {
      _badgeSubscription?.cancel(); // cancel in-progressing future
      setState(() {
        _badgeFuture = getIt.get<ApiService>().getAllBadges(url);
        _badgeSubscription = _badgeFuture?.asStream().listen((data) {
          if (data is dartz.Left<ApiError, List<Badge>>) {
            debugPrint(data.value.toString());
            return;
          }
          final temp = data as dartz.Right<ApiError, List<Badge>>;
          for (var element in temp.value) {
            debugPrint(element.toString());
          }
        });
      });
    } catch (e) {
      debugPrint('Error when parsing badge info ${e.toString()}');
    }
  }
}
