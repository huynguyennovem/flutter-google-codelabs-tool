import 'package:flutter/material.dart';
import 'package:flutter_google_codelabs_tool/entity/badge.dart';
import 'package:flutter_google_codelabs_tool/entity/participant.dart';
import 'package:flutter_google_codelabs_tool/entity/sort/order_type.dart';
import 'package:flutter_google_codelabs_tool/entity/sort/sort_type.dart';
import 'package:flutter_google_codelabs_tool/entity/sort/sorter.dart';
import 'package:flutter_google_codelabs_tool/provider/participant_provider.dart';
import 'package:flutter_google_codelabs_tool/ui/child_pages/award_filter_widget.dart';
import 'package:flutter_google_codelabs_tool/ui/others/clickable_text.dart';
import 'package:flutter_google_codelabs_tool/ui/others/table_row_item.dart';
import 'package:flutter_google_codelabs_tool/util/extension.dart';
import 'package:flutter_google_codelabs_tool/util/styles.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FinalResultTable extends StatefulWidget {
  const FinalResultTable({Key? key}) : super(key: key);

  @override
  State<FinalResultTable> createState() => _FinalResultTableState();
}

class _FinalResultTableState extends State<FinalResultTable> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ParticipantProvider>(
      builder: (BuildContext context, ParticipantProvider provider, Widget? child) {
        final currentSorter = provider.sorter;
        return SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableText(
                    'Number participants: ${provider.participants.length}',
                    style: CommonTextStyle.textStyleNormal.copyWith(color: Colors.black),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        tooltip: 'Reset data to origin',
                        onPressed: () => _resetDataToOrigin(),
                        icon: const Icon(Icons.restart_alt),
                      ),
                      PopupMenuButton(
                        icon: const Icon(Icons.military_tech_rounded),
                        tooltip: 'Top awards',
                        itemBuilder: (context) => <PopupMenuEntry>[
                          _topTitle(),
                          const PopupMenuDivider(),
                          _top2(),
                          _top5(),
                          _allCompletedLab(),
                        ],
                      ),
                      PopupMenuButton<Sorter>(
                        icon: const Icon(Icons.filter_alt),
                        tooltip: 'Sort data',
                        itemBuilder: (context) => <PopupMenuEntry<Sorter>>[
                          _sortTitle(),
                          const PopupMenuDivider(),
                          _sortSubmittedTime(currentSorter),
                          _sortName(currentSorter),
                          _sortNumberBadges(currentSorter),
                          _sortCompleted(currentSorter),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              _buildTable(provider.participants),
            ],
          ),
        );
      },
    );
  }

  _sortTitle() => const PopupMenuItem<Sorter>(
    enabled: false,
    child: ListTile(
      leading: Icon(Icons.filter_list_alt),
      title: Text('SORT BY'),
    ),
  );

  _sortSubmittedTime(Sorter currentSorter) => PopupMenuItem<Sorter>(
    padding: EdgeInsets.zero,
    value: Sorter(
      sortType: SortType.submittedTime,
      orderType: currentSorter.orderType,
    ),
    child: ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 240),
      child: ListTile(
        mouseCursor: SystemMouseCursors.click,
        leading: const Icon(Icons.timelapse),
        trailing: _getTrailIconByOrder(
          currentSorter: currentSorter,
          menuSortType: SortType.submittedTime,
        ),
        title: const Text('Submitted time'),
        onTap: () {
          final orderType = currentSorter.sortType == SortType.submittedTime
              ? currentSorter.orderType.switchOrderType
              : OrderType.desc;
          final newSorter = Sorter(
            sortType: SortType.submittedTime,
            orderType: orderType,
          );
          _onSelectedSort(newSorter);
        },
      ),
    ),
  );

  _sortName(Sorter currentSorter) => PopupMenuItem<Sorter>(
    padding: EdgeInsets.zero,
    value: Sorter(
      sortType: SortType.fullName,
      orderType: currentSorter.orderType,
    ),
    child: ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 240),
      child: ListTile(
        mouseCursor: SystemMouseCursors.click,
        leading: const Icon(Icons.person),
        trailing: _getTrailIconByOrder(
          currentSorter: currentSorter,
          menuSortType: SortType.fullName,
        ),
        title: const Text('Name'),
        onTap: () {
          final orderType = currentSorter.sortType == SortType.fullName
              ? currentSorter.orderType.switchOrderType
              : OrderType.desc;
          final newSorter = Sorter(
            sortType: SortType.fullName,
            orderType: orderType,
          );
          _onSelectedSort(newSorter);
        },
      ),
    ),
  );

  _sortNumberBadges(Sorter currentSorter) => PopupMenuItem<Sorter>(
    padding: EdgeInsets.zero,
    value: Sorter(
      sortType: SortType.numBadges,
      orderType: currentSorter.orderType,
    ),
    child: ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 240),
      child: ListTile(
        mouseCursor: SystemMouseCursors.click,
        leading: const Icon(Icons.badge),
        trailing: _getTrailIconByOrder(
          currentSorter: currentSorter,
          menuSortType: SortType.numBadges,
        ),
        title: const Text('Number of badges'),
        onTap: () {
          final orderType = currentSorter.sortType == SortType.numBadges
              ? currentSorter.orderType.switchOrderType
              : OrderType.desc;
          final newSorter = Sorter(
            sortType: SortType.numBadges,
            orderType: orderType,
          );
          _onSelectedSort(newSorter);
        },
      ),
    ),
  );

  _sortCompleted(Sorter currentSorter) => PopupMenuItem<Sorter>(
    padding: EdgeInsets.zero,
    value: Sorter(
      sortType: SortType.completedTime,
      orderType: currentSorter.orderType,
    ),
    child: ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 240),
      child: ListTile(
        mouseCursor: SystemMouseCursors.click,
        leading: const Icon(Icons.timer_sharp),
        trailing: _getTrailIconByOrder(
          currentSorter: currentSorter,
          menuSortType: SortType.completedTime,
        ),
        title: const Text('Completed time'),
        onTap: () {
          final orderType = currentSorter.sortType == SortType.completedTime
              ? currentSorter.orderType.switchOrderType
              : OrderType.desc;
          final newSorter = Sorter(
            sortType: SortType.completedTime,
            orderType: orderType,
          );
          _onSelectedSort(newSorter);
        },
      ),
    ),
  );

  _topTitle() => const PopupMenuItem(
    enabled: false,
    child: ListTile(
      leading: Icon(Icons.military_tech_rounded),
      title: Text('TOP AWARDS'),
    ),
  );

  _top2() => PopupMenuItem(
    padding: EdgeInsets.zero,
    child: ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 240),
      child: ListTile(
        mouseCursor: SystemMouseCursors.click,
        title: const Text('Top 2 finished fastest'),
        onTap: () {
          _getAwards(numberParticipant: 2);
        },
      ),
    ),
  );

  _top5() => PopupMenuItem(
    padding: EdgeInsets.zero,
    child: ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 240),
      child: ListTile(
        mouseCursor: SystemMouseCursors.click,
        title: const Text('Top 5 finished fastest'),
        onTap: () {
          _getAwards(numberParticipant: 5);
        },
      ),
    ),
  );

  _allCompletedLab() => PopupMenuItem(
    padding: EdgeInsets.zero,
    child: ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 240),
      child: ListTile(
        mouseCursor: SystemMouseCursors.click,
        title: const Text('All completed lab'),
        onTap: () {
          _getAwards();
        },
      ),
    ),
  );

  _buildTable(List<Participant> participants) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87, width: 1.5),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        thickness: 5.0,
        radius: const Radius.circular(0.5),
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Table(
            columnWidths: const {
              0: FixedColumnWidth(50),
              1: FixedColumnWidth(150),
              2: FixedColumnWidth(250),
              3: FixedColumnWidth(150),
              4: FixedColumnWidth(300),
              5: FixedColumnWidth(150),
              6: FixedColumnWidth(400),
              7: FixedColumnWidth(150),
            },
            border: const TableBorder(
              horizontalInside: BorderSide(color: Colors.black87),
              verticalInside: BorderSide(color: Colors.black87),
            ),
            children: [
              _buildTableHeader(),
              ..._buildTableData(participants),
            ],
          ),
        ),
      ),
    );
  }

  _buildTableHeader() {
    return TableRow(
      decoration: const BoxDecoration(color: Colors.blue),
      children: [
        TableRowItem(
          child: Text('STT', style: CommonTextStyle.textStyleHeader.copyWith(color: Colors.white)),
        ),
        TableRowItem(
          child: Text('Submitted time',
              style: CommonTextStyle.textStyleHeader.copyWith(color: Colors.white)),
        ),
        TableRowItem(
          child:
              Text('Email', style: CommonTextStyle.textStyleHeader.copyWith(color: Colors.white)),
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
    );
  }

  _buildTableData(List<Participant> participants) {
    return participants.map((participant) {
      String index = participants.indexOf(participant).toString();
      return TableRow(
        children: [
          TableRowItem(child: SelectableText(index, style: CommonTextStyle.textStyleNormal)),
          TableRowItem(
            childAlignment: Alignment.centerLeft,
            child: SelectableText(
              participant.timeStamp.toFullDateTime,
              style: CommonTextStyle.textStyleNormal,
            ),
          ),
          TableRowItem(
            childAlignment: Alignment.centerLeft,
            child: SelectableText(participant.email, style: CommonTextStyle.textStyleNormal),
          ),
          TableRowItem(
            childAlignment: Alignment.centerLeft,
            child: SelectableText(participant.receiveCertMethod, style: CommonTextStyle.textStyleNormal),
          ),
          TableRowItem(
            childAlignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(4.0).copyWith(bottom: 16.0),
            child: ClickableText(
              text: participant.publicProfile,
              onTapAction: () async {
                final uri = Uri.parse(participant.publicProfile);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  debugPrint('Can not launch $uri');
                }
              },
            ),
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
        child: SelectableText(badges.first.owner, style: CommonTextStyle.textStyleNormal),
      ),
      TableRowItem(
        childAlignment: Alignment.centerLeft,
        child: SelectableText(badges.concatBadgeName ?? 'Undefined', style: CommonTextStyle.textStyleNormal),
      ),
      TableRowItem(
        childAlignment: Alignment.centerLeft,
        child: SelectableText(badges.concatBadgeEarnedTime ?? 'Undefined',
            style: CommonTextStyle.textStyleNormal),
      ),
    ];
  }

  _getTrailIconByOrder({required Sorter currentSorter, required SortType menuSortType}) {
    if (currentSorter.sortType != menuSortType) {
      return const SizedBox.shrink();
    }
    return currentSorter.orderType == OrderType.desc
        ? const Icon(Icons.expand_more)
        : const Icon(Icons.expand_less);
  }

  void _onSelectedSort(Sorter sorter) {
    if (!mounted) return;
    context.read<ParticipantProvider>().sortParticipants(sorter: sorter);
    Navigator.pop(context);
  }

  void _getAwards({int? numberParticipant}) {
    showDialog(
      context: context,
      builder: (context) {
        final dialog = Dialog(
          elevation: 12.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
          child: AwardFilterWidget(topNumberToAward: numberParticipant),
        );
        return dialog;
      },
    ).then((value) {
      Navigator.pop(context);
    });
  }

  void _resetDataToOrigin() {
    if (!mounted) return;
    context.read<ParticipantProvider>().resetDataToOrigin(needNotify: true);
  }
}
