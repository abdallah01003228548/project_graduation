class AccountEntity {
  final String name;
  final String email;
  final String? phone;
  final String? role;
  final String? profileImage;
  final String? password;

  const AccountEntity({
    required this.name,
    required this.email,
    this.phone,
    this.role,
    this.profileImage,
    this.password,
  });
}
