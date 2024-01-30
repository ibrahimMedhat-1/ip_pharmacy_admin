import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/product_model.dart';
import '../../../models/offers_model.dart';
import '../../../shared/toast.dart';

part 'medicine_state.dart';

class MedicineCubit extends Cubit<MedicineState> {
  MedicineCubit() : super(MedicineInitial());

  static MedicineCubit get(context) => BlocProvider.of(context);
  TextEditingController searchController = TextEditingController();
  List<ProductsModel> products = [];
  List<OffersModel> offers = [];
  List<ProductsModel> searchMedicineProducts = [];
  List<ProductsModel> similarProducts = [];
  String dropDownMenuItemValue = 'Medicine';

  void getAllProducts() {
    emit(GetAllMedicineProductsLoading());
    FirebaseFirestore.instance.collection('allProducts').get().then((value) async {
      for (var element in value.docs) {
        var product = await element.data()['reference'].get();
        products.add(ProductsModel.fromJson(product.data()));
      }
      emit(GetAllMedicineProductsSuccessfully());
    }).catchError((onError) {
      emit(GetAllMedicineProductsError());
      showToast(onError.message);
    });
  }

  void getAllOffers() {
    emit(GetAllOffersLoading());
    FirebaseFirestore.instance.collection('allOffers').get().then((value) async {
      for (var element in value.docs) {
        var offer = await element.data()['reference'].get();
        offers.add(OffersModel.fromJson(offer.data()));
      }
      emit(GetAllOffersSuccessfully());
    }).catchError((onError) {
      emit(GetAllOffersError());
      showToast(onError.message);
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
