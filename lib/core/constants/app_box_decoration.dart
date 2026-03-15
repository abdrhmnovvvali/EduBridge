import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radiuses.dart';

class AppBoxDecoration {
  AppBoxDecoration._();

  static final tabBarIndicator = BoxDecoration(
    color: AppColors.primary500, // Selected tab color
    borderRadius: AppRadiuses.a24,
    boxShadow: [
      BoxShadow(
        color: const Color(0xff2F2B43).withAlpha(25),
        blurRadius: 0,
        offset: const Offset(0, -1),
      ),
      BoxShadow(
        color: const Color(0xff2F2B43).withAlpha(25),
        blurRadius: 3,
        offset: const Offset(0, 1),
      ),
    ],
  );

  static final branchItem = BoxDecoration(
    borderRadius: AppRadiuses.a16,
    border: Border.all(
      color: AppColors.graySoft100,
    ),
  );

  // static const BoxDecoration redCircleDecoration = BoxDecoration(
  //   color: Colors.red,
  //   shape: BoxShape.circle,
  // );

  // static final BoxDecoration blackBrC6Decoration = BoxDecoration(
  //   color: Colors.black.withOpacity(0.6),
  //   borderRadius: AppRadiuses.c6,
  // );

  // static final BoxDecoration transparentBrC2Decoration = BoxDecoration(
  //   color: Colors.transparent,
  //   borderRadius: AppRadiuses.borderRadiusC2,
  // );

  // static const BoxDecoration whiteBrA12WithShadowDecoration = BoxDecoration(
  //   color: AppColors.white,
  //   borderRadius: AppRadiuses.a12,
  //   boxShadow: [
  //     BoxShadow(
  //       color: AppColors.whiteSmoke,
  //       offset: Offset(-1, 1),
  //       blurRadius: 24,
  //       spreadRadius: 2,
  //     ),
  //   ],
  // );

  // static final greyLanguageBox = BoxDecoration(
  //   color: AppColors.white,
  //   borderRadius: AppRadiuses.a12,
  //   border: Border.all(
  //     color: AppColors.simpleGrey,
  //   ),
  // );

  // static final partnerItemBoxes = BoxDecoration(
  //     color: AppColors.white,
  //     borderRadius: AppRadiuses.a4,
  //     boxShadow: [
  //       BoxShadow(
  //           offset: const Offset(0, 4),
  //           blurRadius: 10,
  //           color: AppColors.black.withOpacity(0.04))
  //     ]);

  // static final partnerOfferBox = BoxDecoration(
  //   color: AppColors.white,
  //   borderRadius: AppRadiuses.a12,
  //   boxShadow: [
  //     BoxShadow(
  //       offset: const Offset(0, 4),
  //       blurRadius: 10,
  //       spreadRadius: 0,
  //       color: AppColors.black.withOpacity(0.1),
  //     )
  //   ],
  // );

  // static final shadowedBox = BoxDecoration(
  //   boxShadow: [
  //     BoxShadow(
  //       color: AppColors.black.withOpacity(0.1),
  //       offset: const Offset(4, 4),
  //       blurRadius: 20,
  //       spreadRadius: 0,
  //     ),
  //   ],
  // );

  // static const pictureBox = BoxDecoration(
  //   color: AppColors.lightSilver,
  //   borderRadius: AppRadiuses.a8,
  // );

  // static final profilePhoto = BoxDecoration(
  //     border: Border.all(color: AppColors.primary, width: 2.r),
  //     borderRadius: AppRadiuses.a100);

  // static final infoBackGrounBox = BoxDecoration(
  //   color: AppColors.white,
  //   borderRadius: AppRadiuses.a8,
  //   boxShadow: [
  //     BoxShadow(
  //       color: AppColors.black.withOpacity(0.1),
  //       offset: const Offset(4, 4),
  //       blurRadius: 10,
  //       spreadRadius: 0,
  //     ),
  //   ],
  // );

  // static final choosenCouponNavBar = shadowedBox.copyWith(
  //   borderRadius: AppRadiuses.a8,
  //   color: AppColors.white,
  // );
  // static final couponNavBar = shadowedBox.copyWith(
  //   borderRadius: AppRadiuses.a8,
  //   color: AppColors.water,
  // );

  // static final listTile = shadowedBox.copyWith(
  //   color: AppColors.white,
  //   borderRadius: AppRadiuses.a12,
  // );
  // static final appBarItem = listTile.copyWith(
  //   borderRadius: AppRadiuses.a50,
  // );
  // static const partnerTitleBox = BoxDecoration(
  //   color: AppColors.antiFlashWhite,
  //   borderRadius: AppRadiuses.a50,
  // );
  // static final helpItem = BoxDecoration(
  //   color: AppColors.white,
  //   border: Border.all(color: AppColors.lightSilver),
  //   borderRadius: AppRadiuses.a12,
  // );
  // static final successAndErrorBottomSheet = BoxDecoration(
  //   borderRadius: AppRadiuses.tl24tr24,
  //   color: AppColors.white,
  //   boxShadow: [
  //     BoxShadow(
  //       color: AppColors.black.withOpacity(0.1),
  //       blurRadius: 20,
  //       offset: const Offset(0, 0),
  //       spreadRadius: 0,
  //     )
  //   ],
  // );
  // static final barcodeBonusBox = shadowedBox.copyWith(
  //   color: AppColors.brightGray,
  //   borderRadius: BorderRadius.circular(10),
  // );
  // static const offerBox = BoxDecoration(
  //   color: AppColors.antiFlashWhite,
  //   borderRadius: AppRadiuses.a8,
  // );

  // static final branchListItem = BoxDecoration(
  //   border: Border.all(
  //     color: AppColors.primary.withOpacity(
  //       0.1,
  //     ),
  //   ),
  //   color: AppColors.white,
  //   borderRadius: AppRadiuses.a8,
  // );

  // static final branchCard = shadowedBox.copyWith(
  //     borderRadius: AppRadiuses.a8, color: AppColors.white);

  // static final couponStatus = BoxDecoration(
  //   borderRadius: AppRadiuses.a8,
  //   boxShadow: [
  //     BoxShadow(
  //       color: AppColors.black.withOpacity(0.1),
  //       spreadRadius: 0,
  //       blurRadius: 20,
  //       offset: const Offset(4, 4),
  //     ),
  //   ],
  // );

  // static const couponBox = BoxDecoration(
  //   borderRadius: AppRadiuses.a8,
  //   boxShadow: [
  //     BoxShadow(
  //       color: AppColors.shadowColor,
  //       spreadRadius: 0,
  //       blurRadius: 20,
  //       offset: Offset(4, 4),
  //     ),
  //   ],
  // );

  // static final notificationBar = BoxDecoration(
  //   borderRadius: AppRadiuses.a8,
  //   boxShadow: [
  //     BoxShadow(
  //       color: Color.fromRGBO(0, 0, 0, 0.1),
  //       spreadRadius: 0,
  //       blurRadius: 5,
  //       offset: const Offset(0, 2),
  //     )
  //   ],
  // );

  // static final childItem = BoxDecoration(
  //   borderRadius: AppRadiuses.a15,
  //   border: Border.all(
  //     color: AppColors.primary,
  //   ),

  // );
}
