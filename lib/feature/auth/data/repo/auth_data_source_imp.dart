import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/api_constants.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/auth/data/model/login_response_dto.dart';
import 'package:project_graduation/feature/auth/data/model/register_request_dto.dart';
import 'package:project_graduation/feature/auth/domain/entity/login_response_entitiy.dart';
import 'package:project_graduation/feature/auth/domain/entity/register_requiest_entitiy.dart';
import 'package:project_graduation/feature/auth/domain/repo/auth_data_source.dart';

@Injectable(as: AuthDataSource)
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
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestDto.toJson()),
      );
      var responseBody = response.body;
      log("REGISTER STATUS: ${response.statusCode}");
      log("REGISTER BODY: $responseBody");
      dynamic json;
      try {
        json = jsonDecode(responseBody);
      } catch (_) {
        json = null;
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        log(responseBody);
        return Success(json != null && json['message'] != null ? json['message'].toString() : 'Success');
      } else {
        String errorMsg = json != null && json['message'] != null
            ? json['message'].toString()
            : responseBody;
        return Error(errorMsg);
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<LoginResponseEntity>> login({required String email, required String password}) async {
    try{

    var url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.login}');

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    var responseBody = response.body;
    var json = jsonDecode(responseBody);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var dto = LoginResponseDto.fromJson(json);
      return Success(dto.toEntity());
    } else {
      return Error(json['message']);
    }

    }catch(e){
      return Error(e.toString());
    }
  }
}
// انا واقف في الفيديو التاني عند الدقيقه 14:50 بكرا كملهم لحد الاخر 