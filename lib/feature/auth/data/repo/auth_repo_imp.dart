import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/auth/domain/entity/register_requiest_entitiy.dart';
import 'package:project_graduation/feature/auth/domain/repo/auth_data_source.dart';
import 'package:project_graduation/feature/auth/domain/repo/auth_repo_interface.dart';

@Injectable(as: AuthRepoInterface)
class AuthRepoImp implements AuthRepoInterface {
  AuthRepoImp(this._dataSource);
  final AuthDataSource _dataSource;
  
  @override
  Future<ResultApi<String>> register(RegisterRequestEntity request) async =>
      await _dataSource.register(request);
}
