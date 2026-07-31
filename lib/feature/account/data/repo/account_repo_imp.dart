import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/account/data/data_source/account_remote_data_source.dart';
import 'package:project_graduation/feature/account/data/model/account_dto.dart';
import 'package:project_graduation/feature/account/domain/entities/account_entity.dart';
import 'package:project_graduation/feature/account/domain/repo/account_repo_interface.dart';

@Injectable(as: AccountRepoInterface)
class AccountRepoImp implements AccountRepoInterface {
  final AccountRemoteDataSource _remoteDataSource;

  AccountRepoImp(this._remoteDataSource);

  @override
  Future<ResultApi<AccountEntity>> getProfile() async {
    final result = await _remoteDataSource.getProfile();

    if (result is Success<AccountDto>) {
      return Success(result.data.toEntity());
    }

    if (result is Error<AccountDto>) {
      return Error(result.messageError);
    }

    return Error('Unexpected error');
  }

  @override
  Future<ResultApi<void>> updateProfile({
    required String name,
    required String email,
    String? phone,
    String? address,
    String? password,
    File? imageFile,
  }) async {
    final result = await _remoteDataSource.updateProfile(
      name: name,
      email: email,
      phone: phone,
      address: address,
      password: password,
      imageFile: imageFile,
    );

    if (result is Success<void>) {
      return  Success(null);
    }

    if (result is Error<void>) {
      return Error(result.messageError);
    }

    return Error('Unexpected error');
  }

  @override
  Future<ResultApi<void>> uploadImage(File imageFile) async {
    final result = await _remoteDataSource.uploadImage(imageFile);

    if (result is Success<void>) {
      return  Success(null);
    }

    if (result is Error<void>) {
      return Error(result.messageError);
    }

    return Error('Unexpected error');
  }
}
