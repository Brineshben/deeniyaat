import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../model/fee_model.dart';

class CollectionSummarySheet extends StatelessWidget {
  final ReceiptDetail detail;

  const CollectionSummarySheet({
    super.key,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.90.sh,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8EF),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          // Drag handle
          Container(
            width: 44.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 10.h),

          // Top action buttons bar: Back and Close
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 16.w,
                      color: AppColors.primaryOlive,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Collection Summary',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryOlive,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.close,
                      size: 18.w,
                      color: AppColors.primaryOlive,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.h),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 60.w,
                    height: 60.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        detail.avatarPath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xFFF0EFE9),
                          child: Icon(
                            Icons.person,
                            size: 32.w,
                            color: AppColors.primaryOlive,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Student Name
                  Text(
                    detail.studentName,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryOlive,
                    ),
                  ),
                  SizedBox(height: 2.h),

                  // Grade & Roll
                  Text(
                    '${detail.grade} • Roll No:${detail.rollNo}',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 11.sp,
                      color: const Color(0xFF767272),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // Big Amount
                  Text(
                    detail.formattedTotal,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryOlive,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 4.h),

                  // Collected On
                  Text(
                    'Collected On ${detail.collectedOn}',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryOlive.withValues(alpha: 0.8),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // White Receipt Details Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Receipt Header
                        Row(
                          children: [
                            Container(
                              width: 36.w,
                              height: 36.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFFB4EBF2),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/icons/document_bold.svg',
                                width: 18.w,
                                height: 18.w,
                                colorFilter: const ColorFilter.mode(
                                  Color(0xFF007A99),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  detail.receiptNo,
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryOlive,
                                  ),
                                ),
                                Text(
                                  detail.paymentMode,
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 10.sp,
                                    color: const Color(0xFF767272),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 14.h),

                        // Dashed line
                        _buildDashedLine(),
                        SizedBox(height: 10.h),

                        // Breakdown rows
                        ...detail.items.map((item) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.title,
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF767272),
                                    ),
                                  ),
                                  Text(
                                    item.formattedAmount,
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryOlive,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              _buildDashedLine(),
                              SizedBox(height: 10.h),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Download Receipt Button
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.snackbar(
                          'Success',
                          'Receipt downloaded successfully',
                          backgroundColor: Colors.white,
                          colorText: AppColors.primaryOlive,
                          snackPosition: SnackPosition.TOP,
                          duration: const Duration(seconds: 2),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOlive,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                      ),
                      child: Text(
                        'Download Receipt',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashedLine() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        const dashSpace = 4.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.1)),
              ),
            );
          }),
        );
      },
    );
  }
}
