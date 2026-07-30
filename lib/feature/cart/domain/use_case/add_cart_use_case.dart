import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/cart/domain/repo/cart_repo_interface.dart';
@injectable
class AddCartUseCase {
  final CartRepoInterface cartRepoInterface;

  AddCartUseCase({required this.cartRepoInterface});

  Future<ResultApi<void>> call(String productId, int quantity) async {
    return await cartRepoInterface.addToCart(productId, quantity);
  }
}