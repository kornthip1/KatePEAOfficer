import 'dart:convert';

class UserModel {
  final String name;
  final String user;
  final String password;

  final String employedid;
  UserModel({
    this.name,
    this.user,
    this.password,
    this.employedid,
  });

  UserModel copyWith({
    String name,
    String user,
    String password,
    String employedid,
  }) {
    return UserModel(
      name: name ?? this.name,
      user: user ?? this.user,
      password: password ?? this.password,
      employedid: employedid ?? this.employedid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'user': user,
      'password': password,
      'employedid': employedid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      user: map['user'],
      password: map['password'],
      employedid: map['employedid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, user: $user, password: $password, employedid: $employedid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.user == user &&
        other.password == password &&
        other.employedid == employedid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        user.hashCode ^
        password.hashCode ^
        employedid.hashCode;
  }
}
