import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';

class CartItemEntity {
  final ProductItemEntity product;
  final int quantity;

  const CartItemEntity({
    required this.product,
    this.quantity = 1,
  });

  String get productId => product.id;

  double get unitPrice => product.price;

  double get totalPrice => product.price * quantity;

  CartItemEntity copyWith({
    ProductItemEntity? product,
    int? quantity,
  }) {
    return CartItemEntity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}