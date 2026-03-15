import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneInputFormatter {
  PhoneInputFormatter._();


  static final phoneInputFormatter = MaskTextInputFormatter(
    mask: '## ### ## ##',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static String unMask(String value) {
    String result = value.replaceAll(RegExp('[^0-9+]'), '');
    return result;
  }

  static String fromBackendFormat(String value) {
    if (value.isEmpty) return value;

    String cleaned = value.replaceAll(RegExp('[^0-9]'), '');

    if (cleaned.startsWith('994') && cleaned.length >= 12) {
      cleaned = cleaned.substring(3);
    } else if (cleaned.startsWith('+994') && cleaned.length >= 13) {
      cleaned = cleaned.substring(4);
    }

    if (cleaned.length >= 9) {
      final part1 = cleaned.substring(0, 2);
      final part2 = cleaned.substring(2, 5);
      final part3 = cleaned.substring(5, 7);
      final part4 = cleaned.substring(7, 9);
      return '$part1 $part2 $part3 $part4';
    } else if (cleaned.length >= 7) {
      final part1 = cleaned.substring(0, 2);
      final part2 = cleaned.substring(2, 5);
      final part3 = cleaned.substring(5, 7);
      return '$part1 $part2 $part3';
    } else if (cleaned.length >= 5) {
      final part1 = cleaned.substring(0, 2);
      final part2 = cleaned.substring(2, 5);
      return '$part1 $part2';
    } else if (cleaned.length >= 2) {
      return cleaned.substring(0, 2);
    }

    return cleaned;
  }
}
