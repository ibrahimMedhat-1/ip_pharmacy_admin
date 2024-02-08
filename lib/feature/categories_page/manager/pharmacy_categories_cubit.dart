import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/product_model.dart';
import '../../../models/offers_model.dart';

part 'pharmacy_categories_state.dart';

class PharmacyCategoriesCubit extends Cubit<PharmacyCategoriesState> {
  PharmacyCategoriesCubit() : super(PharmacyCategoriesInitial());

  static PharmacyCategoriesCubit get(context) => BlocProvider.of(context);
  List<ProductsModel> categoryProducts = [];
  List<OffersModel> offers = [];
  List<ProductsModel> searchCategoryProducts = [];
  TextEditingController searchController = TextEditingController();

  void filterProducts(List<ProductsModel> products, String category) {
    emit(FilterAllProductsToCategoryItesOnlyLoading());
    for (ProductsModel product in products) {
      if (product.category == category) {
        categoryProducts.add(product);
      }
    }
    emit(FilterAllProductsToCategoryItesOnlySuccessfully());
  }

  void filterOffers(List<OffersModel> offers, String category) {
    emit(FilterAllOffersToCategoryItesOnlyLoading());
    for (OffersModel offer in offers) {
      if (offer.category == category) {
        this.offers.add(offer);
      }
    }
    emit(FilterAllOffersToCategoryItesOnlySuccessfully());
  }

  void searchMedicineInCategory(String value) {
    for (ProductsModel product in categoryProducts) {
      if (product.name!.toLowerCase().contains(value.toLowerCase())) {
        searchCategoryProducts.add(product);
      }
    }
    emit(IsSearchingInMedicineInCategory());
  }

  void isSearching(bool isSearching) {
    if (isSearching) {
      emit(IsSearchingInMedicineInCategory());
    } else {
      searchCategoryProducts = [];
      emit(IsNotSearchingInMedicineInCategory());
    }
  }
}
