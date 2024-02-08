class ProductsModel {
  String? tag;
  String? image;
  String? name;
  String? price;
  String? description;
  String? category;
  String? effectiveMaterial;
  String? pharmacyId;

  ProductsModel({
    required this.tag,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.effectiveMaterial,
    required this.pharmacyId,
  });

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
        'name': name,
        'price': price,
        'description': description,
        'category': category,
        'effectiveMaterial': effectiveMaterial,
        'pharmacyId': pharmacyId,
      };
}
