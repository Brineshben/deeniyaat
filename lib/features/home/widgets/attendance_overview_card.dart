import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/colors.dart';
import '../model/home_data_model.dart';

class AttendanceOverviewCard extends StatelessWidget {
  final int presentStudents;
  final int totalStudents;
  final int performancePercentage;
  final List<DayAttendanceModel> weeklyAttendance;
  final VoidCallback? onTap;

  const AttendanceOverviewCard({
    super.key,
    required this.presentStudents,
    required this.totalStudents,
    required this.performancePercentage,
    required this.weeklyAttendance,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Row: Attendance Overview Today & Working day
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/documents_bold.svg',
                        width: 14.w,
                        height: 14.w,
                        colorFilter: const ColorFilter.mode(
                          AppColors.primaryOlive,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          'Attendance Overview Today',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryOlive,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    'Working day',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryOlive,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // Content Row: Left stats & Right weekly bar chart
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Left Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$presentStudents Students Present',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryOlive,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Total $totalStudents students',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.subtitleOlive,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/course_up_bold.svg',
                            width: 16.w,
                            height: 16.w,
                            colorFilter: const ColorFilter.mode(
                              AppColors.performanceGreen,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              '$performancePercentage% attendance performance',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.performanceGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Right Weekly Bar Chart (Figma Frame 1686558238)
                SizedBox(
                  width: 114.w,
                  height: 68.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: weeklyAttendance.map((dayItem) {
                      return _buildDayBar(dayItem);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayBar(DayAttendanceModel item) {
    Color barColor;
    double opacity = 1.0;

    if (item.isToday) {
      // Highlighted day (Wednesday)
      barColor = AppColors.chartLime;
    } else if (item.isCompleted) {
      // Past completed days (M, T)
      barColor = AppColors.chartPastBar;
    } else {
      // Future days (T, F, S)
      barColor = AppColors.chartFutureBar;
      opacity = 0.4;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Bar
        Container(
          width: 12.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: barColor.withValues(alpha: opacity),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),

        // Day Letter
        Text(
          item.day,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: item.isFuture
                ? AppColors.primaryOlive.withValues(alpha: 0.5)
                : AppColors.primaryOlive,
          ),
        ),
      ],
    );
  }
}
