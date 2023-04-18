import 'package:employee_app/constants/app_colors.dart';
import 'package:employee_app/constants/app_constants.dart';
import 'package:employee_app/constants/custom_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDown extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final double? width;
  final double? height;
  final List<String> items;

  const CustomDropDown(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.items,
      this.leadingIcon,
      this.width,
      this.height,
      this.trailingIcon});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: width ?? double.infinity,
      child: TextFormField(
        onTap: () async {
          final index = await showModalBottomSheet<int>(
              context: context,
              isScrollControlled: true,
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
              backgroundColor: kDropDownItemBackgroundColor,
              builder: (context) {
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.pop(context, index),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          child: Center(
                            child: Text(
                              AppConstants.roles[index],
                              style: kDropDownItemTextStyle,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1.h,
                        color: kBackgroundColor,
                      );
                    },
                    itemCount: AppConstants.roles.length);
              });
          if (index != null) {
            controller.text = AppConstants.roles[index];
          }
        },
        readOnly: true,
        controller: controller,
        style: kInputTextStyle,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10.h),
            hintText: hintText,
            hintStyle: kHintTextStyle,
            prefixIcon: leadingIcon != null
                ? Icon(
                    leadingIcon,
                    size: 24,
                    color: kLeadingIconColor,
                  )
                : Container(),
            suffixIcon: trailingIcon != null
                ? Icon(
                    trailingIcon,
                    size: 30,
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
