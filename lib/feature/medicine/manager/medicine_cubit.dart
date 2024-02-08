import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_pharmacy_admin/models/category_model.dart';

import '../../../../models/product_model.dart';
import '../../../models/offers_model.dart';

part 'medicine_state.dart';

class MedicineCubit extends Cubit<MedicineState> {
  MedicineCubit() : super(MedicineInitial());

  static MedicineCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();
  List<CategoryModel> categories = [];
  List<ProductsModel> products = [];
  List<OffersModel> offers = [];
  List<ProductsModel> searchMedicineProducts = [];
  List<ProductsModel> similarProducts = [];
  String dropDownMenuItemValue = 'Medicine';

  void getAllCategories() {
    emit(GetAllCategoriesLoading());
    FirebaseFirestore.instance
        .collection('pharmacies')
        .doc('2Cy9k9b8noU4Abj5Lgip')
        .snapshots()
        .listen((value) async {
      categories.clear();
      for (var category in value.data()!['categories']) {
        categories.add(CategoryModel.fromJson(category));
      }
      emit(GetAllCategoriesSuccessfully());
    });
  }

  void getAllProducts() {
    emit(GetAllMedicineProductsLoading());
    FirebaseFirestore.instance
        .collection('pharmacies')
        .doc('2Cy9k9b8noU4Abj5Lgip')
        .collection('products')
        .snapshots()
        .listen((value) async {
      products.clear();
      for (var element in value.docs) {
        var product = element.data();
        products.add(ProductsModel.fromJson(product));
      }
      emit(GetAllMedicineProductsSuccessfully());
    });
  }

  void getAllOffers() async {
    emit(GetAllOffersLoading());
    await FirebaseFirestore.instance
        .collection('pharmacies')
        .doc('2Cy9k9b8noU4Abj5Lgip')
        .collection('offers')
        .snapshots()
        .listen((value) async {
      offers.clear();
      for (var element in value.docs) {
        var offer = element.data();
        offers.add(OffersModel.fromJson(offer));
      }
      emit(GetAllOffersSuccessfully());
    });
  }

  void searchMedicine(String value) {
    for (ProductsModel product in products) {
      if (product.name!.toLowerCase().contains(value.toLowerCase())) {
        searchMedicineProducts.add(product);
      }
    }
    emit(IsSearchingInMedicineInCategory());
  }

  void isSearching(bool isSearching) {
    if (isSearching) {
      emit(IsSearchingInMedicineInCategory());
    } else {
      searchMedicineProducts = [];
      emit(IsNotSearchingInMedicineInCategory());
    }
  }

  void changeDropDownItem(value) {
    dropDownMenuItemValue = value;
    emit(ChangeDropDownMenuItemValue());
  }
}
