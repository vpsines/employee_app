import 'package:employee_app/data/models/employee.dart';
import 'package:employee_app/screens/employee_details_screen.dart';
import 'package:employee_app/screens/employee_list_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRouteSettings(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case EmployeeListScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EmployeeListScreen(),
      );
      case EmployeeDetailsScreen.routeName:
      var employee = routeSettings.arguments as Employee?;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  EmployeeDetailsScreen(employee: employee,isEdit: employee!=null,),
      );
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Page not found!'),
                ),
              ));
  }
}
