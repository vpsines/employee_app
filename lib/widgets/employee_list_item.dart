import 'package:employee_app/constants/app_icons.dart';
import 'package:employee_app/constants/custom_textstyles.dart';
import 'package:employee_app/data/models/employee.dart';
import 'package:employee_app/providers/employee_provider.dart';
import 'package:employee_app/screens/employee_details_screen.dart';
import 'package:employee_app/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EmployeeListItem extends StatelessWidget {
  final Employee employee;

  const EmployeeListItem({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {

    return Dismissible(
      key: ValueKey<Employee>(employee),
      background: Container(
        width: 230.w,
        color: const Color(0xFFF34642),
        child: Row(
          children: [
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: const Icon(
                AppIcons.trash_empty,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        deleteEmployee(context);
      },
      child: ListTile(
        contentPadding: EdgeInsets.only(top: 16.h, bottom: 16.h, left: 16.w),
        tileColor: Colors.white,
        title: Text(
          employee.name,
          style: kListItemTitleTextStyle,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 6.h,
            ),
            Text(
              employee.role,
              style: kListItemSubTitleTextStyle,
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              employee.toDate != null
                  ? '${dateToString2(employee.fromDate)} - ${dateToString2(employee.toDate!)}'
                  : 'From ${dateToString2(employee.fromDate)}',
              style: kListItemSubTitleTextStyle,
            )
          ],
        ),
        onTap: () {
          // navigate  to EmployeeDetailsScreen
          Navigator.pushNamed(context, EmployeeDetailsScreen.routeName,
              arguments: employee);
        },
      ),
    );
  }

  Future<void> deleteEmployee(context) async {
    await Provider.of<EmployeeProvider>(context, listen: false)
        .deleteEmployee(employee, context);
  }
}
