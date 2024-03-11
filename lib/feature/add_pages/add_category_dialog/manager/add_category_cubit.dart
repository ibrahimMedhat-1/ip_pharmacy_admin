import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../models/category_model.dart';
import '../../../../shared/utils/constants.dart';
import '../../../../shared/utils/image_helper/image_helper.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit() : super(AddCategoryInitial());

  static AddCategoryCubit get(context) => BlocProvider.of(context);
  File? categoryImage;
  String dropDownMenuItemValue = 'Medicine';
  TextEditingController categoryController = TextEditingController();
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

  void getCategoryImage() async {
    List<XFile?>? images;
    images = await ImageHelper().pickImage();
    categoryImage = File(images.first!.path);
    CroppedFile? croppedImage;
    croppedImage = await ImageHelper().crop(file: images.first!, cropStyle: CropStyle.circle);
    if (croppedImage != null) {
      categoryImage = File(croppedImage.path);
    }
    emit(GetCategoryImage());
  }

  Future<void> adCategory() async {
    emit(AddCategoryLoading());
    String imageLink = '';
    List<Map<String, dynamic>> categories = [];
    if (categoryImage != null) {
      await FirebaseStorage.instance
          .ref()
          .child('pharmacies/${Constants.pharmacyModel!.id}/categories/$dropDownMenuItemValue')
          .putFile(categoryImage!)
          .then((p0) async {
        await p0.ref.getDownloadURL().then((value) {
          imageLink = value;
        });
      });
    }

    DocumentReference<Map<String, dynamic>> pharmacy =
        FirebaseFirestore.instance.collection('pharmacies').doc(Constants.pharmacyModel!.id);

    await pharmacy.get().then((value) async {
      for (var category in await value.data()!['categories']) {
        categories.add(category);
      }
    });
    categories.add({
      'picture': imageLink,
      'title': categoryController.text,
    });
    await pharmacy.update({'categories': categories});
    emit(AddCategorySuccessfully());
  }
}
