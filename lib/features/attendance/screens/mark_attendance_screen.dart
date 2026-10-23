import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../controller/mark_attendance_controller.dart';
import '../widgets/attendance_confirmation_dialog.dart';
import '../widgets/mark_attendance_item.dart';

class MarkAttendanceScreen extends StatelessWidget {
  const MarkAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MarkAttendanceController());

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

          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Navigation Bar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black.withValues(alpha: 0.06),
                            ),
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
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                controller.selectedGrade.value,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.subtitleOlive,
                                ),
                              ),
                            ),
                            Text(
                              'Mark attendance',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryOlive,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8.h),

                // Search Bar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        color: Colors.black.withValues(alpha: 0.06),
                      ),
                    ),
                    child: TextField(
                      controller: controller.searchController,
                      onChanged: (val) => controller.searchQuery.value = val,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 14.sp,
                        color: AppColors.textDark,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search students',
                        hintStyle: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 14.sp,
                          color: AppColors.textMuted,
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: SvgPicture.asset(
                            'assets/icons/search_linear.svg',
                            width: 16.w,
                            height: 16.h,
                            colorFilter: const ColorFilter.mode(
                              AppColors.subtitleOlive,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 14.h),

                // Total students and "Mark all present" button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => Text(
                            '${controller.filteredStudents.length} students',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryOlive,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: controller.markAllPresent,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: AppColors.primaryOlive
                                  .withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/check_mark_icon.svg',
                                width: 13.w,
                                height: 13.h,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.primaryOlive,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Mark all present',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryOlive,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 12.h),

                // Students List
                Expanded(
                  child: Obx(
                    () => ListView.separated(
                      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 140.h),
                      itemCount: controller.filteredStudents.length,
                      separatorBuilder: (context, index) => SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        final student = controller.filteredStudents[index];
                        return MarkAttendanceItem(
                          student: student,
                          onStatusChanged: (newStatus) {
                            controller.updateStudentStatus(student.id, newStatus);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Fixed Legend and Submit Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 24.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Legend Row with counts
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildLegendDot(
                            label: 'Early Arrival',
                            code: 'EA',
                            count: controller.earlyArrivalCount,
                            color: AppColors.statusEarlyArrival,
                          ),
                          _buildLegendDot(
                            label: 'Present',
                            code: 'P',
                            count: controller.presentCount,
                            color: AppColors.oliveButton,
                          ),
                          _buildLegendDot(
                            label: 'Absent',
                            code: 'A',
                            count: controller.absentCount,
                            color: AppColors.statusAbsent,
                          ),
                          _buildLegendDot(
                            label: 'Late',
                            code: 'L',
                            count: controller.lateCount,
                            color: AppColors.statusLate,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 14.h),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () => AttendanceConfirmationDialog.show(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.oliveButton,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(48.r),
                          ),
                        ),
                        child: Text(
                          'Submit Attendance',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
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

  Widget _buildLegendDot({
    required String label,
    required String code,
    required int count,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          '$code: $count',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}
