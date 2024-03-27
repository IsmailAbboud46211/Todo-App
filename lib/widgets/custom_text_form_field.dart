import 'package:flutter/material.dart';
import 'package:todo/screen/screens.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labekText;
  final String hintText;
  final Icon prefixIcon;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labekText,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: AppColors.lightGreen),
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        hoverColor: AppColors.secondryColor,
        errorStyle: TextStyle(
          color: AppColors.lightGreen,
          fontWeight: FontWeight.bold,
        ),
        labelStyle: TextStyle(color: AppColors.lightGreen),
        helperStyle: TextStyle(color: AppColors.lightGreen),
        hintStyle: TextStyle(color: AppColors.lightGreen),
        prefixIconColor: AppColors.lightGreen,
        focusColor: AppColors.secondryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.lightGreen,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.lightGreen,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        labelText: labekText,
        hintText: hintText,
        prefixIcon: prefixIcon,
      ),
      validator: validator,
    );
  }
}
