import 'package:employee_app/constants/custom_textstyles.dart';
import 'package:employee_app/data/models/employee.dart';
import 'package:flutter/material.dart';

class EmployeeListItem extends StatelessWidget {
  final Employee employee;

  const EmployeeListItem({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ListTile(
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
            '21 Sep, 2022 - 22 Sep,2023',
            style: kListItemSubTitleTextStyle,
          )
        ],
      ),
    );
  }
}
