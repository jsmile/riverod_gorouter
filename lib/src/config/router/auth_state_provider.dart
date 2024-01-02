import 'package:riverod_gorouter/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.g.dart';

@riverpod
class AuthStateNoti extends _$AuthStateNoti {
  @override
  bool build() {
    // return false
    return ref.read(sharedPreferencesProvider).getBool('auth') ?? false;
  }

  void setAuthenticated(bool auth) async {
    // 영구 state 저장
    await ref.read(sharedPreferencesProvider).setBool('auth', auth);
    // auth state 변경
    state = auth;
  }
}
