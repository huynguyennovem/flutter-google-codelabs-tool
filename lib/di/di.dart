import 'package:get_it/get_it.dart';

import '../data/api_service.dart';

final getIt = GetIt.instance;

void setupDI() {
  getIt.registerSingleton<ApiService>(ApiService());
}
