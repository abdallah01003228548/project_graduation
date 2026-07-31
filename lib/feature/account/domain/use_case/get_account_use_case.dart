import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/account/domain/entities/account_entity.dart';
import 'package:project_graduation/feature/account/domain/repo/account_repo_interface.dart';

@injectable
class GetAccountUseCase {
  final AccountRepoInterface _accountRepo;

  GetAccountUseCase(this._accountRepo);

  Future<ResultApi<AccountEntity>> invoke() {
    return _accountRepo.getProfile();
  }
}
