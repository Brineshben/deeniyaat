import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/responsive.dart';
import '../controller/attendance_controller.dart';
import '../model/attendance_model.dart';

class AbsentAndLeaveDaysScreen extends StatelessWidget {
  const AbsentAndLeaveDaysScreen({super.key});

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

              // Header
              _buildTopBar(),

              SizedBox(height: 12.h),

              // Student Header
              _buildStudentHeader(controller),

              SizedBox(height: 12.h),

              // Month Filter Pills
              _buildMonthFilterPills(controller),

              SizedBox(height: 14.h),

              // List Container
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 16,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'May 2026',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryOlive,
                              ),
                            ),
                            Row(
                              children: [
                                _buildMiniBadge(
                                  label: '3 Absent ',
                                  iconPath: 'assets/icons/close_circle_bold.svg',
                                  bgColor: const Color(0xFFB00303),
                                ),
                                SizedBox(width: 8.w),
                                _buildMiniBadge(
                                  label: '2 Leave ',
                                  iconPath: 'assets/icons/slash_circle_bold.svg',
                                  bgColor: const Color(0xFFB04B03),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Color(0xFFF1F1F1),
                        height: 1,
                        thickness: 1,
                      ),
                      Expanded(
                        child: Obx(
                          () => ListView.separated(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                            physics: const BouncingScrollPhysics(),
                            itemCount: controller.mayAbsentLeaveDays.length,
                            separatorBuilder: (context, index) => Divider(
                              color: const Color(0xFFF1F1F1),
                              height: 20.h,
                              thickness: 1,
                            ),
                            itemBuilder: (context, index) {
                              final item = controller.mayAbsentLeaveDays[index];
                              return _buildRecordRow(item);
                            },
                          ),
                        ),
                      ),
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
              'absent & leave days',
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

  Widget _buildStudentHeader(AttendanceController controller) {
    return Obx(() {
      final student = controller.selectedStudent.value;

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                student.avatarPath,
                width: 40.w,
                height: 40.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 40.w,
                  height: 40.w,
                  color: Colors.grey.shade300,
                  child: Icon(Icons.person, color: Colors.white, size: 20.sp),
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
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryOlive,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        student.rollNo,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 10.sp,
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

  Widget _buildMonthFilterPills(AttendanceController controller) {
    return SizedBox(
      height: 32.h,
      child: Obx(() {
        final selectedMonth = controller.selectedMonthIndex.value;
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.months.length,
          separatorBuilder: (context, index) => SizedBox(width: 6.w),
          itemBuilder: (context, index) {
            final isSelected = selectedMonth == index;
            final month = controller.months[index];

            return GestureDetector(
              onTap: () => controller.selectMonth(index),
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
                  month,
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

  Widget _buildMiniBadge({
    required String label,
    required String iconPath,
    required Color bgColor,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14.w,
          height: 14.w,
          decoration: BoxDecoration(
            color: bgColor,
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
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF32361B),
          ),
        ),
      ],
    );
  }

  Widget _buildRecordRow(DayAttendanceRecord record) {
    final isAbsent = record.status == AttendanceStatus.absent;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: isAbsent
                        ? const Color(0xFFB00303)
                        : const Color(0xFFB04B03),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    isAbsent
                        ? 'assets/icons/close_circle_bold.svg'
                        : 'assets/icons/slash_circle_bold.svg',
                    width: 14.w,
                    height: 14.w,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.dateFormatted,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryOlive,
                        ),
                      ),
                      if (record.leaveReason != null) ...[
                        SizedBox(height: 2.h),
                        Text(
                          record.leaveReason!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF8E8D8C),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            isAbsent ? 'Absent' : 'Leave',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: isAbsent
                  ? const Color(0xFFD91010)
                  : const Color(0xFFEB6200),
            ),
          ),
        ],
      ),
    );
  }
}
