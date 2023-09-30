import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/features/models/feeling_content.dart';

class ContentRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> postData(String uid, FeelingContentModel data) async {
    await _db
        .collection("users")
        .doc(uid)
        .collection("feelings")
        .add(data.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchData(String uid,
      {int? lastItemCreatedAt}) {
    final query = _db
        .collection("users")
        .doc(uid)
        .collection("feelings")
        .orderBy("createdAt", descending: true)
        .limit(2);
    if (lastItemCreatedAt == null) {
      return query.get();
    } else {
      return query.startAfter([lastItemCreatedAt]).get();
    }
  }

  //delete data
  Future<void> deleteData(String uid, String contentId) async {
    await _db
        .collection("users")
        .doc(uid)
        .collection("feelings")
        .doc(contentId)
        .delete();
  }
}

final contentRepo = Provider((ref) => ContentRepository());
