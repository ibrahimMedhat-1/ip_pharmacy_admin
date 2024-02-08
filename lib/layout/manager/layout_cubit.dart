import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_pharmacy_admin/feature/medicine/view/medicine_page.dart';
import 'package:ip_pharmacy_admin/feature/profile/view/profile_page.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());
  static LayoutCubit get(context) => BlocProvider.of(context);
  List<Widget> pages = const [
    MedicinePage(),
    ProfilePage(),
  ];
  int page = 0;
  void changePage(index) {
    page = index;
    emit(ChangeLayoutPage());
  }
}
