part of 'pharmacy_categories_cubit.dart';

@immutable
abstract class PharmacyCategoriesState {}

class PharmacyCategoriesInitial extends PharmacyCategoriesState {}

class FilterAllProductsToCategoryItesOnlyLoading extends PharmacyCategoriesState {}

class FilterAllOffersToCategoryItesOnlyLoading extends PharmacyCategoriesState {}

class FilterAllOffersToCategoryItesOnlySuccessfully extends PharmacyCategoriesState {}

class FilterAllProductsToCategoryItesOnlySuccessfully extends PharmacyCategoriesState {}

class IsSearchingInMedicineInCategory extends PharmacyCategoriesState {}

class IsNotSearchingInMedicineInCategory extends PharmacyCategoriesState {}
