import 'package:eduroom/core/constants/app_colors.dart';
import 'package:eduroom/data/models/remote/response/student/material_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({super.key, required this.material});

  final MaterialResponse material;

  @override
  Widget build(BuildContext context) {
    final hasLink = material.linkUrl != null && material.linkUrl!.isNotEmpty;
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.graySoft50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.graySoft100),
      ),
      child: InkWell(
        onTap: hasLink ? () => launchUrl(Uri.parse(material.linkUrl!)) : null,
        child: Row(
          children: [
            Icon(hasLink ? Icons.link : Icons.description, size: 32.r, color: AppColors.bgColor),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(material.title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  if (material.className != null)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(material.className!, style: TextStyle(fontSize: 12.sp, color: AppColors.black300)),
                    ),
                ],
              ),
            ),
            if (hasLink) Icon(Icons.open_in_new, size: 20.r, color: AppColors.bgColor),
          ],
        ),
      ),
    );
  }
}
