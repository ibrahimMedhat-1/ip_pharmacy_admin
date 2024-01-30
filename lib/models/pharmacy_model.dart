import 'package:ip_pharmacy_admin/models/product_model.dart';

import 'category_model.dart';
import 'offers_model.dart';

class PharmacyModel {
  String? name;
  String? image;
  String? id;
  String? phoneNo;
  String? address;
  List<CategoryModel>? categories;
  List<ProductsModel>? products;
  List<OffersModel>? offers;

  PharmacyModel(
      this.name, this.image, this.id, this.phoneNo, this.address, this.categories, this.products, this.offers);

  PharmacyModel.fromJson({
    Map<String, dynamic>? json,
    this.products,
    this.categories,
    this.offers,
  }) {
    name = json!['name'];
    phoneNo = json['phoneNo'];
    address = json['address'];
    image = json['image'];
    id = json['id'];
  }
}
