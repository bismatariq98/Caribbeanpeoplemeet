import 'package:intl/intl.dart';

timestampToString(date) {
  return DateFormat('d MMM yy, h:mm:a').format(date.toDate()).toString();
}
