import 'package:flutter/material.dart';

DropdownMenuItem<String> dropDownItem(BuildContext context, String value) {
  return DropdownMenuItem(
    value: value,
    child: Text(
      value,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    ),
  );
}
