import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/auth/domain/entity/login_response_entitiy.dart';
import 'package:project_graduation/feature/auth/domain/entity/register_requiest_entitiy.dart';

abstract interface class AuthRepoInterface {
  Future<ResultApi<String>> register(RegisterRequestEntity registerRequestEntity);
  Future<ResultApi<LoginResponseEntity>> login({required String email, required String password});

}