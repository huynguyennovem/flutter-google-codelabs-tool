import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_codelabs_tool/entity/quest/quest.dart';
import 'package:flutter_google_codelabs_tool/entity/quest/quest_stack.dart';
import 'package:intl/intl.dart';

extension EitherX<L, R> on Either<L, R> {
  R asRight() => (this as Right).value; //
  L asLeft() => (this as Left).value;
}

extension DateTimeFormat on DateTime {
  String get toSimpleDateTime {
    final formatter = DateFormat('MMM d yyyy');
    return formatter.format(this);
  }

  String get toFullDateTime {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(this);
  }
}

extension ListDataExtension<T> on List<T>? {
  bool get notNullOrEmpty => this?.isNotEmpty == true;

  bool get nullOrEmpty => this == null || this?.isEmpty == true;
}

extension QuestExtension on List<Quest> {
  List<String> listQuestName({required QuestStack stack}) {
    return where((q) => q.stack == stack).map((e) => e.name).toList();
  }
}

extension DateTimeRangeExtension on DateTimeRange {
  String get getFormattedDateRange {
    final formatter = DateFormat('MM/dd/yyyy');
    return '${formatter.format(start)} - ${formatter.format(end)}';
  }

}