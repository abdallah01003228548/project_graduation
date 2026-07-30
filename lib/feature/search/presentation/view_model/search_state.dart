import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';

sealed class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<ProductItemEntity> products;

  SearchSuccess(this.products);
}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {
  final String messageError;

  SearchError(this.messageError);
}