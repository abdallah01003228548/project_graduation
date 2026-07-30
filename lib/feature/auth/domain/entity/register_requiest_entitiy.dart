class RegisterRequestEntity {
  String name;
  String phone;
  String email;
  String password;
  String confirmPassword;

  RegisterRequestEntity({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
