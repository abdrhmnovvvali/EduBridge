import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/core/helpers/snackbars/snackbars.dart';
import 'package:eduroom/data/models/remote/response/student/material_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({super.key, required this.material});

  final MaterialResponse material;

  static String? _contextLine(MaterialResponse m) {
    final parts = <String>[];
    if (m.className != null && m.className!.trim().isNotEmpty) {
      parts.add(m.className!.trim());
    }
    if (m.courseName != null && m.courseName!.trim().isNotEmpty) {
      parts.add(m.courseName!.trim());
    }
    if (parts.isEmpty) return null;
    return parts.join(' · ');
  }

  Future<void> _open(BuildContext context) async {
    final target = material.openableUri;
    if (target == null || target.isEmpty) {
      Snackbars.showError('File link is not available');
      return;
    }
    final uri = Uri.parse(target);
    if (!await canLaunchUrl(uri)) {
      Snackbars.showError('Cannot open this file');
      return;
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final sub = _contextLine(material);
    final canOpen = material.openableUri != null && material.openableUri!.isNotEmpty;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.graySoft50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.graySoft100),
      ),
      child: InkWell(
        onTap: canOpen ? () => _open(context) : null,
        child: Row(
          children: [
            Icon(Icons.insert_drive_file, size: 32.r, color: AppColors.bgColor),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(material.title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  if (sub != null)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(sub, style: TextStyle(fontSize: 12.sp, color: AppColors.black300)),
                    ),
                  if (material.mimeType != null && material.mimeType!.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Text(
                        material.mimeType!,
                        style: TextStyle(fontSize: 11.sp, color: AppColors.graySoft25),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
            if (canOpen) Icon(Icons.open_in_new, size: 20.r, color: AppColors.bgColor),
          ],
        ),
      ),
    );
  }
}
