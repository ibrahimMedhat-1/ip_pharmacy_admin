part of 'medicine_cubit.dart';

@immutable
abstract class MedicineState {}

class MedicineInitial extends MedicineState {}

class ChangeDropDownMenuItemValue extends MedicineState {}

class GetAllMedicineProductsLoading extends MedicineState {}

class GetAllMedicineProductsSuccessfully extends MedicineState {}

class GetAllMedicineProductsError extends MedicineState {}

class IsSearchingInMedicineInCategory extends MedicineState {}

class IsNotSearchingInMedicineInCategory extends MedicineState {}

class GetAllOffersLoading extends MedicineState {}

class GetAllOffersSuccessfully extends MedicineState {}

class GetAllOffersError extends MedicineState {}
