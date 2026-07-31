import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/auth/domain/entity/register_request_entitiy.dart';
import 'package:project_graduation/feature/auth/domain/repo/auth_repo_interface.dart';

@injectable
class RegisterUseCase {
  final AuthRepoInterface _repo;

  RegisterUseCase(this._repo);

  Future<ResultApi<RegisterRequestEntity>> invoke(RegisterRequestEntity request) async =>
      await _repo.register(request);
}
