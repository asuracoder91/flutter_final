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
