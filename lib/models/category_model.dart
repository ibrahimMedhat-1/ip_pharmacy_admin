class CategoryModel {
  String? title;
  String? picture;

  CategoryModel.fromJson(Map<String, dynamic>? json) {
    title = json!['title'];
    picture = json['picture'];
  }
}
