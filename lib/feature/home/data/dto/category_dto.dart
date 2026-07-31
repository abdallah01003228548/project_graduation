
import 'package:project_graduation/feature/home/domain/entities/category_entity.dart';

class CategoryDto {
  List<CategoryItemDto>? list;

  CategoryDto({this.list});

  CategoryDto.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <CategoryItemDto>[];
      json['list'].forEach((v) {
        list!.add(CategoryItemDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryItemDto {
  String? slug;
  String? name;
  String? url;
  String? image;

  CategoryItemDto({this.slug, this.name, this.url, this.image});

  CategoryItemDto.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    name = json['name'];
    url = json['url'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slug'] = slug;
    data['name'] = name;
    data['url'] = url;
    data['image'] = image;
    return data;
  }
  CategoryEntity toEntity() {
    return CategoryEntity(
      slug: slug ?? '',
      name: name ?? '',
      image: image ?? '',
    );
  }
}
