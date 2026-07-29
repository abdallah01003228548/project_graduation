import 'package:project_graduation/feature/account/domain/entities/account_entity.dart';

class AccountDto {
  String? name;
  String? email;
  String? profileImage;
  String? password;

  AccountDto({this.name, this.email, this.profileImage, this.password});

  AccountDto.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> dataMap = json['user'] is Map<String, dynamic>
        ? json['user'] as Map<String, dynamic>
        : (json['data'] is Map<String, dynamic>
            ? json['data'] as Map<String, dynamic>
            : json);

    name = dataMap['name']?.toString();
    email = dataMap['email']?.toString();
    profileImage = (dataMap['profileImage'] ?? dataMap['image'] ?? dataMap['userImage'])?.toString();
    password = dataMap['password']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['profileImage'] = profileImage;
    if (password != null) {
      data['password'] = password;
    }
    return data;
  }

  AccountEntity toEntity() {
    return AccountEntity(
      name: name ?? '',
      email: email ?? '',
      profileImage: profileImage,
      password: password,
    );
  }
}
