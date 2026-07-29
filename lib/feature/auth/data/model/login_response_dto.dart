import 'package:project_graduation/feature/auth/domain/entity/login_response_entitiy.dart';

class LoginResponseDto {
  String? message;
  String? token;
  AppUserDto? user;

  LoginResponseDto({this.message, this.token, this.user});

  LoginResponseDto.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new AppUserDto.fromJson(json['user']) : null;
  }


// to entity 
LoginResponseEntity toEntity() {
  return LoginResponseEntity(
    message: message ?? '',
    token: token ?? '',
    user: user!.toEntity(),
  );
}
}

class AppUserDto {
  String? name;
  String? phone;
  String? email;
  String? role;
  String? image;

  AppUserDto({this.name, this.phone, this.email, this.role, this.image});

  AppUserDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    role = json['role'];
    image = json['image'];
  }
AppUserEntity toEntity() {
  return AppUserEntity(
    name: name ?? '',
    phone: phone ?? '',
    email: email ?? '',
    role: role ?? '',
    image: image ?? '',
  );
}
  
}
