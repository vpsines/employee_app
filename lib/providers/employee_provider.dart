import 'package:employee_app/data/models/employee.dart';
import 'package:flutter/cupertino.dart';

class EmployeeProvider extends ChangeNotifier {
  List<Employee> _employees = [
    Employee(
      name: 'John Snow',
      role: 'Flutter Developer',
      fromDate: DateTime.now(),
    ),
    Employee(
      name: 'Deepak K',
      role: 'Testing Developer',
      fromDate: DateTime.now(),
    ),
    Employee(
        name: 'Jack Sparrow',
        role: 'Prouct Manager',
        fromDate: DateTime.now(),
        toDate: DateTime.now()),
        Employee(
        name: 'Marry James',
        role: 'Tester',
        fromDate: DateTime.now(),
        toDate: DateTime.now()),
  ];

  List<Employee> get employees => _employees;

  List<Employee> get previousEmployees =>
      _employees.where((element) => element.toDate != null).toList();

  List<Employee> get currentEmployees =>
      _employees.where((element) => element.toDate == null).toList();
}
