import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../routes/app_routes.dart';
import '../controller/mark_attendance_controller.dart';
import '../model/mark_attendance_model.dart';

class SelectClassScreen extends StatelessWidget {
  const SelectClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<MarkAttendanceController>()
        ? Get.find<MarkAttendanceController>()
        : Get.put(MarkAttendanceController());

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/home_screen_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          // Underneath Content (Simulating attendance overview screen)
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/arrow_left_linear.svg',
                            width: 18.w,
                            height: 18.h,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primaryOlive,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Text(
                          'Attendance Overview',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryOlive,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Dim Backdrop
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
          ),

          // Bottom Sheet Panel (Figma 199:13703)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.sheetBg,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.r),
                  topRight: Radius.circular(28.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 36.h),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drag handle
                    Center(
                      child: Container(
                        width: 44.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),

                    SizedBox(height: 18.h),

                    // Header
                    Row(
                      children: [
                        Text(
                          'Select Grade',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryOlive,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black.withValues(alpha: 0.08),
                              ),
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              size: 18.sp,
                              color: AppColors.primaryOlive,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 18.h),

                    // Class Cards
                    Obx(
                      () => Column(
                        children: controller.gradeOptions.map((option) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: _buildClassCard(option, controller),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassCard(
    ClassGradeOptionModel option,
    MarkAttendanceController controller,
  ) {
    return GestureDetector(
      onTap: () {
        controller.selectGrade(option.grade);
        Get.offNamed(AppRoutes.markAttendance);
      },
      child: Container(
        width: double.infinity,
        height: 80.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.06),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            children: [
              // Decorative background
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: 120.w,
                child: Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    option.bgImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          option.grade,
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryOlive,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          option.time,
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.subtitleOlive,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryOlive.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14.sp,
                        color: AppColors.primaryOlive,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
