import 'dart:io';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/account/domain/entities/account_entity.dart';

abstract interface class AccountRepoInterface {
  Future<ResultApi<AccountEntity>> getProfile();
  Future<ResultApi<void>> updateProfile({
    required String name,
    required String email,
    String? phone,
    String? address,
    String? password,
    File? imageFile,
  });
  Future<ResultApi<void>> addImage(File imageFile);
}
