import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/di/network_module.dart';
import 'package:project_graduation/core/network/api/api_constants.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/account/data/data_source/account_remote_data_source.dart';
import 'package:project_graduation/feature/account/data/model/account_dto.dart';

@Injectable(as: AccountRemoteDataSource)
class AccountRemoteDataSourceImp implements AccountRemoteDataSource {
  final NetworkModule _networkModule;

  AccountRemoteDataSourceImp(this._networkModule);

  @override
  Future<ResultApi<AccountDto>> getProfile() async {
    try {
      final response = await _networkModule.get(
        ApiConstants.getProfile,
        
      );
      final data = response.data;
      

      if (data is! Map<String, dynamic>) {
        return Error('Invalid profile response');
      }

      final accountDto = AccountDto.fromJson(data);

      return Success(accountDto);
    } on DioException catch (e) {
      return Error(
        _extractDioError(
          e,
          fallback: 'Failed to get profile data',
          
        ),
      );
    } catch (e) {
      return Error(e.toString());
    }
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
    try {
      final data = <String, dynamic>{
        'name': name.trim(),
        'email': email.trim(),
      };

      final trimmedPhone = phone?.trim();
      final trimmedAddress = address?.trim();
      final trimmedPassword = password?.trim();

      if (trimmedPhone != null && trimmedPhone.isNotEmpty) {
        data['phone'] = trimmedPhone;
      }

      if (trimmedAddress != null && trimmedAddress.isNotEmpty) {
        data['address'] = trimmedAddress;
      }

      if (trimmedPassword != null && trimmedPassword.isNotEmpty) {
        data['password'] = trimmedPassword;
      }

      await _networkModule.post(
        ApiConstants.updateProfile,
        data: data,
      );

      if (imageFile != null) {
        final imageResult = await addImage(imageFile);

        if (imageResult is Error<void>) {
          return Error(imageResult.messageError);
        }
      }

      return Success(null);
    } on DioException catch (e) {
      return Error(
        _extractDioError(
          e,
          fallback: 'Failed to update profile data',
        ),
      );
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<void>> addImage(File imageFile) async {
    try {
      final fileName =
          imageFile.path.split(Platform.pathSeparator).last;

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      await _networkModule.post(
        ApiConstants.addImage,
        data: formData,
      );

      return Success(null);
    } on DioException catch (e) {
      return Error(
        _extractDioError(
          e,
          fallback: 'Failed to upload image',
        ),
      );
    } catch (e) {
      return Error(e.toString());
    }
  }

  String _extractDioError(
    DioException exception, {
    required String fallback,
  }) {
    final responseData = exception.response?.data;

    if (responseData is Map) {
      final message = responseData['message'];

      if (message != null && message.toString().isNotEmpty) {
        return message.toString();
      }

      final error = responseData['error'];

      if (error != null && error.toString().isNotEmpty) {
        return error.toString();
      }
    }

    if (responseData is String && responseData.isNotEmpty) {
      return responseData;
    }

    final exceptionMessage = exception.message;

    if (exceptionMessage != null && exceptionMessage.isNotEmpty) {
      return exceptionMessage;
    }

    return fallback;
  }
}