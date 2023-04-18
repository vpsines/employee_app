import 'package:employee_app/constants/custom_textstyles.dart';
import 'package:employee_app/widgets/dialogs/date_picker_dialog.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? leadingIcon;
  final double? width;
  final double? height;

  const CustomDatePicker(
      {super.key,
      required this.controller,
      required this.hintText,
      this.leadingIcon,
      this.width,
      this.height});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      width: width ?? double.infinity,
      child: TextFormField(
        onTap: () async {
          DateTime date = DateTime.now();
          await showdatePickerDialog(context);
          // await showDatePicker(
          //   context: context, 
          //   initialDate:date, 
          //   firstDate: DateTime(1947), 
          //   lastDate: DateTime(2030),
          //   initialEntryMode: DatePickerEntryMode.calendarOnly
          //   );
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
            border: const OutlineInputBorder(
                borderSide: BorderSide(
              color: Color(0xFFE5E5E5),
              width: 1,
            ))),
      ),
    );
  }
}
