import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/colors.dart';
import '../model/mark_attendance_model.dart';

class MarkAttendanceItem extends StatelessWidget {
  final StudentAttendanceItemModel student;
  final Function(StudentMarkStatus) onStatusChanged;

  const MarkAttendanceItem({
    super.key,
    required this.student,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Student Avatar
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.asset(
              student.avatarUrl,
              width: 40.w,
              height: 40.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 40.w,
                height: 40.h,
                color: AppColors.primaryOlive.withValues(alpha: 0.1),
                child: Center(
                  child: Text(
                    student.name.isNotEmpty ? student.name[0] : 'S',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryOlive,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Name and Roll
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
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  student.rollNo,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.subtitleOlive,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          // Status Selector or On Leave Badge
          if (student.isOnLeave)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4E5),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: const Color(0xFFFFD599),
                ),
              ),
              child: Text(
                'On leave',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFD46B08),
                ),
              ),
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildStatusButton(
                  label: 'EA',
                  status: StudentMarkStatus.earlyArrival,
                  activeColor: AppColors.statusEarlyArrival,
                ),
                SizedBox(width: 6.w),
                _buildStatusButton(
                  label: 'P',
                  status: StudentMarkStatus.present,
                  activeColor: AppColors.oliveButton,
                ),
                SizedBox(width: 6.w),
                _buildStatusButton(
                  label: 'A',
                  status: StudentMarkStatus.absent,
                  activeColor: AppColors.statusAbsent,
                ),
                SizedBox(width: 6.w),
                _buildStatusButton(
                  label: 'L',
                  status: StudentMarkStatus.late,
                  activeColor: AppColors.statusLate,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildStatusButton({
    required String label,
    required StudentMarkStatus status,
    required Color activeColor,
  }) {
    final isSelected = student.status == status;

    return GestureDetector(
      onTap: () => onStatusChanged(status),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 32.w,
        height: 32.h,
        decoration: BoxDecoration(
          color: isSelected ? activeColor : const Color(0xFFF6F5F2),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? activeColor
                : Colors.black.withValues(alpha: 0.08),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: activeColor.withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : AppColors.subtitleOlive,
            ),
          ),
        ),
      ),
    );
  }
}
