import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../models/category_model.dart';
import '../../../models/offers_model.dart';
import '../../../models/pharmacy_model.dart';
import '../../../models/product_model.dart';
import '../../../shared/toast.dart';
import '../../../shared/utils/constants.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController emailAddressSignUpController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordSignUpController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool checkBoxValue = false;
  bool obscure = true;
  bool obscureSignUp = true;
  IconData suffixIcon = Icons.visibility_off;
  IconData suffixIconSignUp = Icons.visibility_off;

  void changeCheckBoxValue(value) {
    checkBoxValue = value;
    emit(ChangeCheckBoxValue());
  }

  Future<void> login(BuildContext context, VoidCallback onSuccess) async {
    emit(LoginLoading());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddressController.text, password: passwordController.text)
        .then((value) async {
      await getPharmacy(onSuccess, value.user!.uid);
    }).catchError((onError) {
      emit(LoginError());
      Fluttertoast.showToast(msg: onError.message.toString());
    });
  }

  Future<void> getPharmacy(VoidCallback onSuccess, pharmacyId) async {
    var pharmacy = FirebaseFirestore.instance.collection('pharmacies').doc(pharmacyId);
    var pharmacyData = await pharmacy.get();

    if (pharmacyData.data() != null) {
      List<CategoryModel> categories = [];
      List<ProductsModel> products = [];
      List<OffersModel> offers = [];
      for (var category in pharmacyData.data()!['categories']) {
        categories.add(CategoryModel.fromJson(category));
      }
      await pharmacy.collection('products').get().then((value) {
        for (var element in value.docs) {
          products.add(ProductsModel.fromJson(element.data()));
        }
      });
      await pharmacy.collection('offers').get().then((value) {
        for (var element in value.docs) {
          offers.add(OffersModel.fromJson(element.data()));
        }
      });
      Constants.pharmacyModel = PharmacyModel.fromJson(
        json: pharmacyData.data(),
        categories: categories,
        offers: offers,
        products: products,
      );
      emit(LoginSuccessfully());
      onSuccess.call();
    } else {
      emit(LoginError());
      showToast('Not a Pharmacy');
    }
  }

  void suffixPressed() {
    obscure = !obscure;
    if (obscure) {
      suffixIcon = Icons.visibility_off;
      emit(ChangeObscure());
    } else {
      suffixIcon = Icons.visibility;
      emit(ChangeObscure());
    }
  }

  void clearTextFormFields() {
    emailAddressController.text = '';
    emailAddressSignUpController.text = '';
    passwordController.text = '';
    passwordSignUpController.text = '';
    emit(ClearAllTextFormFields());
  }
}
