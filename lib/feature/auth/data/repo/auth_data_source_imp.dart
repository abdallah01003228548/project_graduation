import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:project_graduation/core/network/api/api_constants.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/auth/data/model/register_request_dto.dart';
import 'package:project_graduation/feature/auth/domain/entity/register_requiest_entitiy.dart';
import 'package:project_graduation/feature/auth/domain/repo/auth_data_source.dart';

class AuthDataSourceImp implements AuthDataSource {
  @override
  Future<ResultApi<String>> register(RegisterRequestEntity request) async {
    var requestDto = RegisterRequestDto(
      name: request.name,
      phone: request.phone,
      email: request.email,
      password: request.password,
      confirmPassword: request.confirmPassword,
    );
    try {
      Uri url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.register}');
      var response = await http.post(url, body: requestDto.toJson());
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        log(json.toString());
        return Success(json['message']);
      } else {
        return Error(json['message']);
      }
    } catch (e) {
      return Error(e.toString());
    }
  }
}
// انا واقف في الفيديو التاني عند الدقيقه 14:50 بكرا كمليهم لحد الاخر 