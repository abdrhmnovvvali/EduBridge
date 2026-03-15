import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

const _skeletonBaseColor = Color(0xFF7A96CC);
const _skeletonHighlightColor = Color(0xFFDDE7FF);

const _cardSkeletonBaseColor = Color(0xFFE8E8E8);
const _cardSkeletonHighlightColor = Color(0xFFF5F5F5);

class StudentTextSkeleton extends StatelessWidget {
  const StudentTextSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: const ShimmerEffect(
        baseColor: _skeletonBaseColor,
        highlightColor: _skeletonHighlightColor,
        duration: Duration(milliseconds: 1200),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 70.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Bone(
                      width: 150.w,
                      height: 24.h,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    SizedBox(height: 8.h),
                    Bone(
                      width: 120.w,
                      height: 14.h,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    SizedBox(height: 12.h),
                    Bone(
                      width: 140.w,
                      height: 28.h,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ],
                ),
                Bone(
                  width: 60.r,
                  height: 60.r,
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ],
            ),
          ),

          Positioned(
            top: 200.h,
            left: 20.w,
            right: 20.w,
            child: Skeletonizer(
              effect: const ShimmerEffect(
                baseColor: _cardSkeletonBaseColor,
                highlightColor: _cardSkeletonHighlightColor,
                duration: Duration(milliseconds: 1200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_SkeletonCard(), _SkeletonCard()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 163.w,
      height: 202.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      padding: EdgeInsets.only(top: 31.h, left: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Bone(
            width: 40.w,
            height: 40.h,
            borderRadius: BorderRadius.circular(8.r),
          ),
          SizedBox(height: 14.h),
          Bone(
            width: 90.w,
            height: 40.h,
            borderRadius: BorderRadius.circular(8.r),
          ),
          SizedBox(height: 8.h),
          Bone(
            width: 70.w,
            height: 16.h,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ],
      ),
    );
  }
}
