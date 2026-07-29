import 'dart:io';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/account/domain/entities/account_entity.dart';

abstract interface class AccountRepoInterface {
  Future<ResultApi<AccountEntity>> getProfile();
  Future<ResultApi<AccountEntity>> updateProfile({
    required String name,
    required String email,
    String? password,
    File? imageFile,
  });
}
