import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

import '../helpers/logger.dart';

abstract class UrlLauncherService {
  // Future<void> openWhatsapp(String phone);
  Future<void> openWeb(String link);
  Future<void> openFacebook(String link);
  Future<void> openYoutube(String link);
  Future<void> openInstagram(String link);
  Future<void> openLinkedin(String link);
}

class UrlLauncherServiceImpl implements UrlLauncherService {
  @override
  Future<void> openFacebook(String link) async {
    try {
      final url = Uri.parse(link);
      await launchUrl(url);
    } catch (e, s) {
      log.error(e.toString());
      log.error(s.toString());
    }
  }

  @override
  Future<void> openInstagram(String link) async {
    try {
      final url = Uri.parse(link);
      await launchUrl(url);
    } catch (e, s) {
      log.error(e.toString());
      log.error(s.toString());
    }
  }

  @override
  Future<void> openWeb(String link) async {
    try {
      final url = Uri.parse(link);
      await launchUrl(url);
    } catch (e, s) {
      log.error(e.toString());
      log.error(s.toString());
    }
  }

  // @override
  // Future<void> openWhatsapp(String phone) async {
  //   try {
  //     final androidUrl = '${Endpoints.whatsappAndroidUrl}$phone';
  //     final iosUrl = '${Endpoints.whatsappIOSUrl}$phone';
  //     final url = Uri.parse(Platform.isIOS ? iosUrl : androidUrl);
  //     await launchUrl(url);
  //   } catch (e, s) {
  //     log.error(e.toString());
  //     log.error(s.toString());
  //   }
  // }

  @override
  Future<void> openLinkedin(String link) async {
    try {
      final url = Uri.parse(link);
      await launchUrl(url);
    } catch (e, s) {
      log.error(e.toString());
      log.error(s.toString());
    }
  }

  @override
  Future<void> openYoutube(String link) async {
    try {
      final url = Uri.parse(link);
      await launchUrl(url);
    } catch (e, s) {
      log.error(e.toString());
      log.error(s.toString());
    }
  }
}
