import 'package:marketi/features/profile/domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    super.id,
    super.name,
    super.username,
    super.email,
    super.phone,
    super.city,
    super.avatar,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'],
      name: json['name'],
      username: json['username'], 
      email: json['email'],
      phone: json['phone'],
      city: json['city'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (city != null) 'city': city,
    };
  }
}