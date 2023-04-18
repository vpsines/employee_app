import 'package:employee_app/constants/app_icons.dart';
import 'package:employee_app/constants/custom_textstyles.dart';
import 'package:employee_app/data/models/employee.dart';
import 'package:employee_app/providers/employee_provider.dart';
import 'package:employee_app/screens/employee_details_screen.dart';
import 'package:employee_app/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeListItem extends StatelessWidget {
  final Employee employee;

  const EmployeeListItem({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Dismissible(
      key: ValueKey<Employee>(employee),
      background: Container(
        width: size.width * 0.25,
        color: const Color(0xFFF34642),
        child: Row(
          children: [
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.1),
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
        contentPadding: EdgeInsets.only(
            top: 0.017 * size.height,
            bottom: 0.017 * size.height,
            left: 0.037 * size.width),
        tileColor: Colors.white,
        title: Text(
          employee.name,
          style: kListItemTitleTextStyle,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              employee.role,
              style: kListItemSubTitleTextStyle,
            ),
            const SizedBox(
              height: 5,
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
