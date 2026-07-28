import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/auth/domain/entity/register_requiest_entitiy.dart';

abstract interface class AuthDataSource {
  Future<ResultApi<String>> register(RegisterRequestEntity registerRequestEntity);
}