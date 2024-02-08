part of 'add_category_cubit.dart';

@immutable
abstract class AddCategoryState {}

class AddCategoryInitial extends AddCategoryState {}

class GetCategoryImage extends AddCategoryState {}

class AddCategorySuccessfully extends AddCategoryState {}

class AddCategoryLoading extends AddCategoryState {}

class GetAllCategoriesLoading extends AddCategoryState {}

class GetAllCategoriesSuccessfully extends AddCategoryState {}

class ChangeDropDownMenuItemValue extends AddCategoryState {}
