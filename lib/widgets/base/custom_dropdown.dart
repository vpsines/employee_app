import 'package:employee_app/constants/app_colors.dart';
import 'package:employee_app/constants/app_constants.dart';
import 'package:employee_app/constants/custom_textstyles.dart';
import 'package:flutter/material.dart';

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
    var size = MediaQuery.of(context).size;

    return SizedBox(
      width: width ?? double.infinity,
      child: TextFormField(
        onTap: () async {
        final index = await showModalBottomSheet<int>(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),        
            ),
            backgroundColor: kDropDownItemBackgroundColor,
            builder: (context) {
              return ListView.separated(
                shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.pop(context, index),
                      child: SizedBox(
                        height: 52,  // TODO: make it responsive
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.037,
                            vertical: size.height * 0.0173,
                          ),
                          child: Center(
                            child: Text(
                              AppConstants.roles[index],
                              style: kDropDownItemTextStyle,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 1,
                      color: kBackgroundColor,
                    );
                  },
                  itemCount: AppConstants.roles.length);
            });
          if(index != null){
          controller.text = AppConstants.roles[index];
          }
      },
      readOnly: true,
        controller: controller,
        style: kInputTextStyle,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: kHintTextStyle,
            prefixIcon: leadingIcon != null
                ? Icon(
                    leadingIcon,
                    size: 24,
                    color: const Color(0xFF1DA1F2),
                  )
                : Container(),
            suffixIcon: trailingIcon != null
                ? Icon(
                    trailingIcon,
                    size: 50,
                    color: const Color(0xFF1DA1F2),
                  )
                : Container(),
            border: const OutlineInputBorder(
                borderSide: BorderSide(
              color: Color(0xFFE5E5E5),
              width: 1,
            ))),
      ),
    );
  }
}
