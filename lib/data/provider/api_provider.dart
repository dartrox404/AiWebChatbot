import 'package:aichat_web/data/service/api_service.dart';
import 'package:riverpod/riverpod.dart';

final apiProvider = Provider<ApiService>((ref) => ApiService());
