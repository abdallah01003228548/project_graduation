import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/favourite/domain/entities/favourite_entity.dart';
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

  List<ProductItemEntity> _products = [];

  Set<String> get favouriteIds => _products.map((p) => p.id).toSet();

  bool isFavourite(String productId) {
    return _products.any((p) => p.id == productId);
  }

  Future<void> getFavouriteProducts() async {
    emit(FavouriteLoading());

    final result = await _getFavouriteUseCase.invoke();

    if (result is Success<FavouriteEntity>) {
      _products = List.from(result.data.products);
      emit(FavouriteSuccess(
        favourite: FavouriteEntity(products: List.from(_products)),
      ));
      return;
    }

    if (result is Error<FavouriteEntity>) {
      emit(FavouriteError(result.messageError));
    }
  }

  Future<bool?> toggleFavourite(ProductItemEntity product) async {
    if (isFavourite(product.id)) {
      final success = await removeFavourite(product);
      return success ? false : null;
    } else {
      final success = await addFavourite(product);
      return success ? true : null;
    }
  }

  Future<bool> addFavourite(ProductItemEntity product) async {
    final result = await _addFavouriteUseCase.invoke(int.parse(product.id));

    if (result is Success<String>) {
      if (!isFavourite(product.id)) {
        _products = [..._products, product];
      }
      emit(FavouriteSuccess(
        favourite: FavouriteEntity(products: List.from(_products)),
      ));
      return true;
    }

    if (result is Error<String>) {
      emit(FavouriteError(result.messageError));
    }
    return false;
  }

  Future<bool> removeFavourite(ProductItemEntity product) async {
    final result = await _deleteFavouriteUseCase.invoke(int.parse(product.id));

    if (result is Success<String>) {
      _products = _products.where((p) => p.id != product.id).toList();
      emit(FavouriteSuccess(
        favourite: FavouriteEntity(products: List.from(_products)),
      ));
      return true;
    }

    if (result is Error<String>) {
      emit(FavouriteError(result.messageError));
    }
    return false;
  }
}