import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mood_tracker/features/models/feeling.dart';

void showFirebaseErrorSnack(BuildContext context, Object? error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content:
          Text((error as FirebaseException).message ?? "Something went wrong"),
    ),
  );
}

String getTimeText(int timestamp) {
  final now = DateTime.now();
  final date = DateTime.fromMicrosecondsSinceEpoch(timestamp);
  final diff = now.difference(date);

  if (diff.inMinutes < 60) return '${diff.inMinutes}분 전';
  if (diff.inHours < 24) return '${diff.inHours}시간 전';
  if (diff.inDays == 1) return '어제';
  if (diff.inDays == 2) return '이틀 전';
  if (diff.inDays == 3) return '사흘 전';
  return DateFormat('yyyy년 M월 d일').format(date);
}

String getEmojiUrl(Feeling feeling) {
  switch (feeling) {
    case Feeling.angry:
      return 'assets/animations/angry.json';
    case Feeling.sad:
      return 'assets/animations/crying.json';
    case Feeling.gloomy:
      return 'assets/animations/gloomy.json';
    case Feeling.surprised:
      return 'assets/animations/surprised.json';
    case Feeling.smiling:
      return 'assets/animations/smiling.json';
    case Feeling.happy:
      return 'assets/animations/hahaha.json';
    default:
      return 'assets/animations/happy.json';
  }
}

String mapFirebaseErrorMessages(String errorCode) {
  switch (errorCode) {
    case "wrong-password":
      return "패스워드가 틀렸습니다";
    case "user-not-found":
      return "해당 이메일로 등록된 계정이 없습니다";
    case "too-many-requests":
      return "너무 많은 요청이 들어왔습니다. 잠시 후 다시 시도해주세요";
    case "email-already-in-use":
      return "이미 등록된 이메일입니다";
    case "invalid-email":
      return "이메일 형식이 올바르지 않습니다";
    case "weak-password":
      return "패스워드가 너무 짧거나 단순합니다";
    case "account-exists-with-different-credential":
      return "이미 등록된 이메일입니다";
    case "invalid-credential":
      return "이메일 형식이 올바르지 않습니다";
    case "operation-not-allowed":
      return "이메일 로그인이 허용되지 않았습니다";
    case "user-disabled":
      return "해당 계정은 비활성화되었습니다";
    case "user-mismatch":
      return "해당 이메일로 등록된 계정이 없습니다";
    default:
      return "알 수 없는 오류가 발생하였습니다";
  }
}
