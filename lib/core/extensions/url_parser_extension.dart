extension UrlParser on String {
  String toParsedUrl({String host = '192.168.0.181'}) {
    if (contains('localhost')) {
      return replaceAll('localhost', host);
    }
    return this;
  }
}
