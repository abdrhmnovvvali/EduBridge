import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get formattedDate => DateFormat('dd.MM.yyyy').format(this);
}

extension StringDateTimeExtension on String {
  DateTime get toDate => DateFormat('dd.MM.yyyy').parse(this);
}

extension RelativeTimeFormatting on DateTime {
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 0) {
      return '${difference.inDays} gün əvvəl';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} saat əvvəl';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} dəqiqə əvvəl';
    } else {
      return 'İndi';
    }
  }
}
