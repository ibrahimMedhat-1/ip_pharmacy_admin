import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(radius: 80),
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
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
