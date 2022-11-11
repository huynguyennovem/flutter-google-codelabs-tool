import 'package:flutter/material.dart';
import 'package:flutter_google_codelabs_tool/ui/others/table_row_item.dart';
import 'package:flutter_google_codelabs_tool/util/extension.dart';
import 'package:flutter_google_codelabs_tool/util/styles.dart';

import '../entity/badge.dart';

class ResultTable extends StatefulWidget {
  const ResultTable({Key? key, required this.badges}) : super(key: key);

  final List<Badge> badges;

  @override
  State<ResultTable> createState() => _ResultTableState();
}

class _ResultTableState extends State<ResultTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87, width: 1.5),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(5),
          2: FlexColumnWidth(4),
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
                child: Text('Badge name',
                    style: CommonTextStyle.textStyleHeader.copyWith(color: Colors.white)),
              ),
              TableRowItem(
                child: Text('Earned time',
                    style: CommonTextStyle.textStyleHeader.copyWith(color: Colors.white)),
              ),
            ],
          ),
          ..._buildListBadge(),
        ],
      ),
    );
  }

  _buildListBadge() {
    return widget.badges.map((badge) {
      String index = widget.badges.indexOf(badge).toString();
      return TableRow(
        children: [
          TableRowItem(child: Text(index, style: CommonTextStyle.textStyleNormal)),
          TableRowItem(
            childAlignment: Alignment.centerLeft,
            child: Text(badge.name, style: CommonTextStyle.textStyleNormal),
          ),
          TableRowItem(
            child: Text(badge.earnedTime.toSimpleDateTime, style: CommonTextStyle.textStyleNormal),
          ),
        ],
      );
    }).toList();
  }
}
