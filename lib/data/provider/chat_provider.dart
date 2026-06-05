import 'package:aichat_web/data/provider/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/legacy.dart';

final chatProvider = StateNotifierProvider<ChatNotifier, AsyncValue<String>>(
  (ref) => ChatNotifier(ref),
);

class ChatNotifier extends StateNotifier<AsyncValue<String>> {
  final Ref x;
  ChatNotifier(this.x) : super(AsyncValue.data(''));
  Future<void> getmessage(String message) async {
    state = const AsyncLoading();
    try {
      final response = x.read(apiProvider).aimessage(message);
      state = AsyncValue.data(await response);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
