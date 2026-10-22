import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/responsive.dart';
import '../controller/attendance_controller.dart';
import '../model/attendance_model.dart';
import 'absent_and_leave_days_screen.dart';

class StudentAttendanceSummaryScreen extends StatelessWidget {
  const StudentAttendanceSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AttendanceController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F4E8),
      body: SafeArea(
        bottom: false,
        child: MaxWidthBox(
          maxWidth: 480,
          child: Column(
            children: [
              SizedBox(height: 12.h),

              // Top Bar (Back Button, Title, Close Button)
              _buildTopBar(),

              SizedBox(height: 14.h),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // Student Profile Info Row
                      _buildStudentProfileHeader(controller),

                      SizedBox(height: 14.h),

                      // Overall Attendance Performance Card
                      _buildOverallPerformanceCard(context, controller),

                      SizedBox(height: 14.h),

                      // Monthly Calendar Card (October 2026)
                      _buildMonthlyCalendarCard(controller),

                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/icons/arrow_left_linear.svg',
                width: 18.w,
                height: 18.w,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryOlive,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Student Attendance Summary',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryOlive,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/icons/close_linear.svg',
                width: 18.w,
                height: 18.w,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryOlive,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentProfileHeader(AttendanceController controller) {
    return Obx(() {
      final student = controller.selectedStudent.value;

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                student.avatarPath,
                width: 44.w,
                height: 44.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 44.w,
                  height: 44.w,
                  color: Colors.grey.shade300,
                  child: Icon(Icons.person, color: Colors.white, size: 24.sp),
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
                      color: AppColors.primaryOlive,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        student.grade,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryOlive,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        student.rollNo,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryOlive,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildOverallPerformanceCard(
      BuildContext context, AttendanceController controller) {
    return Container(
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
        children: [
          // Header & Percentage with Gauge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/stars_bold.svg',
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
                            'Overall Attendance Performance',
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
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/course_up_bold.svg',
                          width: 16.w,
                          height: 16.w,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFFD91010),
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '23.7%',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFD91010),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),

              // Circular Gauge Indicator
              SizedBox(
                width: 54.w,
                height: 54.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: 0.237,
                      strokeWidth: 6.w,
                      backgroundColor: const Color(0xFFF0F0F0),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFFD91010),
                      ),
                    ),
                    Text(
                      '23%',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFD91010),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // Total Working Days & 4 Status Pills
          Text(
            'Total Working Days 42',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryOlive,
            ),
          ),
          SizedBox(height: 8.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: _buildStatusItem(
                  label: '22 Present',
                  iconPath: 'assets/icons/check_circle_bold.svg',
                  badgeColor: const Color(0xFF03B016),
                ),
              ),
              Flexible(
                child: _buildStatusItem(
                  label: '4 Absent',
                  iconPath: 'assets/icons/close_circle_bold.svg',
                  badgeColor: const Color(0xFFB00303),
                ),
              ),
              Flexible(
                child: _buildStatusItem(
                  label: '1 Late',
                  iconPath: 'assets/icons/danger_circle_bold.svg',
                  badgeColor: const Color(0xFF0390B0),
                ),
              ),
              Flexible(
                child: _buildStatusItem(
                  label: '1 Leave',
                  iconPath: 'assets/icons/slash_circle_bold.svg',
                  badgeColor: const Color(0xFFB04B03),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Footer link
          GestureDetector(
            onTap: () {
              Get.to(
                () => const AbsentAndLeaveDaysScreen(),
                transition: Transition.rightToLeft,
                duration: const Duration(milliseconds: 280),
              );
            },
            child: Text(
              'View absent & leave days →',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFF7A05),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem({
    required String label,
    required String iconPath,
    required Color badgeColor,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14.w,
          height: 14.w,
          decoration: BoxDecoration(
            color: badgeColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            iconPath,
            width: 8.w,
            height: 8.w,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF32361B),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlyCalendarCard(AttendanceController controller) {
    final daysOfWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Container(
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
        children: [
          Text(
            'October 2026',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF161716),
            ),
          ),
          SizedBox(height: 10.h),

          // Summary pill banner
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE2E2),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total working days: 24',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF1C1C1C),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '20 present · 4 absent · 1 late',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF313131),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '23.7%',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFD91010),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Days of week row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: daysOfWeek
                .map(
                  (day) => SizedBox(
                    width: 32.w,
                    child: Text(
                      day,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryOlive,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),

          SizedBox(height: 10.h),

          // Calendar Grid (31 days of October 2026, starts on Thursday)
          _buildCalendarGrid(controller),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(AttendanceController controller) {
    // Oct 1 2026 is Thursday (Index 4: S=0, M=1, T=2, W=3, T=4, F=5, S=6)
    final daysInMonth = 31;
    final startDayOffset = 4;
    final totalCells = ((daysInMonth + startDayOffset) / 7).ceil() * 7;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: totalCells,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        if (index < startDayOffset || index >= startDayOffset + daysInMonth) {
          return const SizedBox.shrink();
        }

        final dayNum = index - startDayOffset + 1;
        final dayOfWeek = index % 7;
        final isWeekend = dayOfWeek == 0 || dayOfWeek == 6;

        // Status for student
        AttendanceStatus status = AttendanceStatus.present;
        if (isWeekend) {
          status = AttendanceStatus.off;
        } else if (dayNum == 2 || dayNum == 9 || dayNum == 16 || dayNum == 23) {
          status = AttendanceStatus.absent;
        } else if (dayNum == 7) {
          status = AttendanceStatus.late;
        } else if (dayNum == 13) {
          status = AttendanceStatus.leave;
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$dayNum',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: isWeekend
                    ? const Color(0xFF8E8D8C)
                    : AppColors.primaryOlive,
              ),
            ),
            SizedBox(height: 3.h),
            _buildCalendarStatusBadge(status),
          ],
        );
      },
    );
  }

  Widget _buildCalendarStatusBadge(AttendanceStatus status) {
    if (status == AttendanceStatus.off) {
      return SizedBox(height: 18.w);
    }

    Color color;
    String icon;

    switch (status) {
      case AttendanceStatus.present:
        color = const Color(0xFF03B016);
        icon = 'assets/icons/check_circle_bold.svg';
        break;
      case AttendanceStatus.absent:
        color = const Color(0xFFB00303);
        icon = 'assets/icons/close_circle_bold.svg';
        break;
      case AttendanceStatus.late:
        color = const Color(0xFF0390B0);
        icon = 'assets/icons/danger_circle_bold.svg';
        break;
      case AttendanceStatus.leave:
        color = const Color(0xFFB04B03);
        icon = 'assets/icons/slash_circle_bold.svg';
        break;
      default:
        return SizedBox(height: 18.w);
    }

    return Container(
      width: 18.w,
      height: 18.w,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        icon,
        width: 10.w,
        height: 10.w,
        colorFilter: const ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
