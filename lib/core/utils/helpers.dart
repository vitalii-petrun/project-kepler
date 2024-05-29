import 'package:intl/intl.dart';

// Helper function to format the date and time
String formatDateTime(DateTime dateTime) {
  final formatter = DateFormat('EEEE, MMMM d, h:mm a');
  return formatter.format(dateTime);
}
