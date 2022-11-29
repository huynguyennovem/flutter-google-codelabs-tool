import 'package:flutter/material.dart';
import 'package:flutter_google_codelabs_tool/entity/quest/quest_stack.dart';
import 'package:flutter_google_codelabs_tool/provider/participant_provider.dart';
import 'package:flutter_google_codelabs_tool/util/constant.dart';
import 'package:flutter_google_codelabs_tool/util/extension.dart';
import 'package:flutter_google_codelabs_tool/util/styles.dart';
import 'package:provider/provider.dart';

class AwardFilterWidget extends StatefulWidget {
  final int? topNumberToAward;

  const AwardFilterWidget({Key? key, required this.topNumberToAward}) : super(key: key);

  @override
  State<AwardFilterWidget> createState() => _AwardFilterWidgetState();
}

class _AwardFilterWidgetState extends State<AwardFilterWidget> {
  QuestStack _stack = QuestStack.flutter;
  DateTimeRange _selectedSubmitDate =
      DateTimeRange(start: validSubmitStartDate, end: validSubmitEndDate);
  DateTimeRange _selectedCodelabDate =
      DateTimeRange(start: validCodelabStartDate, end: validCodelabEndDate);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (c, boxConstraints) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          width: boxConstraints.maxWidth / 3,
          height: boxConstraints.maxHeight / 2,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Stack',
                  style:
                      CommonTextStyle.textStyleNormal.copyWith(color: Colors.black, fontSize: 16.0),
                ),
              ),
              ...QuestStack.values
                  .map((stack) => RadioListTile<QuestStack>(
                        title: Text(
                          stack.name.toUpperCase(),
                          style: CommonTextStyle.textStyleNormal.copyWith(fontSize: 12.0),
                        ),
                        value: stack,
                        groupValue: _stack,
                        onChanged: (QuestStack? value) {
                          if (value != null && value != _stack) {
                            setState(() {
                              _stack = value;
                            });
                          }
                        },
                      ))
                  .toList(),
              const SizedBox(height: 12.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Valid codelab time',
                  style:
                      CommonTextStyle.textStyleNormal.copyWith(color: Colors.black, fontSize: 16.0),
                ),
              ),
              ListTile(
                title: Text(_selectedCodelabDate.getFormattedDateRange),
                leading: const Icon(Icons.calendar_month),
                onTap: () {
                  _selectCodelabDate(context);
                },
              ),
              const SizedBox(height: 12.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Valid submit time',
                  style:
                      CommonTextStyle.textStyleNormal.copyWith(color: Colors.black, fontSize: 16.0),
                ),
              ),
              ListTile(
                title: Text(_selectedSubmitDate.getFormattedDateRange),
                leading: const Icon(Icons.calendar_month),
                onTap: () {
                  _selectSubmitDate(context);
                },
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  style: CommonButtonStyle.buttonStyleNormal,
                  onPressed: () => _findTopAward(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                    child: Text(
                      'Find',
                      style: CommonTextStyle.textStyleNormal.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectCodelabDate(BuildContext context) async {
    final picked = await showDateRangePicker(
      initialDateRange: DateTimeRange(start: validCodelabStartDate, end: validCodelabEndDate),
      context: context,
      firstDate: validCodelabStartDate,
      lastDate: validCodelabEndDate,
    );
    if (picked != null && picked != _selectedCodelabDate) {
      setState(() {
        _selectedCodelabDate = picked;
      });
    }
  }

  Future<void> _selectSubmitDate(BuildContext context) async {
    final picked = await showDateRangePicker(
      initialDateRange: DateTimeRange(start: validSubmitStartDate, end: validSubmitEndDate),
      context: context,
      firstDate: validSubmitStartDate,
      lastDate: validSubmitEndDate,
    );
    if (picked != null && picked != _selectedSubmitDate) {
      setState(() {
        _selectedSubmitDate = picked;
      });
    }
  }

  void _findTopAward() {
    if (!mounted) return;
    context.read<ParticipantProvider>().getAwards(
      stack: _stack,
      numberParticipant: widget.topNumberToAward,
      validCodelabTime: _selectedCodelabDate,
      validSubmitTime: _selectedSubmitDate,
    );
    Navigator.pop(context);
  }
}
