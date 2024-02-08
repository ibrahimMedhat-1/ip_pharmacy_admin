import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_pharmacy_admin/feature/authentication/view/login_page.dart';
import 'package:ip_pharmacy_admin/feature/authentication/view/widgets/custom_text_form.dart';
import 'package:ip_pharmacy_admin/feature/profile/manager/profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          final ProfileCubit cubit = ProfileCubit.get(context);
          return Scaffold(
              body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    if (state is UpdatePharmacyDataLoading) const LinearProgressIndicator(),
                    if (cubit.profileImage == null)
                      InkWell(
                        onTap: () {
                          cubit.getProfileImage();
                        },
                        child: CachedNetworkImage(
                          imageUrl: 'Constants.pharmacyModel!.image!',
                          imageBuilder: (context, imageProvider) => CircleAvatar(
                            radius: 80,
                            backgroundImage: imageProvider,
                          ),
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const CircleAvatar(
                            radius: 80,
                            child: Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                    else
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(cubit.profileImage ?? File('')),
                      ),
                    CustomTextForm(
                      controller: cubit.nameController,
                      obscure: false,
                      labelText: 'Name',
                      hintText: 'Name',
                      keyboardType: TextInputType.name,
                      validationText: '',
                    ),
                    CustomTextForm(
                      controller: cubit.addressController,
                      obscure: false,
                      labelText: 'Address',
                      hintText: 'Address',
                      keyboardType: TextInputType.streetAddress,
                      validationText: '',
                    ),
                    CustomTextForm(
                      controller: cubit.phoneController,
                      obscure: false,
                      labelText: 'Phone',
                      hintText: 'Phone',
                      keyboardType: TextInputType.phone,
                      validationText: '',
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {
                            cubit.updateData();
                          },
                          child: const Text('Save'),
                        ),
                        MaterialButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => const LoginPage(),
                                ));
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
