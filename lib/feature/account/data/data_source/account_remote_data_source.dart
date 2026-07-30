import 'dart:io';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/account/data/model/account_dto.dart';

abstract interface class AccountRemoteDataSource {
  Future<ResultApi<AccountDto>> getProfile();
  Future<ResultApi<void>> updateProfile({
    required String name,
    required String email,
    String? phone,
    String? address,
    String? password,
  });
  Future<ResultApi<void>> uploadImage(File imageFile);
}
