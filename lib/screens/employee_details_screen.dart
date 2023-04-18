import 'package:employee_app/constants/app_constants.dart';
import 'package:employee_app/constants/custom_textstyles.dart';
import 'package:employee_app/data/models/employee.dart';
import 'package:employee_app/providers/employee_provider.dart';
import 'package:employee_app/utils/app_utils.dart';
import 'package:employee_app/utils/date_utils.dart';
import 'package:employee_app/widgets/base/custom_button.dart';
import 'package:employee_app/widgets/base/custom_date_picker.dart';
import 'package:employee_app/widgets/base/custom_dropdown.dart';
import 'package:employee_app/widgets/base/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  static const String routeName = '/employee-details';

  final Employee? employee;
  final bool isEdit;

  const EmployeeDetailsScreen({super.key, this.employee, this.isEdit = false});

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  late TextEditingController nameController;
  late TextEditingController roleController;
  late TextEditingController fromDateController;
  late TextEditingController toDateController;
  late GlobalKey<FormState> _employeeFormKey;

  late DateTime fromdate;
  DateTime? toDate;

  @override
  void initState() {
    super.initState();
    _employeeFormKey = GlobalKey<FormState>();

    // if edit mode, initialize controllers
    if (widget.isEdit) {
      fromdate = widget.employee!.fromDate;
      toDate = widget.employee!.toDate;

      nameController = TextEditingController(text: widget.employee?.name);
      roleController = TextEditingController(text: widget.employee?.role);
      fromDateController = TextEditingController(text: dateToString(fromdate));
      toDateController = TextEditingController(
          text: toDate != null ? dateToString(toDate!) : 'No date');
    } else {
      nameController = TextEditingController();
      roleController = TextEditingController();
      fromDateController = TextEditingController(text: 'Today');
      toDateController = TextEditingController();

      fromdate = DateTime.now();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    roleController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? 'Edit Employee Details' : 'Add Employee Details',
          style: kAppBarTitleTextStyle,
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Consumer<EmployeeProvider>(
          builder: (context, employeeProvider, child) {
        return Form(
          key: _employeeFormKey,
          child: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 23.h,
                    ),
                    CustomTextField(
                      controller: nameController,
                      hintText: 'Employee name',
                      leadingIcon: Icons.person_outline,
                    ),
                    SizedBox(
                      height: 23.h,
                    ),
                    CustomDropDown(
                      items: AppConstants.roles,
                      controller: roleController,
                      hintText: 'Select role',
                      leadingIcon: Icons.work_outline,
                      trailingIcon: Icons.arrow_drop_down_rounded,
                    ),
                    SizedBox(
                      height: 23.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomDatePicker(
                          leadingIcon: Icons.event,
                          controller: fromDateController,
                          hintText: 'From date',
                          width: 172.w,
                          initialDate: fromdate,
                          onSave: (date) {
                            Navigator.pop(context);
                            fromdate = date!;
                            fromDateController.text =
                                (date != null) ? dateToString(date) : 'No date';
                            setState(() {});
                          },
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          size: 20,
                          color: Color(0xFF1DA1F2),
                        ),
                        CustomDatePicker(
                          leadingIcon: Icons.event,
                          controller: toDateController,
                          hintText: 'No date',
                          width: 172.w,
                          firstDate: fromdate.add(const Duration(days: 1)),
                          initialDate: toDate,
                          onSave: (date) {
                            Navigator.pop(context);
                            toDate = date;
                            toDateController.text =
                                (date != null) ? dateToString(date) : 'No date';
                            setState(() {});
                          },
                          isRequired: false,
                        ),
                      ],
                    )
                  ],
                ),
              )),
              Column(
                children: [
                  Divider(
                    height: 2.w,
                    color: const Color(0xFFF2F2F2),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          buttonText: 'Cancel',
                          textColor: const Color(0XFF1DA1F2),
                          backgroundColor: const Color(0xFFEDF8FF),
                          borderRadius: 6.r,
                          width: 73.w,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        CustomButton(
                          onPressed: () async {
                            if (_employeeFormKey.currentState!.validate() &&
                                checkRequired()) {
                              final fromDate =
                                  (fromDateController.text == 'Today')
                                      ? DateTime.now()
                                      : dateFromString(
                                          fromDateController.text.trim());

                              final toDate = (toDateController.text.isEmpty ||
                                      toDateController.text == 'No date')
                                  ? null
                                  : dateFromString(
                                      toDateController.text.trim());

                              Employee data = Employee(
                                  id: widget.employee != null
                                      ? widget.employee!.id
                                      : 0,
                                  name: nameController.text.trim(),
                                  role: roleController.text.trim(),
                                  fromDate: fromDate,
                                  toDate: toDate);

                              if (widget.isEdit) {
                                await employeeProvider.updateEmployee(
                                    data, context);
                              } else {
                                await employeeProvider.addEmployee(
                                    data, context);
                              }
                            }
                          },
                          buttonText: 'Save',
                          width: 73.w,
                          borderRadius: 6.r,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  bool checkRequired() {
    if (nameController.text.isEmpty) {
      showSnackbar(context, 'Enter employee name.');
      return false;
    }
    if (roleController.text.isEmpty) {
      showSnackbar(context, 'Please select role.');
      return false;
    }

    if (fromDateController.text.isEmpty) {
      showSnackbar(context, 'Please select from date.');
      return false;
    }
    return true;
  }
}
