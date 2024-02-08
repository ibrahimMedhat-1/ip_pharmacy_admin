part of 'add_product_cubit.dart';

@immutable
abstract class AddProductState {}

class AddProductInitial extends AddProductState {}

class GetProductImage extends AddProductState {}

class AddProductLoading extends AddProductState {}

class AddProductSuccessfully extends AddProductState {}

class ChangeDropDownMenuItemValue extends AddProductState {}

class GetAllCategoriesLoading extends AddProductState {}

class GetAllCategoriesSuccessfully extends AddProductState {}
