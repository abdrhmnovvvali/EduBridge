import '../formatters/phone_input_formatter.dart';

extension ValidatorExtensions on String {
  bool get isValidEmail {
    const pattern =
        r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    return regex.hasMatch(this);
  }

  bool get isValidPassword {
    const pattern = r'^(?=.*[A-Za-z])(?=.*\d).{8,}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(this);
  }

  bool get isValidPhone => PhoneInputFormatter.phoneInputFormatter.isFill();

  bool get isValidLinkedinUrl {
    const pattern =
        r'^(https?:\/\/)?(www\.)?linkedin\.com\/[A-Za-z0-9-]+(\/[A-Za-z0-9_-]+)*(\/?\?[A-Za-z0-9=&_-]+)?\/?$';
    final regExp = RegExp(pattern, caseSensitive: false);
    return regExp.hasMatch(this);
  }

  bool get isValidGithubUrl {
    const pattern = r'^(https?:\/\/)?(www\.)?github\.com\/[A-Za-z0-9_-]+?\/?$';
    final regExp = RegExp(pattern, caseSensitive: false);
    return regExp.hasMatch(this);
  }
}
