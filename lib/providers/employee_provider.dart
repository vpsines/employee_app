import 'package:employee_app/data/models/employee.dart';
import 'package:employee_app/services/database_services.dart';
import 'package:flutter/material.dart';

class EmployeeProvider extends ChangeNotifier {
  List<Employee> _employees = [
    Employee(
      id: 1,
      name: 'John Snow',
      role: 'Flutter Developer',
      fromDate: DateTime.now(),
    ),
    Employee(
      id: 2,
      name: 'Deepak K',
      role: 'Testing Developer',
      fromDate: DateTime.now(),
    ),
    Employee(
        id: 3,
        name: 'Jack Sparrow',
        role: 'Prouct Manager',
        fromDate: DateTime.now(),
        toDate: DateTime.now()),
    Employee(
        id: 4,
        name: 'Marry James',
        role: 'Tester',
        fromDate: DateTime.now(),
        toDate: DateTime.now()),
  ];

  final DatabaseServices databaseServices = DatabaseServices();

  List<Employee> get employees => _employees;

  List<Employee> get previousEmployees =>
      _employees.where((element) => element.toDate != null).toList();

  List<Employee> get currentEmployees =>
      _employees.where((element) => element.toDate == null).toList();

  Future<void> addEmployee(Employee employee) async {
    await databaseServices.addEmployee(employee);
    getEmployees();
  }

  Future<void> getEmployees() async {
    _employees = await databaseServices.getEmployees();
    notifyListeners();
  }

  Future<void> updateEmployee(Employee employee) async {
    await databaseServices.updateEmployee(employee);
    getEmployees();
  }

  Future<void> deleteEmployee(Employee employee) async {
    await databaseServices.delete(employee);
    getEmployees();
  }

  Future<void> undoDeleteEmployee(Employee employee) async {
    await databaseServices.restoreEmployee(employee);
    getEmployees();
  }
}
