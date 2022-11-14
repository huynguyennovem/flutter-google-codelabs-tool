import 'package:flutter/material.dart';
import 'package:flutter_google_codelabs_tool/entity/badge.dart';
import 'package:flutter_google_codelabs_tool/entity/participant.dart';
import 'package:flutter_google_codelabs_tool/ui/others/table_row_item.dart';
import 'package:flutter_google_codelabs_tool/util/extension.dart';
import 'package:flutter_google_codelabs_tool/util/styles.dart';

class FinalResultTable extends StatefulWidget {
  const FinalResultTable({Key? key, required this.participants}) : super(key: key);

  final List<Participant> participants;

  @override
  State<FinalResultTable> createState() => _FinalResultTableState();
}

class _FinalResultTableState extends State<FinalResultTable> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87, width: 1.5),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(50),
              1: FixedColumnWidth(150),
              2: FixedColumnWidth(250),
              3: FixedColumnWidth(250),
              4: FixedColumnWidth(500),
              5: FixedColumnWidth(200),
              6: FixedColumnWidth(200),
              7: FixedColumnWidth(150),
            },
            border: const TableBorder(
              horizontalInside: BorderSide(color: Colors.black87),
              verticalInside: BorderSide(color: Colors.black87),
            ),
            children: [
              TableRow(
                decoration: const BoxDecoration(color: Colors.blue),
                children: [
                  TableRowItem(
                    child: Text('STT',
                        style: CommonTextStyle.textStyleHeader.copyWith(color: Colors.white)),
                  ),
                  TableRowItem(
                    child: Text('Submitted time',
                        style: CommonTextStyle.textStyleHeader.copyWith(color: Colors.white)),
                  ),
                  TableRowItem(
                    child: Text('Email',
                        style: CommonTextStyle.textStyleHeader.copyWith(color: Colors.white)),
                  ),
                  TableRowItem(
                    child: Text('Receive cert method',
                        style: CommonTextStyle.textStyleHeader.copyWith(color: Colors.white)),
                  ),
                  TableRowItem(
                    child: Text('Public profile link',
                        style: CommonTextStyle.textStyleHeader.copyWith(color: Colors.white)),
                  ),
                  TableRowItem(
                    child: Text('Full name',
                        style: CommonTextStyle.textStyleHeader.copyWith(color: Colors.white)),
                  ),
                  TableRowItem(
                    child: Text('Badge name',
                        style: CommonTextStyle.textStyleHeader.copyWith(color: Colors.white)),
                  ),
                  TableRowItem(
                    child: Text('Earned badge time',
                        style: CommonTextStyle.textStyleHeader.copyWith(color: Colors.white)),
                  ),
                ],
              ),
              ..._buildListParticipant(),
            ],
          ),
        ),
      ),
    );
  }

  _buildListParticipant() {
    return widget.participants.map((participant) {
      String index = widget.participants.indexOf(participant).toString();
      return TableRow(
        children: [
          TableRowItem(child: Text(index, style: CommonTextStyle.textStyleNormal)),
          TableRowItem(
            childAlignment: Alignment.centerLeft,
            child: Text(
              participant.timeStamp.toSimpleDateTime,
              style: CommonTextStyle.textStyleNormal,
            ),
          ),
          TableRowItem(
            childAlignment: Alignment.centerLeft,
            child: Text(participant.email, style: CommonTextStyle.textStyleNormal),
          ),
          TableRowItem(
            childAlignment: Alignment.centerLeft,
            child: Text(participant.receiveCertMethod, style: CommonTextStyle.textStyleNormal),
          ),
          TableRowItem(
            childAlignment: Alignment.centerLeft,
            child: Text(participant.publicProfile, style: CommonTextStyle.textStyleNormal),
          ),
          ..._buildBadgesRowItems(participant.badges),
        ],
      );
    }).toList();
  }

  _buildBadgesRowItems(List<Badge>? badges) {
    if (badges == null || badges.isEmpty) return List<Widget>.filled(3, const SizedBox.shrink());
    return [
      TableRowItem(
        childAlignment: Alignment.centerLeft,
        child: Text(badges.first.owner, style: CommonTextStyle.textStyleNormal),
      ),
      TableRowItem(
        childAlignment: Alignment.centerLeft,
        child: Text(badges.concatBadgeName ?? 'Undefined', style: CommonTextStyle.textStyleNormal),
      ),
      TableRowItem(
        childAlignment: Alignment.centerLeft,
        child: Text(badges.concatBadgeEarnedTime ?? 'Undefined',
            style: CommonTextStyle.textStyleNormal),
      ),
    ];
  }
}
