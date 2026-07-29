import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/cart/domain/repo/cart_repo_interface.dart';

@injectable
class DeleteCartUseCase {
  final CartRepoInterface cartRepoInterface;

  DeleteCartUseCase(this.cartRepoInterface);

  Future<ResultApi<void>> call(int productId) {
    return cartRepoInterface.deleteFromCart(productId.toString());
  }
}