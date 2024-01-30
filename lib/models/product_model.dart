class ProductsModel {
  String? tag;
  String? image;
  String? name;
  String? price;
  String? description;
  String? category;
  String? effectiveMaterial;
  String? pharmacyId;

  ProductsModel(
    this.tag,
    this.image,
    this.name,
    this.price,
    this.description,
  );

  ProductsModel.fromJson(Map<String, dynamic>? json) {
    tag = json!['id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    effectiveMaterial = json['effectiveMaterial'];
    pharmacyId = json['pharmacyId'];
  }

  Map<String, dynamic> toMap() => {
        'id': tag,
        'image': image,
        'price': price,
        'description': description,
        'category': category,
        'effectiveMaterial': effectiveMaterial,
        'pharmacyId': pharmacyId,
      };
}
