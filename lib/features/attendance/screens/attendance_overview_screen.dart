import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/responsive.dart';
import '../../navigation/widgets/animated_bottom_nav_bar.dart';
import '../controller/attendance_controller.dart';
import '../widgets/select_class_sheet.dart';
import '../widgets/attendance_overview_by_date_sheet.dart';
import 'students_requiring_attention_screen.dart';
import 'absent_and_leave_days_screen.dart';

class AttendanceOverviewScreen extends StatelessWidget {
  const AttendanceOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AttendanceController());

    return Scaffold(
      backgroundColor: const Color(0xFFEBF6D2),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/home_screen_bg.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFEBF6D2),
                      Color(0xFFF3F9E6),
                      Color(0xFFFAFCF5),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Main Responsive Content (fits screen, no scroll)
          SafeArea(
            bottom: false,
            child: MaxWidthBox(
              maxWidth: 480,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context),
                      SizedBox(height: 12.h),
                      _buildGradeFilterPills(controller),
                      SizedBox(height: 12.h),

                      // Weekly card takes all remaining height
                      Expanded(child: _buildWeeklyInsightCard(context)),

                      SizedBox(height: 10.h),
                      _buildCriticalAttendanceInsightCard(context),
                      SizedBox(height: 10.h),
                      _buildAbsenteesCard(context),
                      SizedBox(height: 10.h),
                      _buildLeaveDataCard(context),

                      // Space reserved for floating nav bar
                      SizedBox(height: 96.h),
                    ],
                  ),

                  // Floating Animated Bottom Nav Bar
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20.h,
                    child: AnimatedBottomNavBar(
                      onTabSelected: (index) {
                        if (index == 0) {
                          Get.back();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              ' Attendance Overview',
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
            onTap: () => SelectClassSheet.show(context),
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
                'assets/icons/add_linear.svg',
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

  Widget _buildGradeFilterPills(AttendanceController controller) {
    return SizedBox(
      height: 32.h,
      child: Obx(() {
        final selectedIndex = controller.selectedGradeIndex.value;
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.grades.length,
          separatorBuilder: (context, index) => SizedBox(width: 8.w),
          itemBuilder: (context, index) {
            final isSelected = selectedIndex == index;
            final title = controller.grades[index];

            return GestureDetector(
              onTap: () => controller.selectGrade(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryOlive : Colors.white,
                  borderRadius: BorderRadius.circular(46.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : AppColors.primaryOlive,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildWeeklyInsightCard(BuildContext context) {
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
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Weekly Attendance Trend',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryOlive,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryOlive.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Average 91.2%',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryOlive,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Bar graph fills remaining card height
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Reserve room for % label, day label and gaps
                final reserved = 38.sp + 10.h;
                final maxBarHeight =
                (constraints.maxHeight - reserved).clamp(20.0, 140.h);

                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildTrendBar(context, 'Mon', 0.92, '92%', maxBarHeight),
                      _buildTrendBar(context, 'Tue', 0.88, '88%', maxBarHeight),
                      _buildTrendBar(context, 'Wed', 0.94, '94%', maxBarHeight,
                          isToday: true),
                      _buildTrendBar(context, 'Thu', 0.85, '85%', maxBarHeight),
                      _buildTrendBar(context, 'Fri', 0.90, '90%', maxBarHeight),
                      _buildTrendBar(context, 'Sat', 0.89, '89%', maxBarHeight),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendBar(
      BuildContext context,
      String day,
      double ratio,
      String percentText,
      double maxBarHeight, {
        bool isToday = false,
      }) {
    return GestureDetector(
      onTap: () => AttendanceOverviewByDateSheet.show(
        context,
        date: '$day, 21 August 2026',
      ),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            percentText,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
              color: isToday ? AppColors.primaryOlive : const Color(0xFF767272),
            ),
          ),
          SizedBox(height: 4.h),
          Container(
            width: 24.w,
            height: maxBarHeight * ratio,
            decoration: BoxDecoration(
              color: isToday ? AppColors.chartLime : AppColors.primaryOlive,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            day,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 11.sp,
              fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
              color: AppColors.primaryOlive,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCriticalAttendanceInsightCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/stars_bold.svg',
                width: 16.w,
                height: 16.w,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryOlive,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                'Attendance Insight',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryOlive,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  '23 of 78 students have critically low attendance, below 40%.',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryOlive,
                    height: 1.3,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Image.asset(
                'assets/images/avatar_stack.png',
                width: 68.w,
                height: 32.h,
                fit: BoxFit.contain,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () {
              Get.to(
                    () => const StudentsRequiringAttentionScreen(),
                transition: Transition.downToUp,
                duration: const Duration(milliseconds: 300),
              );
            },
            child: Text(
              'View students requiring attention →',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0089EB),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbsenteesCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
              () => const AbsentAndLeaveDaysScreen(),
          transition: Transition.downToUp,
          duration: const Duration(milliseconds: 300),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
        child: Row(
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: const Color(0xFFB00303),
                borderRadius: BorderRadius.circular(12.r),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/icons/close_circle_bold.svg',
                width: 16.w,
                height: 16.w,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'View absentees data →',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFD91010),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '22/52 Student absent today',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryOlive,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/avatar_stack.png',
              width: 58.w,
              height: 28.h,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveDataCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
              () => const AbsentAndLeaveDaysScreen(),
          transition: Transition.downToUp,
          duration: const Duration(milliseconds: 300),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
        child: Row(
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: const Color(0xFFB08803),
                borderRadius: BorderRadius.circular(12.r),
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/icons/slash_circle_bold.svg',
                width: 16.w,
                height: 16.w,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'View leave data →',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFF7A05),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '22/52 Student absent today',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryOlive,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/avatar_stack.png',
              width: 58.w,
              height: 28.h,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}