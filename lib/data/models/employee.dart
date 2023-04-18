import 'package:employee_app/utils/date_utils.dart';

class Employee {
  late final int id;
  final String name;
  final String role;
  final DateTime fromDate;
  final DateTime? toDate;
  final bool isDeleted;

  Employee(
      {this.id = 0,
      required this.name,
      required this.role,
      required this.fromDate,
      this.toDate,
      this.isDeleted = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'fromDate': dateToString(fromDate),
      'toDate': toDate !=null ? dateToString(toDate!):null,
      'isDeleted': isDeleted ? 1:0
    };
  }

  Map<String, dynamic> toData() {
    return {
      'name': name,
      'role': role,
      'fromDate': dateToString(fromDate),
      'toDate': toDate !=null ? dateToString(toDate!):null,
      'isDeleted': isDeleted ? 1:0
    };
  }

  factory Employee.fromJson(Map<String, dynamic> map) {
    return Employee(
        id: map['id'],
        name: map['name'],
        role: map['role'],
        fromDate:dateFromString(map['fromDate']),
        toDate: map['toDate'] !=null ? dateFromString(map['toDate']):null,
        isDeleted: map['isDeleted'] >0 );
  }
}
