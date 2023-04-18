import 'package:employee_app/constants/custom_textstyles.dart';
import 'package:employee_app/utils/date_utils.dart';
import 'package:employee_app/widgets/base/custom_button.dart';
import 'package:employee_app/widgets/date_picker/custom_calendar_date_picker.dart'
    as picker;
import 'package:flutter/material.dart';

Future<void> showdatePickerDialog(
    {required BuildContext context,
    required VoidCallback onCancel,
    required Function(DateTime?) onSave,
    bool isRequiredField = true,
    DateTime? date,
    SelectableDayPredicate? selectableDayPredicate,
    DateTime? firstDate}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return _DatePickerDialog(
        onCancel: onCancel,
        date: date,
        isRequired: isRequiredField,
        onSave: onSave,
        firstDate: firstDate,
      );
    },
  );
}

enum DateOptions { noDate, today, nextMonday, nextTuesday, afterOneWeek, none }

class _DatePickerDialog extends StatefulWidget {
  const _DatePickerDialog(
      {super.key,
      required this.onCancel,
      this.date,
      required this.isRequired,
      required this.onSave,
      this.selectableDayPredicate,
      this.firstDate});

  final DateTime? date;
  final VoidCallback onCancel;
  final Function(DateTime?) onSave;
  final bool isRequired;
  final SelectableDayPredicate? selectableDayPredicate;
  final DateTime? firstDate;

  @override
  State<_DatePickerDialog> createState() => _DatePickerDialogState();
}

class _DatePickerDialogState extends State<_DatePickerDialog> {
  late DateOptions selectedDateOption;
  late DateTime _selectedDate;

  @override
  void initState() {
    if (widget.date != null) {
      _selectedDate = widget.date!;
      selectedDateOption = DateOptions.none;
    } else {
      selectedDateOption = DateOptions.noDate;
      _selectedDate = widget.firstDate!;
    }
    super.initState();
  }

  void onDateOptionsTap(DateOptions dateOption) {
    if (dateOption != selectedDateOption) {
      switch (dateOption) {
        case DateOptions.today:
          _selectedDate = DateTime.now();
          selectedDateOption = DateOptions.today;
          break;
        case DateOptions.nextMonday:
          int daysUntillMonday = 8 - _selectedDate.weekday;
          _selectedDate = _selectedDate.add(Duration(days: daysUntillMonday));
          selectedDateOption = DateOptions.nextMonday;
          break;
        case DateOptions.nextTuesday:
          int daysUntillTuesday = 9 - _selectedDate.weekday;
          _selectedDate = _selectedDate.add(
              Duration(days: daysUntillTuesday == 8 ? 1 : daysUntillTuesday));
          selectedDateOption = DateOptions.nextTuesday;
          break;
        case DateOptions.afterOneWeek:
          _selectedDate = _selectedDate.add(const Duration(days: 7));
          selectedDateOption = DateOptions.afterOneWeek;
          break;
        case DateOptions.noDate:
          selectedDateOption = DateOptions.noDate;
          break;
        default:
          selectedDateOption = DateOptions.none;
          break;
      }
      setState(() {});
    }
  }

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
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.037, vertical: size.height * 0.0259),
          child: Column(
            children: [
              SizedBox(
                height: widget.isRequired ? 72 : 36,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    (!widget.isRequired)
                        ? CustomButton(
                            onPressed: () =>
                                onDateOptionsTap(DateOptions.noDate),
                            buttonText: 'No date',
                            borderRadius: 4,
                            backgroundColor:
                                selectedDateOption == DateOptions.noDate
                                    ? const Color(0xFF1DA1F2)
                                    : const Color(0xFFEDF8FF),
                            textColor: selectedDateOption == DateOptions.noDate
                                ? Colors.white
                                : const Color(0xFF1DA1F2),
                            width: size.width * 0.406,
                          )
                        : Container(),
                    (DateTime.now().isAfter(widget.firstDate ?? DateTime(1950)))
                        ? CustomButton(
                            onPressed: () =>
                                onDateOptionsTap(DateOptions.today),
                            buttonText: 'Today',
                            borderRadius: 4,
                            backgroundColor:
                                selectedDateOption == DateOptions.today
                                    ? const Color(0xFF1DA1F2)
                                    : const Color(0xFFEDF8FF),
                            textColor: selectedDateOption == DateOptions.today
                                ? Colors.white
                                : const Color(0xFF1DA1F2),
                            width: size.width * 0.406,
                          )
                        : Container(),
                    (widget.isRequired)
                        ? CustomButton(
                            onPressed: () =>
                                onDateOptionsTap(DateOptions.nextMonday),
                            buttonText: 'Next Monday',
                            borderRadius: 4,
                            backgroundColor:
                                selectedDateOption == DateOptions.nextMonday
                                    ? const Color(0xFF1DA1F2)
                                    : const Color(0xFFEDF8FF),
                            textColor:
                                selectedDateOption == DateOptions.nextMonday
                                    ? Colors.white
                                    : const Color(0xFF1DA1F2),
                            width: size.width * 0.406,
                          )
                        : Container(),
                    (widget.isRequired)
                        ? CustomButton(
                            onPressed: () =>
                                onDateOptionsTap(DateOptions.nextTuesday),
                            buttonText: 'Next Tuesday',
                            borderRadius: 4,
                            backgroundColor:
                                selectedDateOption == DateOptions.nextTuesday
                                    ? const Color(0xFF1DA1F2)
                                    : const Color(0xFFEDF8FF),
                            textColor:
                                selectedDateOption == DateOptions.nextTuesday
                                    ? Colors.white
                                    : const Color(0xFF1DA1F2),
                            width: size.width * 0.406,
                          )
                        : Container(),
                    (widget.isRequired)
                        ? CustomButton(
                            onPressed: () =>
                                onDateOptionsTap(DateOptions.afterOneWeek),
                            buttonText: 'After 1 week',
                            borderRadius: 4,
                            backgroundColor:
                                selectedDateOption == DateOptions.afterOneWeek
                                    ? const Color(0xFF1DA1F2)
                                    : const Color(0xFFEDF8FF),
                            textColor:
                                selectedDateOption == DateOptions.afterOneWeek
                                    ? Colors.white
                                    : const Color(0xFF1DA1F2),
                            width: size.width * 0.406,
                          )
                        : Container(),
                  ],
                ),
              ),
              picker.CalendarDatePicker(
                initialDate: _selectedDate,
                firstDate: widget.firstDate ?? DateTime(1950),
                lastDate: DateTime(2050),
                onDateChanged: (value) {
                  selectedDateOption = DateOptions.none;
                  setState(() {
                    _selectedDate = value;
                  });
                },
                selectableDayPredicate: widget.selectableDayPredicate,
              ),
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
                        Text(
                            selectedDateOption == DateOptions.noDate
                                ? 'No date'
                                : dateToString(_selectedDate),
                            style: kInputTextStyle)
                      ],
                    ),
                    const Spacer(),
                    CustomButton(
                      onPressed: widget.onCancel,
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
                      onPressed: () => widget.onSave(
                          selectedDateOption == DateOptions.noDate
                              ? null
                              : _selectedDate),
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
