import 'package:flutter/material.dart';

import '../formatters/phone_input_formatter.dart';

extension StringExtensions on String? {
  String get name => this!.split('/').last.split('.').first;

  String get capitalizeFirstLetter =>
      '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}';

  bool get isEmptyOrNull => this == null || this!.isEmpty;

  bool get isNotEmptyOrNull => this != null && this!.isNotEmpty;

  String get unMaskPhone => PhoneInputFormatter.unMask(this!);

  String get toInternationalFormat {
    if (this!.startsWith('0')) {
      return '+994${this!.substring(1)}';
    }
    return this!;
  }

  String get toLocalPhoneFormat {
    if (this!.startsWith('+994')) {
      return this!.replaceFirst('+994', '0');
    }
    return this!;
  }

  String get prefix => toLocalPhoneFormat.substring(0, 3);

  String get mainNumber => toLocalPhoneFormat.substring(3);



  String get abbreviation {
    
    /// the result that will be returned
    var result = '';

    /// checking null process before the modification
    if (isEmptyOrNull) {
      return result;
    }

    /// Split our string into words
    final words = this!.split(' ');

    if (words.isEmpty) return result;

    /// Get words' first characters
    for (var i = 0; i < words.length && i < 2; i++) {
      if (words[i].isNotEmpty) {
        result += words[i][0];
      }
    }

    return result.toUpperCase();
  }
}

