import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeeSummaryCard extends StatelessWidget {
  final String outstandingBalance;
  final int fromStudentsCount;
  final String totalPayable;
  final String totalCollected;
  final double progressFraction;

  const FeeSummaryCard({
    super.key,
    required this.outstandingBalance,
    this.fromStudentsCount = 3,
    required this.totalPayable,
    required this.totalCollected,
    this.progressFraction = 0.55,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF3B4807),
            Color(0xFF1E2602),
            Color(0xFF0F1401),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label
          Text(
            'Outstanding Balance',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.8),
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(height: 2.h),

          // Amount + From Students
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                outstandingBalance,
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.3,
                ),
              ),
              if (fromStudentsCount > 0) ...[
                SizedBox(width: 8.w),
                Text(
                  'From $fromStudentsCount Students',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 10.h),

          // Progress bar
          Container(
            height: 5.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progressFraction.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),

          // Bottom Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Total Payable
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 10.sp,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                    children: [
                      const TextSpan(text: 'Total Payable '),
                      TextSpan(
                        text: totalPayable,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8.w),

              // Total Collected
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 10.sp,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                    children: [
                      const TextSpan(text: 'Total Collected '),
                      TextSpan(
                        text: totalCollected,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
