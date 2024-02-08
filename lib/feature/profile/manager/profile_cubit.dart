import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ip_pharmacy_admin/models/pharmacy_model.dart';

import '../../../shared/utils/constants.dart';
import '../../../shared/utils/image_helper/image_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? profileImage;

  void getProfileImage() async {
    List<XFile?>? images;
    images = await ImageHelper().pickImage();
    profileImage = File(images.first!.path);
    CroppedFile? croppedImage;
    croppedImage = await ImageHelper().crop(file: images.first!, cropStyle: CropStyle.circle);
    if (croppedImage != null) {
      profileImage = File(croppedImage.path);
    }
    emit(GetProfileImage());
  }

  void updateData() async {
    emit(UpdatePharmacyDataLoading());
    String imageLink = '';
    if (profileImage != null) {
      await FirebaseStorage.instance
          .ref()
          .child('pharmacies/${Constants.pharmacyModel!.id}/profileImage/')
          .putFile(profileImage!)
          .then((p0) async {
        await p0.ref.getDownloadURL().then((value) {
          imageLink = value;
        });
      });
    }
    await FirebaseFirestore.instance
        .collection('pharmacies')
        .doc(Constants.pharmacyModel!.id)
        .update(PharmacyModel(
          name: nameController.text,
          image: imageLink,
          phoneNo: phoneController.text,
          address: addressController.text,
        ).toMap());
    emit(UpdatePharmacyData());
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Constants.pharmacyModel = null;
  }
}
