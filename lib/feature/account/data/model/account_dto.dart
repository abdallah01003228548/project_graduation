import 'package:project_graduation/feature/account/domain/entities/account_entity.dart';

class AccountDto {
  String? name;
  String? email;
  String? phone;
  String? address;
  String? role;
  String? profileImage;
  String? password;

  AccountDto({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.role,
    this.profileImage,
    this.password,
  });

  AccountDto.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> dataMap = json['message'] is Map<String, dynamic>
        ? json['message'] as Map<String, dynamic>
        : (json['user'] is Map<String, dynamic>
            ? json['user'] as Map<String, dynamic>
            : (json['data'] is Map<String, dynamic>
                ? json['data'] as Map<String, dynamic>
                : json));

    name         = dataMap['name']?.toString();
    email        = dataMap['email']?.toString();
    phone        = dataMap['phone']?.toString();
    address      = dataMap['address']?.toString();
    role         = dataMap['role']?.toString();
    profileImage = (dataMap['image'] ?? dataMap['profileImage'] ?? dataMap['userImage'])?.toString();
    password     = dataMap['password']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name']  = name;
    data['email'] = email;
    if (phone != null)    data['phone'] = phone;
    if (address != null)  data['address'] = address;
    if (role != null)     data['role']  = role;
    if (profileImage != null) data['image'] = profileImage;
    if (password != null) data['password'] = password;
    return data;
  }

  AccountEntity toEntity() {
    return AccountEntity(
      name:         name ?? '',
      email:        email ?? '',
      phone:        phone,
      address:      address,
      role:         role,
      profileImage: profileImage,
      password:     password,
    );
  }
}
