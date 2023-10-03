import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils.dart';
import '../repos/authentication_repo.dart';
import 'users_view_model.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(
    String email,
    String password,
    BuildContext context,
  ) async {
    state = const AsyncValue.loading();
    final users = ref.read(usersProvider.notifier);

    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.emailSignUp(
        email,
        password,
      );

      await users.createProfile(userCredential);
    });
    if (state.hasError) {
      if (state.error is FirebaseAuthException) {
        FirebaseAuthException firebaseError =
            state.error as FirebaseAuthException;
        String msg = mapFirebaseErrorMessages(firebaseError.code);

        ref.container.read(signUpErrorMessageProvider.notifier).state = msg;
      } else {
        ref.container.read(signUpErrorMessageProvider.notifier).state =
            "알 수 없는 오류가 발생했습니다.";
      }
    }
  }
}

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);

final signUpErrorMessageProvider = StateProvider<String?>((ref) => null);
