import 'package:employee_app/constants/custom_textstyles.dart';
import 'package:employee_app/widgets/base/custom_button.dart';
import 'package:employee_app/widgets/date_picker/custom_calendar_date_picker.dart'
    as picker;
import 'package:flutter/material.dart';

Future<void> showdatePickerDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return const _DatePickerDialog();
    },
  );
}

class _DatePickerDialog extends StatefulWidget {
  const _DatePickerDialog({super.key});

  @override
  State<_DatePickerDialog> createState() => _DatePickerDialogState();
}

class _DatePickerDialogState extends State<_DatePickerDialog> {
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: size.width * 0.037, vertical: size.height * 0.075),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.white,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: size.width * 0.037, vertical: size.height * 0.0259),
          child: Column(
            children: [
              SizedBox(
                height: 36,
                child: Row(
                  children: [
                    CustomButton(
                      onPressed: () {
                        setState(() {
                          isSelected = 0;
                        });
                      },
                      buttonText: 'No date',
                      borderRadius: 4,
                      backgroundColor: isSelected == 0
                          ? const Color(0xFF1DA1F2)
                          : const Color(0xFFEDF8FF),
                      textColor: isSelected == 0
                          ? Colors.white
                          : const Color(0xFF1DA1F2),
                      width: size.width * 0.406,
                    ),
                    const Spacer(),
                    CustomButton(
                      onPressed: () {
                        setState(() {
                          isSelected = 1;
                        });
                      },
                      buttonText: 'Today',
                      borderRadius: 4,
                      backgroundColor: isSelected == 1
                          ? const Color(0xFF1DA1F2)
                          : const Color(0xFFEDF8FF),
                      textColor: isSelected == 1
                          ? Colors.white
                          : const Color(0xFF1DA1F2),
                      width: size.width * 0.406,
                    ),
                  ],
                ),
              ),
               SizedBox(
                height: size.height *0.017,
              ),
              SizedBox(
                height: 36,
                child: Row(
                  children: [
                    CustomButton(
                      onPressed: () {
                        setState(() {
                          isSelected = 2;
                        });
                      },
                      buttonText: 'Next Monday',
                      borderRadius: 4,
                      backgroundColor: isSelected == 2
                          ? const Color(0xFF1DA1F2)
                          : const Color(0xFFEDF8FF),
                      textColor: isSelected == 2
                          ? Colors.white
                          : const Color(0xFF1DA1F2),
                      width: size.width * 0.406,
                    ),
                    const Spacer(),
                    CustomButton(
                      onPressed: () {
                        setState(() {
                          isSelected = 3;
                        });
                      },
                      buttonText: 'Next Tuesday',
                      borderRadius: 4,
                      backgroundColor: isSelected == 3
                          ? const Color(0xFF1DA1F2)
                          : const Color(0xFFEDF8FF),
                      textColor: isSelected == 3
                          ? Colors.white
                          : const Color(0xFF1DA1F2),
                      width: size.width * 0.406,
                    ),
                  ],
                ),
              ),
              picker.CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2050),
                  onDateChanged: (value) {}),
              const Divider(
                thickness: 1,
                color: Color(0xFFF2F2F2),
              ),
              SizedBox(
                height: size.height * 0.095,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.event_outlined,
                          size: 24,
                          color: Color(0xFF1DA1F2),
                        ),
                        Text('5 Sep 2023', style: kInputTextStyle)
                      ],
                    ),
                    const Spacer(),
                    CustomButton(
                      onPressed: () {},
                      buttonText: 'Cancel',
                      width: size.width * 0.17,
                      height: size.height * 0.043,
                      textColor: const Color(0XFF1DA1F2),
                      backgroundColor: const Color(0xFFEDF8FF),
                      borderRadius: 6,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    CustomButton(
                      onPressed: () {},
                      buttonText: 'Save',
                      width: size.width * 0.17,
                      height: size.height * 0.043,
                      borderRadius: 6,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
