class ProductItemEntity {
  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final double? price;
  final String? brand;
  final String? thumbnail;
  final List<String>? images;


  const ProductItemEntity({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.brand,
    this.images,
    this.thumbnail,
  });
}