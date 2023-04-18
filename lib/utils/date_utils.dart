import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat('d MMMM y');

String dateToString(DateTime date) => formatter.format(date);

DateTime dateFromString(String dateInString) => formatter.parse(dateInString);