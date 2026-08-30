import 'package:marketi/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.token,
    super.name,
    super.username,
    super.email,
    super.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final user = data['user'] ?? data;
    return UserModel(
      token: data['token'],
      name: user['name'],
      username: user['username'],
      email: user['email'],
      phone: user['phone'],
    );
  }
}