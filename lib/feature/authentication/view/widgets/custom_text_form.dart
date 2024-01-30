import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  IconData? suffixIcon;
  Function()? suffixPressed;
  final bool obscure;
  final TextInputType keyboardType;
  final String validationText;

  bool isEnabled;
  CustomTextForm({
    super.key,
    this.isEnabled = true,
    required this.controller,
    required this.obscure,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    required this.validationText,
    this.suffixIcon,
    this.suffixPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              enabled: isEnabled,
              keyboardType: keyboardType,
              controller: controller,
              obscureText: obscure,
              style: textTheme.titleSmall,
              validator: (value) {
                if (value!.isEmpty) {
                  return validationText;
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: textTheme.bodyMedium!.copyWith(color: Colors.grey),
                hintText: hintText,
                hintStyle: textTheme.bodyMedium!.copyWith(color: Colors.grey),
                suffixIcon: suffixIcon == null
                    ? null
                    : IconButton(
                        onPressed: () {
                          suffixPressed!();
                        },
                        icon: Icon(
                          suffixIcon,
                          color: Colors.grey,
                        ),
                      ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x6095A1AC),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0x00000000),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
