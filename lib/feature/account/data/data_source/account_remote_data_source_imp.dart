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

  @override
  Future<ResultApi<AccountDto>> getProfile() async {
    try {
      final response = await networkModule.get(ApiConstants.getProfile);
      final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
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

  @override
  Future<ResultApi<void>> updateProfile({
    required String name,
    required String email,
    String? phone,
    String? address,
    String? password,
  }) async {
    try {
      final Map<String, dynamic> dataMap = {
        'name': name,
        'email': email,
      };

      if (phone != null && phone.isNotEmpty) {
        dataMap['phone'] = phone;
      }
      if (address != null && address.isNotEmpty) {
        dataMap['address'] = address;
      }
      if (password != null && password.isNotEmpty) {
        dataMap['password'] = password;
      }

      final formData = FormData.fromMap(dataMap);

      await networkModule.post(
        ApiConstants.updateProfile,
        data: formData,
      );

      return const Success(null);
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

  @override
  Future<ResultApi<void>> uploadImage(File imageFile) async {
    try {
      final String fileName = imageFile.path.split('/').last;
      
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      await networkModule.post(
        ApiConstants.addImage,
        data: formData,
      );

      return const Success(null);
    } on DioException catch (e) {
      return Error(
        e.response?.data?['message']?.toString() ??
            e.message ??
            'Failed to upload image',
      );
    } catch (e) {
      return Error(e.toString());
    }
  }
}
