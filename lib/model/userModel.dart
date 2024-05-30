class UserModel {
  String uid;
  String email;
  String name;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? "",
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }

  // empty object
  static UserModel empty = UserModel(
    uid: '',
    email: '',
    name: '',
  );
}
