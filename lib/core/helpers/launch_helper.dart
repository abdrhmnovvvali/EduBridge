import 'package:url_launcher/url_launcher.dart';

abstract class LaunchHelper {
  static Future<void> launchLink(String? url) async {
    if (url == null || url.isEmpty) return;
    return _launch(url);
  }

  static Future<void> _launch(String uriValue) async {
    try {
      final uri = Uri.parse(uriValue);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }
}
