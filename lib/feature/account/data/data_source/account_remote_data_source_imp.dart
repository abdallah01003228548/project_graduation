import 'dart:convert';
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
  final NetworkModule networkModule;

  AccountRemoteDataSourceImp(this.networkModule);

  // ─── Get Profile ──────────────────────────────────────────────────────────

  @override
  Future<ResultApi<AccountDto>> getProfile() async {
    try {
      final response = await networkModule.get(ApiConstants.getProfile);

      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      final accountDto = AccountDto.fromJson(responseData);

      return Success(accountDto);
    } on DioException catch (e) {
      return Error(
        e.response?.data?['message']?.toString() ??
            e.message ??
            'Failed to get profile data',
      );
    } catch (e) {
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
      // ── بناء الـ JSON body ──────────────────────────────────────────────
      final Map<String, dynamic> jsonBody = {
        'name': name,
        'email': email,
      };

      if (password != null && password.isNotEmpty) {
        jsonBody['password'] = password;
      }

      // ── تحويل الصورة لـ Base64 وإضافتها للـ JSON ───────────────────────
      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();
        final base64Image = base64Encode(bytes);

        final extension = imageFile.path.split('.').last.toLowerCase();
        final mimeType = _getMimeType(extension);

        jsonBody['image'] = 'data:$mimeType;base64,$base64Image';
      }

      final response = await networkModule.post(
        ApiConstants.updateProfile,
        data: jsonBody,
      );

      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      final accountDto = AccountDto.fromJson(responseData);

      return Success(accountDto);
    } on DioException catch (e) {
      return Error(
        e.response?.data?['message']?.toString() ??
            e.message ??
            'Failed to update profile data',
      );
    } catch (e) {
      return Error(e.toString());
    }
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  /// إرجاع الـ MIME type بناءً على امتداد الملف
  String _getMimeType(String extension) {
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      default:
        return 'image/jpeg';
    }
  }
}
