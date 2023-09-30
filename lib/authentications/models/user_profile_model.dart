class UserProfileModel {
  final String uid;
  final String email;

  UserProfileModel({
    required this.uid,
    required this.email,
  });

  UserProfileModel.empty()
      : uid = "",
        email = "";

  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
    };
  }

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        email = json["email"];

  UserProfileModel copyWith({
    String? email,
    String? uid,
  }) {
    return UserProfileModel(
      email: email ?? this.email,
      uid: uid ?? this.uid,
    );
  }
}
