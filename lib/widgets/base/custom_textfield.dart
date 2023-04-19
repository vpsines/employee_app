import 'package:employee_app/constants/app_colors.dart';
import 'package:employee_app/constants/custom_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? leadingIcon;
  final double? width;
  final double? height;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.leadingIcon,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: TextFormField(
        controller: controller,
        style: kInputTextStyle,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10.h),
            hintText: hintText,
            hintStyle: kHintTextStyle,
            prefixIcon: leadingIcon != null
                ? Icon(
                    leadingIcon,
                    color: kLeadingIconColor,
                  )
                : Container(),
            border: const OutlineInputBorder(
                borderSide: BorderSide(
              color: kTextFieldBorderColor,
              width: 1,
            ))),
      ),
    );
  }
}
