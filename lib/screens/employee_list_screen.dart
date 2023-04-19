import 'package:employee_app/constants/app_colors.dart';
import 'package:employee_app/constants/custom_textstyles.dart';
import 'package:employee_app/constants/images.dart';
import 'package:employee_app/providers/employee_provider.dart';
import 'package:employee_app/screens/employee_details_screen.dart';
import 'package:employee_app/widgets/employee_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmployeeListScreen extends StatefulWidget {
  static const String routeName = '/';

  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<EmployeeProvider>(context, listen: false).getEmployees();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Employee List',
          style: kAppBarTitleTextStyle,
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: Consumer<EmployeeProvider>(
        builder: (context, employeeProvider, child) {
          return (employeeProvider.employees.isEmpty)
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        Images.noRecordsFound,
                      ),
                      Text(
                        'No employee records found',
                        style: kBodyTextStyle,
                      )
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (employeeProvider.currentEmployees.isNotEmpty)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 16.h),
                                  child: Text(
                                    'Current employees',
                                    style: kBodyTitleTextStyle,
                                  ),
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      employeeProvider.currentEmployees.length,
                                  itemBuilder: (context, index) {
                                    return EmployeeListItem(
                                      employee: employeeProvider
                                          .currentEmployees[index],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Container(
                                      height: 1,
                                      color: kBackgroundColor,
                                    );
                                  },
                                ),
                              ],
                            )
                          : Container(),
                      (employeeProvider.previousEmployees.isNotEmpty)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 16.h),
                                  child: Text(
                                    'Previous employees',
                                    style: kBodyTitleTextStyle,
                                  ),
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      employeeProvider.previousEmployees.length,
                                  itemBuilder: (context, index) {
                                    return EmployeeListItem(
                                      employee: employeeProvider
                                          .previousEmployees[index],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Container(
                                      height: 1,
                                      color: kBackgroundColor,
                                    );
                                  },
                                ),
                              ],
                            )
                          : Container(),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 12.h, left: 16.w),
                        child: Text(
                          'Swipe left to delete',
                          style: GoogleFonts.roboto(
                              color: const Color(0XFF949C9E),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          // navigate to Employee Details screen
          Navigator.pushNamed(context, EmployeeDetailsScreen.routeName)
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
