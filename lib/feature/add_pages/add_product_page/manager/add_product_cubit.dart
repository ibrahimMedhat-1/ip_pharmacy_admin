import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ip_pharmacy_admin/models/product_model.dart';

import '../../../../models/category_model.dart';
import '../../../../shared/utils/constants.dart';
import '../../../../shared/utils/image_helper/image_helper.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());
  static AddProductCubit get(context) => BlocProvider.of(context);
  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController effectiveMaterialController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  File? categoryImage;
  String? dropDownMenuItemValue;
  List<CategoryModel> categories = [];

  void changeDropDownItem({
    required category,
  }) {
    dropDownMenuItemValue = category;
    emit(ChangeDropDownMenuItemValue());
  }

  void getAllCategories() {
    emit(GetAllCategoriesLoading());
    FirebaseFirestore.instance
        .collection('pharmacies')
        .doc(Constants.pharmacyModel!.id)
        .snapshots()
        .listen((value) async {
      categories.clear();
      for (var category in value.data()!['categories']) {
        categories.add(CategoryModel.fromJson(category));
      }
      emit(GetAllCategoriesSuccessfully());
    });
  }

  void getProductImage() async {
    List<XFile?>? images;
    images = await ImageHelper().pickImage();
    categoryImage = File(images.first!.path);
    CroppedFile? croppedImage;
    croppedImage = await ImageHelper().crop(file: images.first!, cropStyle: CropStyle.circle);
    if (croppedImage != null) {
      categoryImage = File(croppedImage.path);
    }
    emit(GetProductImage());
  }

  Future<void> addProduct() async {
    emit(AddProductLoading());
    String imageLink = '';
    if (categoryImage != null) {
      await FirebaseStorage.instance
          .ref()
          .child('pharmacies/${Constants.pharmacyModel!.id}/products/$dropDownMenuItemValue')
          .putFile(categoryImage!)
          .then((p0) async {
        await p0.ref.getDownloadURL().then((value) {
          imageLink = value;
        });
      });
    }
    var offerDoc = FirebaseFirestore.instance
        .collection('pharmacies')
        .doc(Constants.pharmacyModel!.id)
        .collection('products')
        .doc();

    await offerDoc.set(ProductsModel(
      tag: offerDoc.id,
      category: dropDownMenuItemValue,
      image: imageLink,
      pharmacyId: Constants.pharmacyModel!.id,
      description: descriptionController.text,
      effectiveMaterial: effectiveMaterialController.text,
      name: productNameController.text,
      price: priceController.text,
    ).toMap());

    FirebaseFirestore.instance.collection('allProducts').add({
      'reference': FirebaseFirestore.instance
          .collection('pharmacies')
          .doc(Constants.pharmacyModel!.id)
          .collection('products')
          .doc(offerDoc.id),
    });
    emit(AddProductSuccessfully());
  }
}
