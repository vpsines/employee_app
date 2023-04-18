import 'package:employee_app/providers/employee_provider.dart';
import 'package:employee_app/router.dart';
import 'package:employee_app/screens/employee_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EmployeeProvider>(
            create: (_) => EmployeeProvider()),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          title: 'Employee App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: (settings) => generateRouteSettings(settings),
          initialRoute: EmployeeListScreen.routeName,
        ),
        designSize: const Size(428, 926),
      ),
    );
  }
}
