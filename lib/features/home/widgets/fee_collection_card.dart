import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/colors.dart';

class FeeCollectionCard extends StatelessWidget {
  final String expectedAmount;
  final String outstandingAmount;
  final int outstandingStudentsCount;
  final int collectedPercentage;
  final int totalTicks;
  final int unpaidTicks;
  final String pendingAmount;
  final String duesAmount;
  final String arrearsAmount;
  final VoidCallback onViewInsights;

  const FeeCollectionCard({
    super.key,
    required this.expectedAmount,
    required this.outstandingAmount,
    required this.outstandingStudentsCount,
    required this.collectedPercentage,
    this.totalTicks = 24,
    this.unpaidTicks = 7,
    required this.pendingAmount,
    required this.duesAmount,
    required this.arrearsAmount,
    required this.onViewInsights,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onViewInsights,
      behavior: HitTestBehavior.opaque,
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
          // Header: Fee Collection & Expected Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/wallet_money_bold.svg',
                      width: 14.w,
                      height: 14.w,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primaryOlive,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Flexible(
                      child: Text(
                        'Fee Collection',
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
                  '$expectedAmount expected',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Outstanding Amount & Collected Percentage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$outstandingAmount Outstanding',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.outstandingRed,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'from $outstandingStudentsCount students',
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
            SizedBox(width: 8.w),
            Text(
                '$collectedPercentage% Collected',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Ticks Progress Bar (24 rounded bars)
          SizedBox(
            height: 38.h,
            child: Row(
              children: List.generate(totalTicks, (index) {
                final isUnpaid = index >= (totalTicks - unpaidTicks);
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                      color: isUnpaid ? AppColors.tickUnpaid : AppColors.tickPaid,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                );
              }),
            ),
          ),

          SizedBox(height: 12.h),

          // Breakdown Box: Pending, Dues, Arrears
          Container(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.feePendingBg,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildFeeColumn(pendingAmount, 'Pending')),
                Expanded(child: _buildFeeColumn(duesAmount, 'Dues')),
                Expanded(child: _buildFeeColumn(arrearsAmount, 'Arrears')),
              ],
            ),
          ),

          SizedBox(height: 10.h),

          // Footer link
          GestureDetector(
            onTap: onViewInsights,
            child: Text(
              'View insights to get more information about collection',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textMuted,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildFeeColumn(String amount, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          amount,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
            height: 1.2,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}
