import 'package:employee_app/constants/app_colors.dart';
import 'package:employee_app/constants/custom_textstyles.dart';
import 'package:employee_app/constants/images.dart';
import 'package:employee_app/providers/employee_provider.dart';
import 'package:employee_app/widgets/employee_list_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmployeeListScreen extends StatelessWidget {
  static const String routeName = '/employee-list';

  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.19,
                      vertical: size.height * 0.26),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Images.noRecordsFound,
                        width: size.width * 0.612,
                        height: size.height * 0.237,
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
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.017,
                                    left: size.width * 0.04,
                                    bottom: size.height * 0.017,
                                  ),
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
                                  padding: EdgeInsets.only(
                                    top: size.height * 0.017,
                                    left: size.width * 0.04,
                                    bottom: size.height * 0.017,
                                  ),
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
                            top: size.height * 0.013, left: size.width * 0.037),
                        child: Text(
                          'Swipe left to delete',
                          style: GoogleFonts.roboto(
                              color: const Color(0XFF949C9E),
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
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
