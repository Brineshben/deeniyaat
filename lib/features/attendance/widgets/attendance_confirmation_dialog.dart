import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../controller/mark_attendance_controller.dart';

class AttendanceConfirmationDialog extends StatelessWidget {
  const AttendanceConfirmationDialog({super.key});

  static void show(BuildContext context) {
    Get.bottomSheet(
      const AttendanceConfirmationDialog(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MarkAttendanceController>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Drag handle
          Container(
            width: 44.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          SizedBox(height: 16.h),

          // Illustration
          Image.asset(
            'assets/images/attendance_confirm_illustration.png',
            height: 110.h,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.check_circle_outline_rounded,
              size: 64.sp,
              color: AppColors.primaryOlive,
            ),
          ),

          SizedBox(height: 14.h),

          // Title & Subtitle
          Text(
            'Confirm today’s attendance?',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryOlive,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Review the attendance before submitting.',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.subtitleOlive,
            ),
          ),

          SizedBox(height: 18.h),

          // Summary Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAF5),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.black.withValues(alpha: 0.06),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date
                Text(
                  '21 August 2026, Monday',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryOlive,
                  ),
                ),

                SizedBox(height: 8.h),

                // Grade & Avatar stack
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            controller.selectedGrade.value,
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                        Text(
                          'Total Students ${controller.totalCount}',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.subtitleOlive,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/images/avatar_stack.png',
                      height: 24.h,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),
                Divider(
                  color: Colors.black.withValues(alpha: 0.08),
                  height: 1,
                ),
                SizedBox(height: 12.h),

                // 4-Column Counts
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatColumn(
                      label: 'Early Arrival',
                      count: controller.earlyArrivalCount,
                      color: AppColors.statusEarlyArrival,
                    ),
                    _buildStatColumn(
                      label: 'Present',
                      count: controller.presentCount,
                      color: AppColors.statusPresent,
                    ),
                    _buildStatColumn(
                      label: 'Absent',
                      count: controller.absentCount,
                      color: AppColors.statusAbsent,
                    ),
                    _buildStatColumn(
                      label: 'Late',
                      count: controller.lateCount,
                      color: AppColors.statusLate,
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 22.h),

          // Confirm Button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () {
                Get.back(); // close dialog
                Get.snackbar(
                  'Success',
                  'Attendance for ${controller.selectedGrade.value} submitted successfully!',
                  backgroundColor: AppColors.primaryOlive,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: EdgeInsets.all(16.w),
                  borderRadius: 12.r,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.oliveButton,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(48.r),
                ),
              ),
              child: Text(
                'Confirm Submission',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 8.h),

          // Back to Mark Attendance Button
          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Back to Mark Attendance',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryOlive,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn({
    required String label,
    required int count,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.subtitleOlive,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          '$count',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}
