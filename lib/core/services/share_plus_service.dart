import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class SharePlusService {
  Future<void> shareNetworkImageWithLink(String imageUrl, String link) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/shared_image.jpg';

      // 1. Download image with Dio
      final dio = Dio();
      await dio.download(imageUrl, filePath);

      // 2. Share image
      final shareParams = ShareParams(
        text: link,
        files: [XFile(filePath)],
      );
      await SharePlus.instance.share(shareParams);

      // 3. Delete file after sharing
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Error sharing image: $e');
    }
  }
}
