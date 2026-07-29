import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/di/network_module.dart';
import 'package:project_graduation/core/network/api/api_constants.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/account/data/data_source/account_remote_data_source.dart';
import 'package:project_graduation/feature/account/data/model/account_dto.dart';

@Injectable(as: AccountRemoteDataSource)
class AccountRemoteDataSourceImp implements AccountRemoteDataSource {
  final NetworkModule networkModule;

  AccountRemoteDataSourceImp(this.networkModule);

  // ─── Get Profile ──────────────────────────────────────────────────────────

  @override
  Future<ResultApi<AccountDto>> getProfile() async {
    try {
      debugPrint('[getProfile] Request: GET ${ApiConstants.baseUrl}${ApiConstants.getProfile}');

      final response = await networkModule.get(ApiConstants.getProfile);

      debugPrint('[getProfile] Response status: ${response.statusCode}');
      debugPrint('[getProfile] Response body: ${response.data}');

      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      final accountDto = AccountDto.fromJson(responseData);

      debugPrint('[getProfile] Parsed DTO: name=${accountDto.name}, email=${accountDto.email}, image=${accountDto.profileImage}');

      return Success(accountDto);
    } on DioException catch (e) {
      debugPrint('[getProfile] DioException: ${e.response?.statusCode} — ${e.response?.data}');
      return Error(
        e.response?.data?['message']?.toString() ??
            e.message ??
            'Failed to get profile data',
      );
    } catch (e) {
      debugPrint('[getProfile] Exception: $e');
      return Error(e.toString());
    }
  }

  // ─── Update Profile ───────────────────────────────────────────────────────

  @override
  Future<ResultApi<AccountDto>> updateProfile({
    required String name,
    required String email,
    String? password,
    File? imageFile,
  }) async {
    try {
      final Map<String, dynamic> dataMap = {
        'name': name,
        'email': email,
      };

      if (password != null && password.isNotEmpty) {
        dataMap['password'] = password;
      }

      if (imageFile != null) {
        final String fileName = imageFile.path.split('/').last;
        dataMap['image'] = await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        );
      }

      final formData = FormData.fromMap(dataMap);

      debugPrint('[updateProfile] Request: POST ${ApiConstants.baseUrl}${ApiConstants.updateProfile}');
      debugPrint('[updateProfile] Fields: $dataMap');

      final response = await networkModule.post(
        ApiConstants.updateProfile,
        data: formData,
      );

      debugPrint('[updateProfile] Response status: ${response.statusCode}');
      debugPrint('[updateProfile] Response body: ${response.data}');

      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      final accountDto = AccountDto.fromJson(responseData);

      debugPrint('[updateProfile] Parsed DTO: name=${accountDto.name}, email=${accountDto.email}, image=${accountDto.profileImage}');

      return Success(accountDto);
    } on DioException catch (e) {
      debugPrint('[updateProfile] DioException: ${e.response?.statusCode} — ${e.response?.data}');
      return Error(
        e.response?.data?['message']?.toString() ??
            e.message ??
            'Failed to update profile data',
      );
    } catch (e) {
      debugPrint('[updateProfile] Exception: $e');
      return Error(e.toString());
    }
  }
}
