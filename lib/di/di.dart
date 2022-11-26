import 'package:flutter_google_codelabs_tool/data/local_data.dart';
import 'package:get_it/get_it.dart';

import '../data/api_service.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt.registerSingleton<ApiService>(ApiService());
  getIt.registerSingleton<LocalData>(LocalData());
}
