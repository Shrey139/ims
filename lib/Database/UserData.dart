import 'package:meta/meta.dart';

class UserData {
  int id;
  final String name;
  final String mobile;
  final String role;
  final String token;

  UserData({
    @required this.name,
    @required this.mobile,
    @required this.role,
    @required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mobile': mobile,
      'role': role,
      'token': token,
    };
  }

  static UserData fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'],
      mobile: map['mobile'],
      role: map['role'],
      token: map['token'],
    );
  }
}
