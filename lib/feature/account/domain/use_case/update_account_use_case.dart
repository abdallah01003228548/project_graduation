import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/account/domain/entities/account_entity.dart';
import 'package:project_graduation/feature/account/domain/repo/account_repo_interface.dart';

@injectable
class UpdateAccountUseCase {
  final AccountRepoInterface _accountRepo;

  UpdateAccountUseCase(this._accountRepo);

  Future<ResultApi<void>> invoke({
    required String name,
    required String email,
    String? phone,
    String? address,
    String? password,
  }) {
    return _accountRepo.updateProfile(
      name: name,
      email: email,
      phone: phone,
      address: address,
      password: password,
    );
  }

  Future<ResultApi<void>> uploadImage(File imageFile) {
    return _accountRepo.uploadImage(imageFile);
  }
}
