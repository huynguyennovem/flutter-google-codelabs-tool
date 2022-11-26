import 'package:flutter_google_codelabs_tool/entity/quest/quest.dart';
import 'package:flutter_google_codelabs_tool/entity/quest/quest_stack.dart';

const useDumpData = String.fromEnvironment("data") == 'fake';

final validQuests = List.from(const [
  Quest('Flutter Essential', QuestStack.flutter),
  Quest('Flutter Development', QuestStack.flutter),

  Quest('How Google Does Machine Learning', QuestStack.machineLearning),
  Quest('Language, Speech, Text, & Translation with Google Cloud APIs', QuestStack.machineLearning),

  Quest('Undefined', QuestStack.cloud),
  Quest('Undefined', QuestStack.cloud),
]);
