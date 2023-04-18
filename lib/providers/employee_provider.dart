// ignore_for_file: use_build_context_synchronously

import 'package:employee_app/data/models/employee.dart';
import 'package:employee_app/services/database_services.dart';
import 'package:employee_app/utils/app_utils.dart';
import 'package:flutter/material.dart';

class EmployeeProvider extends ChangeNotifier {
  List<Employee> _employees = [];

  final DatabaseServices databaseServices = DatabaseServices();

  List<Employee> get employees =>
      _employees.where((element) => !element.isDeleted).toList();

  List<Employee> get previousEmployees => _employees
      .where((element) => !element.isDeleted && element.toDate != null)
      .toList();

  List<Employee> get currentEmployees => _employees
      .where((element) => !element.isDeleted && element.toDate == null)
      .toList();

  Future<void> addEmployee(Employee employee, BuildContext context) async {
    final result = await databaseServices.addEmployee(employee);
    if (result > 0) {
      showSnackbar(context, 'Employee added successfully.');
      await getEmployees();
      Navigator.pop(context);
    } else {
      showSnackbar(context, 'Something went wrong.');
    }
  }

  Future<void> getEmployees() async {
    _employees = await databaseServices.getEmployees();
    notifyListeners();
  }

  Future<void> updateEmployee(Employee employee, BuildContext context) async {
    
    final result = await databaseServices.updateEmployee(employee);
    if (result > 0) {
      showSnackbar(context, 'Employee updated successfully.');
      await getEmployees();
      Navigator.pop(context);
    } else {
      showSnackbar(context, 'Something went wrong.');
    }
  }

  Future<void> deleteEmployee(Employee employee, BuildContext context) async {
    final result = await databaseServices.delete(employee);
    if (result > 0) {
      showSnackbarWithActions(context, 'Employee data has been removed.',
          () async {
        await undoDeleteEmployee(employee, context);
      });
      await getEmployees();
    } else {
      showSnackbar(context, 'Something went wrong.');
    }
  }

  Future<void> undoDeleteEmployee(
      Employee employee, BuildContext context) async {
    final result = await databaseServices.restoreEmployee(employee);
    if (result > 0) {
      await getEmployees();
    } else {
      showSnackbar(context, 'Something went wrong.');
    }
  }
}
