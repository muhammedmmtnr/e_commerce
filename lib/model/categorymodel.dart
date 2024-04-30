class CategoryModel {
  int? id;

  String? category;

  CategoryModel({
    this.id,
    this.category,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        category: json["category"],
      );
}
