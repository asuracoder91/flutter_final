import 'package:mood_tracker/features/models/feeling.dart';

class FeelingContentModel {
  final String id;
  final String content;
  final Feeling feeling;
  final String creatorUid;
  final int createdAt;

  FeelingContentModel({
    required this.id,
    required this.content,
    required this.feeling,
    required this.creatorUid,
    required this.createdAt,
  });

  FeelingContentModel.fromJson(
      {required Map<String, dynamic> json, required String contentId})
      : content = json["content"],
        feeling = Feeling.values
            .firstWhere((e) => e.toString() == 'Feeling.${json["feeling"]}'),
        creatorUid = json["creatorUid"],
        createdAt = json["createdAt"],
        id = contentId;

  Map<String, dynamic> toJson() {
    return {
      "content": content,
      "feeling": feeling.toString().split('.').last,
      "creatorUid": creatorUid,
      "createdAt": createdAt,
      "id": id,
    };
  }
}
