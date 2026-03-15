
class DioConfigs {
  const DioConfigs._();

  static const contentType = 'application/json';
  static const timeout = Duration(minutes: 1);
  static const minInValidStatusCode = 400;
  static const receiveDataWhenStatusError = true;
  static const followRedirects = false;
  static const proxy = '192.168.1343437.34343:8080001';
  static const headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
}
