import 'package:flutter_google_codelabs_tool/entity/quest/quest.dart';
import 'package:flutter_google_codelabs_tool/entity/quest/quest_stack.dart';

const useDumpData = String.fromEnvironment("data") == 'fake';

final validQuests = List<Quest>.from(const [
  Quest('Flutter Essentials', QuestStack.flutter),
  Quest('Flutter Development', QuestStack.flutter),

  Quest('How Google Does Machine Learning', QuestStack.machineLearning),
  Quest('Language, Speech, Text, & Translation with Google Cloud APIs', QuestStack.machineLearning),

  Quest('Cloud Badge 1', QuestStack.cloud),
  Quest('Cloud Badge 2', QuestStack.cloud),
]);

final validCodelabStartDate = DateTime(2022, 11, 13, 23, 59);
final validCodelabEndDate = DateTime(2022, 11, 28, 23, 59);

final validSubmitStartDate = DateTime(2022, 11, 18, 20, 50);
final validSubmitEndDate = DateTime(2022, 11, 30, 23, 59);

const appScriptUrlFromEnv = String.fromEnvironment("appscripturl");