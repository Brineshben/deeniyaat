import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../controller/attendance_controller.dart';

class AttendanceOverviewByDateSheet extends StatelessWidget {
  final String dateTitle;

  const AttendanceOverviewByDateSheet({
    super.key,
    this.dateTitle = '01 October 2026',
  });

  static void show(BuildContext context, {String date = '01 October 2026'}) {
    Get.bottomSheet(
      AttendanceOverviewByDateSheet(dateTitle: date),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final attendanceController = Get.isRegistered<AttendanceController>()
        ? Get.find<AttendanceController>()
        : Get.put(AttendanceController());

    return Container(
      constraints: BoxConstraints(
        maxHeight: 0.88.sh,
      ),
      decoration: BoxDecoration(
        color: AppColors.sheetBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Padding(
            padding: EdgeInsets.only(top: 12.h, bottom: 8.h),
            child: Container(
              width: 44.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Row(
              children: [
                Text(
                  dateTitle,
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
          ),

          // Grade Filter Pills
          SizedBox(
            height: 38.h,
            child: Obx(() {
              final selectedGradeIdx =
                  attendanceController.selectedGradeIndex.value;
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: attendanceController.grades.length,
                separatorBuilder: (context, index) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  final isSelected = selectedGradeIdx == index;
                  return GestureDetector(
                    onTap: () => attendanceController.selectGrade(index),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryOlive
                            : Colors.white,
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryOlive
                              : Colors.black.withValues(alpha: 0.06),
                        ),
                      ),
                      child: Text(
                        attendanceController.grades[index],
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : AppColors.primaryOlive,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          SizedBox(height: 12.h),

          // Overall Performance Card
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.06),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '94%',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryOlive,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Overall performance',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                          Text(
                            'from total students of 42',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.subtitleOlive,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Status chips row
                  Wrap(
                    spacing: 6.w,
                    runSpacing: 6.h,
                    children: [
                      _buildCountBadge('22 Present', AppColors.statusPresent),
                      _buildCountBadge('2 Early Arrivals', AppColors.statusEarlyArrival),
                      _buildCountBadge('2 Absentees', AppColors.statusAbsent),
                      _buildCountBadge('1 Late', AppColors.statusLate),
                      _buildCountBadge('2 Leaves', const Color(0xFF8A7A96)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Student Attendance List for Date
          Expanded(
            child: Obx(() {
              final students = attendanceController.criticalStudents;
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.06),
                  ),
                ),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  itemCount: students.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.black.withValues(alpha: 0.06),
                    height: 14.h,
                  ),
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18.r),
                          child: Image.asset(
                            student.avatarPath,
                            width: 36.w,
                            height: 36.h,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 36.w,
                              height: 36.h,
                              color: AppColors.primaryOlive.withValues(alpha: 0.1),
                              child: Center(
                                child: Text(
                                  student.name[0],
                                  style: const TextStyle(
                                    fontFamily: 'Manrope',
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryOlive,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textDark,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                '${student.grade}  •  ${student.rollNo}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.subtitleOlive,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${student.attendancePercentage}%',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: student.attendancePercentage < 40
                                ? AppColors.outstandingRed
                                : AppColors.primaryOlive,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }),
          ),

          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildCountBadge(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
