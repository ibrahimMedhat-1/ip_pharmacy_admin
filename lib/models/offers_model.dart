class OffersModel {
  String? id;
  String? pharmacyId;
  String? category;
  String? image;

  OffersModel({
    required this.id,
    required this.pharmacyId,
    required this.category,
    required this.image,
  });
  Map<String, dynamic> toMap() => {
        'id': id,
        'pharmacyId': pharmacyId,
        'category': category,
        'image': image,
      };
  OffersModel.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    pharmacyId = json['pharmacyId'];
    category = json['category'];
    image = json['image'];
  }
}
