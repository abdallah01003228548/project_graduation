import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/constants/app_keys.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/core/storage_helper/secure_storage_helper.dart';
import 'package:project_graduation/feature/auth/domain/entity/login_response_entitiy.dart';
import 'package:project_graduation/feature/auth/domain/entity/register_request_entitiy.dart';
import 'package:project_graduation/feature/auth/domain/repo/auth_data_source.dart';
import 'package:project_graduation/feature/auth/domain/repo/auth_repo_interface.dart';

@Injectable(as: AuthRepoInterface)
class AuthRepoImp implements AuthRepoInterface {
  AuthRepoImp(this._dataSource);
  final AuthDataSource _dataSource;
  
  @override
  Future<ResultApi<RegisterRequestEntity>> register(RegisterRequestEntity request) async =>
      await _dataSource.register(request);
       
       @override
       Future<ResultApi<LoginResponseEntity>> login({required String email,
        required String password})
         async {
          final result= await _dataSource.login(email: email, password: password);
           
           switch( result ){

case Success<LoginResponseEntity> ():
var  entity = result.data;
   await  SecureStorageHelper .instance.saveSecure(key: AppKeys.token, value: entity.token);
   return Success(entity);
   
case Error<LoginResponseEntity> ():
  return Error(result.messageError);


           }
         }
}
  
