
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['url'] = this.url;
    data['image'] = this.image;
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
