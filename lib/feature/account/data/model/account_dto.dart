import 'package:project_graduation/feature/account/domain/entities/account_entity.dart';
import 'package:project_graduation/core/network/api/api_constants.dart';

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
    final Map<String, dynamic> dataMap;

    if (json['message'] is Map<String, dynamic>) {
      dataMap = json['message'] as Map<String, dynamic>;
    } else if (json['user'] is Map<String, dynamic>) {
      dataMap = json['user'] as Map<String, dynamic>;
    } else if (json['data'] is Map<String, dynamic>) {
      dataMap = json['data'] as Map<String, dynamic>;
    } else {
      dataMap = json;
    }

    name = dataMap['name']?.toString();
    email = dataMap['email']?.toString();
    phone = dataMap['phone']?.toString();
    address = dataMap['address']?.toString();
    role = dataMap['role']?.toString();

    profileImage = (
      dataMap['image'] ??
      dataMap['profileImage'] ??
      dataMap['userImage']
    )?.toString();

    password = dataMap['password']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (role != null) 'role': role,
      if (profileImage != null) 'image': profileImage,
      if (password != null) 'password': password,
    };
  }

  AccountEntity toEntity() {
    return AccountEntity(
      name: name ?? '',
      email: email ?? '',
      phone: phone,
      address: address,
      role: role,
      profileImage: _buildImageUrl(profileImage),
      password: password,
    );
  }

  String? _buildImageUrl(String? image) {
    if (image == null || image.trim().isEmpty) {
      return null;
    }

    final imagePath = image.trim();

    if (imagePath.startsWith('http://') ||
        imagePath.startsWith('https://')) {
      return imagePath;
    }

    final path = imagePath.startsWith('/')
        ? imagePath
        : '/$imagePath';

    return '${ApiConstants.serverUrl}$path';
  }
}