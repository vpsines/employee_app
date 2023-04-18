import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat('d MMMM y');
final DateFormat formatter2 = DateFormat('d MMMM, y');

String dateToString(DateTime date) => formatter.format(date);

String dateToString2(DateTime date) => formatter2.format(date);

DateTime dateFromString(String dateInString) => formatter.parse(dateInString);
