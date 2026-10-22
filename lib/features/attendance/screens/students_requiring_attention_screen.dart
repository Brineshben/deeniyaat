import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/responsive.dart';
import '../controller/attendance_controller.dart';
import '../model/attendance_model.dart';
import 'student_attendance_summary_screen.dart';

class StudentsRequiringAttentionScreen extends StatelessWidget {
  const StudentsRequiringAttentionScreen({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),

              // Header Row (Title & Close Button)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        ' 23 students requiring attention',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryOlive,
                        ),
                      ),
                    ),
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
              ),

              SizedBox(height: 14.h),

              // Grade filter pills
              SizedBox(
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
                            color: isSelected
                                ? AppColors.primaryOlive
                                : Colors.white,
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

              SizedBox(height: 14.h),

              // Student List Container (White Card)
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
                  child: Obx(
                    () => ListView.separated(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.criticalStudents.length,
                      separatorBuilder: (context, index) => Divider(
                        color: const Color(0xFFF1F1F1),
                        height: 24.h,
                        thickness: 1,
                      ),
                      itemBuilder: (context, index) {
                        final student = controller.criticalStudents[index];
                        return _buildStudentItem(context, controller, student);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentItem(BuildContext context, AttendanceController controller,
      StudentAttentionModel student) {
    return GestureDetector(
      onTap: () {
        controller.selectStudent(student);
        Get.to(
          () => const StudentAttendanceSummaryScreen(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 280),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          // Avatar
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
                child: Icon(Icons.person, color: Colors.white, size: 22.sp),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Name and Details
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
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryOlive,
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        student.grade,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryOlive,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Flexible(
                      child: Text(
                        student.rollNo,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryOlive,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Percentage & Chevron
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${student.attendancePercentage}%',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFF92323),
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.chevron_right,
                size: 20.sp,
                color: const Color(0xFF767272),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
