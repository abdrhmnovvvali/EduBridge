extension IntExtensions on int? {
  bool get isSuccess => this != null && this! > 199 && this! < 300;
  bool get isUnauthorized => this == 403 || this == 401;
  bool get isNotFound => this == 404;

  String get toMinute => (this! ~/ 60).toString().padLeft(2, '0');
  String get toSeconds => (this! % 60).toString().padLeft(2, '0');
}
