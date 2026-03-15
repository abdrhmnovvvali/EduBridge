import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DateInputFormatter {
  DateInputFormatter._();

  static final dateInputFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.eager,
  );

  static String toBackendFormat(String value) {
    if (value.isEmpty || value.length < 10) return value;

    final cleaned = value.replaceAll(RegExp('[^0-9/]'), '');
    final parts = cleaned.split('/');

    if (parts.length != 3) return value;

    final day = parts[0].padLeft(2, '0');
    final month = parts[1].padLeft(2, '0');
    final year = parts[2];

    return '$year-$month-$day';
  }

  static String fromBackendFormat(String value) {
    if (value.isEmpty) return value;

    if (value.contains('/') && !value.contains('-')) {
      return value;
    }

    final parts = value.split('-');
    if (parts.length != 3) return value;

    final year = parts[0];
    final month = parts[1];
    final day = parts[2];

    return '$day/$month/$year';
  }
}
