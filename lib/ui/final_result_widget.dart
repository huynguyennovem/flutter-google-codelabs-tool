import 'dart:async';

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_google_codelabs_tool/data/api_service.dart';
import 'package:flutter_google_codelabs_tool/data/local_data.dart';
import 'package:flutter_google_codelabs_tool/di/di.dart';
import 'package:flutter_google_codelabs_tool/entity/api_error.dart';
import 'package:flutter_google_codelabs_tool/entity/participant.dart';
import 'package:flutter_google_codelabs_tool/provider/participant_provider.dart';
import 'package:flutter_google_codelabs_tool/ui/child_pages/final_result_table_widget.dart';
import 'package:flutter_google_codelabs_tool/ui/others/error_widget.dart';
import 'package:flutter_google_codelabs_tool/util/constant.dart';
import 'package:flutter_google_codelabs_tool/util/extension.dart';
import 'package:flutter_google_codelabs_tool/util/styles.dart';
import 'package:provider/provider.dart';

class FinalResultWidget extends StatefulWidget {
  const FinalResultWidget({Key? key}) : super(key: key);

  @override
  State<FinalResultWidget> createState() => _FinalResultWidgetState();
}

class _FinalResultWidgetState extends State<FinalResultWidget> {
  final _appScriptUrl = TextEditingController();
  Future? _finalDataFuture;
  StreamSubscription? _finalDataSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if(appScriptUrlFromEnv.isNotEmpty) {
        _appScriptUrl.text = appScriptUrlFromEnv;
      }
      _onPressStart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 32.0),
            _buildInputField(),
            const SizedBox(height: 28.0),
            FutureBuilder(
              future: _finalDataFuture,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  case ConnectionState.done:
                    if (snapshot.data is dartz.Left<ApiError, List<Participant>>) {
                      debugPrint(snapshot.data.value.toString());
                      return const CustomErrorWidget();
                    }
                    return const Flexible(child: FinalResultTable());
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

  _buildInputField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Google Apps Script - Web app url',
              border: OutlineInputBorder(),
            ),
            controller: _appScriptUrl,
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
    );
  }

  _onPressStart() async {
    final url = _appScriptUrl.text;
    if (url.isEmpty) return;
    try {
      _finalDataSubscription?.cancel();
      setState(() {
        _finalDataFuture = useDumpData
            ? getIt.get<LocalData>().getFakeResult()
            : getIt.get<ApiService>().getFinalResult(url);
        _finalDataSubscription = _finalDataFuture?.asStream().listen((data) {
          // logging only
          if (data is dartz.Left<ApiError, List<Participant>>) {
            debugPrint(data.value.toString());
            return;
          }
          final participants = data as dartz.Right<ApiError, List<Participant>>;
          for (var element in participants.value) {
            debugPrint(element.toString());
          }

          // updating data in provider
          if (!mounted) return;
          context
              .read<ParticipantProvider>()
              .addAllParticipants(participants: participants.asRight(), useInitSorter: true);
        });
      });
    } catch (e) {
      debugPrint('Error when parsing final result from AppScript data ${e.toString()}');
    }
  }
}
