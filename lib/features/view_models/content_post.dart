import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/features/models/feeling_content.dart';
import 'package:mood_tracker/features/repos/content_repo.dart';

import '../../authentications/repos/authentication_repo.dart';

import '../models/feeling.dart';
import '../views/main_screen.dart';

class ContentPostViewModel extends AsyncNotifier<void> {
  late final ContentRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(contentRepo);
  }

  Future<void> postFeeling(
      String content, Feeling feeling, BuildContext context) async {
    final user = ref.read(authRepo).user;
    // final userProfile = ref.read(usersProvider).value; 필요 없음
    if (user == null) return;
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await _repository.postData(
          user.uid,
          FeelingContentModel(
            id: "",
            content: content,
            feeling: feeling,
            creatorUid: user.uid,
            createdAt: DateTime.now().microsecondsSinceEpoch,
          ));
    });

    // ignore: use_build_context_synchronously
    context.go("/home");
    mainScreenKey.currentState?.changeTab(0);
  }
}

final contentPostProvider = AsyncNotifierProvider<ContentPostViewModel, void>(
    () => ContentPostViewModel());
