import 'package:equatable/equatable.dart';
import 'package:flutter_google_codelabs_tool/entity/quest/quest_stack.dart';

class Quest extends Equatable {
  final String name;
  final QuestStack stack;

  const Quest(this.name, this.stack);

  @override
  List<Object> get props => [name, stack];
}

