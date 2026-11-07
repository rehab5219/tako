import 'package:flutter/material.dart';
import 'package:tako/core/utils/app_colors.dart';
import 'package:tako/core/utils/styles.dart';

class WeekTextFormField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final TextEditingController? controller;
  final String? labelText;
  final String hintText;
  final Color color;
  const WeekTextFormField({
    super.key,
    this.keyboardType,
    this.validator,
    this.onTap,
    this.controller,
    this.labelText,
    required this.color,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 10,
      controller: controller,
      style: getSmallTextStyle().copyWith(color: color),
      onTap: onTap,
      validator: validator,
      keyboardType: keyboardType,
      cursorColor: color,
      decoration: InputDecoration(
        hintText: hintText,
        label: Text(labelText ?? ''),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.greyColor,
            // width: 2
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.redColor),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
