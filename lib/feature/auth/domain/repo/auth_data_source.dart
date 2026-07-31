import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/auth/domain/entity/login_response_entitiy.dart';
import 'package:project_graduation/feature/auth/domain/entity/register_request_entitiy.dart';

abstract interface class AuthDataSource {
  Future<ResultApi<RegisterRequestEntity>> register(RegisterRequestEntity registerRequestEntity);
  Future<ResultApi<LoginResponseEntity>> login({required String email, required String password});
}
