import 'package:equatable/equatable.dart';
import 'package:flutter_google_codelabs_tool/util/extension.dart';

class Badge extends Equatable {
  final String owner;
  final String name;
  final DateTime earnedTime;

  const Badge(this.owner, this.name, this.earnedTime);

  @override
  List<Object> get props => [owner, name, earnedTime];
}

extension BadgeListExtension on List<Badge> {
  get concatBadgeName {
    return map((badge) => '- ${badge.name}').toList().join('\n');
  }

  get concatBadgeEarnedTime {
    return map((badge) => '- ${badge.earnedTime.toSimpleDateTime}').toList().join('\n');
  }
}