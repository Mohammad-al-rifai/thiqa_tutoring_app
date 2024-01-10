// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

class TFF extends StatelessWidget {
  TFF({
    super.key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    required this.validator,
    this.suffix,
    this.onFieldSubmitted,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.onTap,
    this.suffixPressed,
  });

  TextEditingController controller;
  String label;
  IconData prefixIcon;
  IconData? suffix;
  Function validator;
  Function? onFieldSubmitted;
  Function? onChanged;
  TextInputType keyboardType;
  bool isPassword;
  Function? suffixPressed;
  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: getMediumStyle(color: ColorManager.primary, fontSize: AppSize.s14),
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        hintText: label,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(
                  suffix,
                ),
                onPressed: () {
                  if (suffixPressed != null) {
                    suffixPressed!();
                  }
                },
              )
            : null,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      obscureText: isPassword,
      validator: (value) => validator(value),
      onFieldSubmitted: (value) {
        if (onFieldSubmitted != null) {
          onFieldSubmitted!(value);
        }
      },
      onChanged: (String value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
    );
  }
}
