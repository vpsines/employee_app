import 'package:employee_app/data/models/employee.dart';
import 'package:employee_app/utils/database_helper.dart';
import 'package:flutter/foundation.dart';

class DatabaseServices {
  final databaseHelper = DatabaseHelper.instance;

  Future<int> addEmployee(Employee employee) async {
    try {
      return await databaseHelper.insert(employee.toData());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return -1;
    }
  }

  Future<List<Employee>> getEmployees() async {
    try {
      final result = await databaseHelper.getAllRows();
      return result.map((e) => Employee.fromJson(e)).toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  Future<int> updateEmployee(Employee employee) async {
    try {
      return await databaseHelper.update(employee.id, employee.toMap());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return -1;
    }
  }

  Future<int> delete(Employee employee) async {
    try {
      var data = employee.toMap();
      data['isDeleted'] = true;

      return await databaseHelper.update(employee.id, data);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return -1;
    }
  }

  Future<int> restoreEmployee(Employee employee) async {
    try {
      var data = employee.toMap();
      data['isDeleted'] = false;

      return await databaseHelper.update(employee.id, data);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return -1;
    }
  }
}
