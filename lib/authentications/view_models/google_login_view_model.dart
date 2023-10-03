import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils.dart';
import '../repos/authentication_repo.dart';
import 'login_view_model.dart';

class GoogleLoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> googleLogin(BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _repository.signInWithGoogle(),
    );
    if (state.hasError) {
      print(state.error);
      if (state.error is FirebaseAuthException) {
        FirebaseAuthException firebaseError =
            state.error as FirebaseAuthException;
        String msg = mapFirebaseErrorMessages(firebaseError.code);

        ref.container.read(errorMessageProvider.notifier).state = msg;
      } else {
        ref.container.read(errorMessageProvider.notifier).state =
            "알 수 없는 오류가 발생했습니다.";
      }
    }
  }
}

final googleLoginProvider = AsyncNotifierProvider<GoogleLoginViewModel, void>(
  () => GoogleLoginViewModel(),
);
