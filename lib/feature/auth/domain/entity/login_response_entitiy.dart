class LoginResponseEntity {
  String message;
  String token;
  AppUserEntity user;

  LoginResponseEntity({this.message = '', this.token = '',  this.user =  const AppUserEntity()});

  

  
}

class AppUserEntity {
final  String name;
final  String phone;
final  String email;
final  String role;
final  String image;

 const AppUserEntity({this.name = '', this.phone = '', this.email = '', this.role = '', this.image = ''});

  
}
