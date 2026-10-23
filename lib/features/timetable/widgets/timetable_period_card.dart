import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/colors.dart';
import '../model/timetable_model.dart';

class TimetablePeriodCard extends StatelessWidget {
  final TimetablePeriodModel period;

  const TimetablePeriodCard({
    super.key,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: const Color(0xFFD5D5D5).withValues(alpha: 0.6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            // Background Image if available
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 130.w,
              child: Opacity(
                opacity: 0.45,
                child: Image.asset(
                  period.bgImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                ),
              ),
            ),

            // Card Text Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Time Label
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryOlive.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      period.time,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryOlive,
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Grade / Class
                  Text(
                    period.grade,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),

                  SizedBox(height: 2.h),

                  // Subject Name
                  Text(
                    period.subject,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.subtitleOlive,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
