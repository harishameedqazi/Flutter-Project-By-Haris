class UserModel {
  String name;
  String email;
  String password;
  String id;
  String imageUrl;
  String usertype;
  String createdAt;
  String pushToken;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.id,
    required this.imageUrl,
    required this.usertype,
    required this.createdAt,
    required this.pushToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      id: json['id'],
      imageUrl: json['imageUrl'],
      usertype: json['usertype'],
      createdAt: json['createdAt'],
      pushToken: json['pushToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'id': id,
      'imageUrl': imageUrl,
      'usertype': usertype,
      'createdAt': createdAt,
      'pushToken': pushToken,
    };
  }
}
