class AccountEntity {
  final String name;
  final String email;
  final String? profileImage;
  final String? password;

  const AccountEntity({
    required this.name,
    required this.email,
    this.profileImage,
    this.password,
  });
}
