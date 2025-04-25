class UserModel {
  final String id;
  final String name;
  final String avatar;
  final String createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      createdAt: json['createdAt'],
    );
  }
}
