class UserModel {
  final int? id;
  final String username;
  final String email;
  final String password;
  final String name;

  UserModel({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'name': name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
      name: map['name'],
    );
  }
}
