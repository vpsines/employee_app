import 'package:employee_app/constants/app_colors.dart';
import 'package:employee_app/constants/app_constants.dart';
import 'package:employee_app/constants/custom_textstyles.dart';
import 'package:employee_app/data/models/employee.dart';
import 'package:employee_app/providers/employee_provider.dart';
import 'package:employee_app/utils/date_utils.dart';
import 'package:employee_app/widgets/base/custom_button.dart';
import 'package:employee_app/widgets/base/custom_date_picker.dart';
import 'package:employee_app/widgets/base/custom_dropdown.dart';
import 'package:employee_app/widgets/base/custom_textfield.dart';
import 'package:employee_app/widgets/date_picker/custom_calendar_date_picker.dart'
    as picker;
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _employeeFormKey = GlobalKey<FormState>();
    // if edit mode, initialize controllers
    if (widget.isEdit) {
      nameController = TextEditingController(text: widget.employee?.name);
      roleController = TextEditingController(text: widget.employee?.role);
      fromDateController =
          TextEditingController(text: dateToString(widget.employee!.fromDate));
      toDateController = TextEditingController(
          text: widget.employee?.toDate != null
              ? dateToString(widget.employee!.toDate!)
              : 'No date');
    } else {
      nameController = TextEditingController();
      roleController = TextEditingController();
      fromDateController = TextEditingController(text: 'Today');
      toDateController = TextEditingController();
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
    var size = MediaQuery.of(context).size;
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
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.037),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.026,
                    ),
                    CustomTextField(
                      controller: nameController,
                      hintText: 'Employee name',
                      leadingIcon: Icons.person_outline,
                      // height: size.height * 0.043,
                    ),
                    SizedBox(
                      height: size.height * 0.026,
                    ),
                    CustomDropDown(
                      items: AppConstants.roles,
                      controller: roleController,
                      hintText: 'Select role',
                      leadingIcon: Icons.work_outline,
                      trailingIcon: Icons.arrow_drop_down_rounded,
                      // height: size.height * 0.043,
                    ),
                    SizedBox(
                      height: size.height * 0.026,
                    ),
                    SizedBox(
                      height: size.height * 0.075,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomDatePicker(
                            leadingIcon: Icons.event,
                            controller: fromDateController,
                            hintText: 'From date',
                            width: size.width * 0.4,
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
                            width: size.width * 0.4,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
              Column(
                children: [
                  Container(
                    height: 2,
                    color: const Color(0xFFF2F2F2),
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          buttonText: 'Cancel',
                          width: size.width * 0.17,
                          height: size.height * 0.043,
                          textColor: const Color(0XFF1DA1F2),
                          backgroundColor: const Color(0xFFEDF8FF),
                          borderRadius: 6,
                        ),
                        SizedBox(
                          width: size.width * 0.037,
                        ),
                        CustomButton(
                          onPressed: () {
                            if (_employeeFormKey.currentState!.validate()) {
                              Employee data = Employee(
                                  name: nameController.text.trim(),
                                  role: roleController.text.trim(),
                                  fromDate: dateFromString(
                                      fromDateController.text.trim()),
                                  toDate: dateFromString(
                                      toDateController.text.trim()));

                              if (widget.isEdit) {
                                // TODO: edit employee
                              } else {
                                employeeProvider.employees.add(data);
                                Navigator.pop(context);
                                // TODO: add employee
                              }
                            }
                          },
                          buttonText: 'Save',
                          width: size.width * 0.17,
                          height: size.height * 0.043,
                          borderRadius: 6,
                        ),
                        SizedBox(
                          width: size.width * 0.037,
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
}
