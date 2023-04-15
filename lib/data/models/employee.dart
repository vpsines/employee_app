class Employee {
  final String name;
  final String role;
  final DateTime fromDate;
  final DateTime? toDate;

  Employee({
    required this.name,
    required this.role,
    required this.fromDate,
    this.toDate,
  });
}
