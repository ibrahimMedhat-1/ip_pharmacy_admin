class OffersModel {
  String? id;
  String? pharmacyId;
  String? category;
  String? image;

  OffersModel.fromJson(Map<String, dynamic>? json) {
    id = json!['id'];
    pharmacyId = json['pharmacyId'];
    category = json['category'];
    image = json['image'];
  }
}
