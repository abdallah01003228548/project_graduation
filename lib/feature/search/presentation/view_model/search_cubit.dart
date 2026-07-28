import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/search/domain/use_case/search_products_use_case.dart';

import 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final SearchProductsUseCase searchProductsUseCase;

  Timer? _debounce;

  SearchCubit(this.searchProductsUseCase) : super(SearchInitial());

  void search(String query) {
    _debounce?.cancel();

    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      emit(SearchInitial());
      return;
    }

    _debounce = Timer(
      const Duration(milliseconds: 500),
      () {
        _searchProducts(trimmedQuery);
      },
    );
  }

  Future<void> _searchProducts(String query) async {
    emit(SearchLoading());

    try {
      final result = await searchProductsUseCase.invoke(query);

      switch (result) {
        case Success():
          final products = result.data;

          if (products.isEmpty) {
            emit(SearchEmpty());
          } else {
            emit(SearchSuccess(products));
          }

        case Error():
          emit(SearchError(result.messageError));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}