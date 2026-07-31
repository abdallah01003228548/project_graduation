class RegisterRequestDto {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? confirmPassword;

  RegisterRequestDto({this.name, this.phone, this.email, this.password, this.confirmPassword});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    return data;
  }
}
