import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/auth/domain/entity/login_response_entitiy.dart';
import 'package:project_graduation/feature/auth/domain/repo/auth_repo_interface.dart';
@injectable
class LoginUseCase {
  final AuthRepoInterface _repo;

  LoginUseCase(this._repo);

  Future<ResultApi<LoginResponseEntity>> invoke({required String email, required String password}) async =>
      await _repo.login(email: email, password: password);
}