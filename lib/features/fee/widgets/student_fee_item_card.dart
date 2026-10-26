import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/colors.dart';
import '../model/fee_model.dart';

class StudentFeeItemCard extends StatelessWidget {
  final StudentFeeItem student;
  final VoidCallback onTap;

  const StudentFeeItemCard({
    super.key,
    required this.student,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Row(
              children: [
                // Avatar
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    student.avatarPath,
                    width: 40.w,
                    height: 40.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF0EFE9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 24.w,
                        color: AppColors.primaryOlive,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                // Name & Grade / Roll
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '${student.grade} • Roll No:${student.rollNo}',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF767272),
                        ),
                      ),
                    ],
                  ),
                ),

                // Trailing: Amount or Fully Paid badge
                if (student.isFullyPaid)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5F8E7),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      'Fully Paid',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF03B016),
                      ),
                    ),
                  )
                else
                  Text(
                    student.formattedAmount,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFD91010),
                      letterSpacing: -0.3,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
