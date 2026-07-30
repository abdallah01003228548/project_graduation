import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/favourite/domain/use_case/add_favourite_use_case.dart';
import 'package:project_graduation/feature/favourite/domain/use_case/delete_favourite_use_case.dart';
import 'package:project_graduation/feature/favourite/domain/use_case/get_favourite_use_case.dart';
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';

part 'favourite_state.dart';

@injectable
class FavouriteCubit extends Cubit<FavouriteState> {
  final GetFavouriteUseCase _getFavouriteUseCase;
  final AddFavouriteUseCase _addFavouriteUseCase;
  final DeleteFavouriteUseCase _deleteFavouriteUseCase;

  FavouriteCubit(
      this._getFavouriteUseCase,
      this._addFavouriteUseCase,
      this._deleteFavouriteUseCase,
      ) : super(FavouriteInitial());

  final Set<String> favouriteIds = {};
  List<ProductItemEntity> _products = [];

  Future<void> getFavouriteProducts() async {
    emit(FavouriteLoading());

    final result = await _getFavouriteUseCase.invoke();

    if (result is Success<List<ProductItemEntity>>) {
      _products = result.data;

      favouriteIds
        ..clear()
        ..addAll(result.data.map((e) => e.id));

      emit(FavouriteSuccess(products: _products));
      return;
    }

    if (result is Error<List<ProductItemEntity>>) {
      emit(FavouriteError(result.messageError));
    }
  }

  Future<bool> toggleFavourite(ProductItemEntity product) async {
    final isFavourite = favouriteIds.contains(product.id);

    if (isFavourite) {
      final result =
      await _deleteFavouriteUseCase.invoke(int.parse(product.id));

      if (result is Success<String>) {
        favouriteIds.remove(product.id);
        _products.removeWhere((e) => e.id == product.id);

        emit(FavouriteSuccess(products: List.from(_products)));
        return true;
      }

      return false;
    }

    final result =
    await _addFavouriteUseCase.invoke(int.parse(product.id));

    if (result is Success<String>) {
      favouriteIds.add(product.id);

      if (!_products.any((e) => e.id == product.id)) {
        _products.add(product);
      }

      emit(FavouriteSuccess(products: List.from(_products)));
      return true;
    }

    return false;
  }
}