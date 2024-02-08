import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ip_pharmacy_admin/feature/authentication/view/widgets/auth_button.dart';

import '../../medicine/view/medicine_page.dart';
import '../manager/auth_cubit.dart';
import 'widgets/custom_text_form.dart';
import 'widgets/welcome_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Scaffold(
            key: cubit.scaffoldKey,
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7,
                      color: Color(0x4D090F13),
                      offset: Offset(0, 3),
                    )
                  ],
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(16),
                    left: Radius.circular(16),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const WelcomeWidget(
                          welcomeText: 'Welcome Back',
                          backGroundColor: Colors.white,
                          textColor: Colors.black,
                        ),
                        CustomTextForm(
                          controller: cubit.emailAddressController,
                          obscure: false,
                          labelText: 'Email Address',
                          hintText: 'Enter your email here...',
                          keyboardType: TextInputType.emailAddress,
                          validationText: 'Please enter your email',
                        ),
                        CustomTextForm(
                          controller: cubit.passwordController,
                          obscure: cubit.obscure,
                          labelText: 'Password',
                          hintText: 'Enter your password here...',
                          suffixIcon: cubit.suffixIcon,
                          suffixPressed: cubit.suffixPressed,
                          keyboardType: TextInputType.visiblePassword,
                          validationText: 'Please enter your password',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  cubit.clearTextFormFields();
                                },
                                child: const Text('Forgot Password?'),
                              ),
                              state is LoginLoading
                                  ? const CircularProgressIndicator()
                                  : AuthButton(
                                      onTap: () async {
                                        if (formKey.currentState!.validate()) {
                                          await cubit.login(context, () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (builder) => const MedicinePage()));
                                          });
                                        }
                                      },
                                      text: 'Login',
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
