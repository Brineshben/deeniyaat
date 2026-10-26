import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';

class FeeCollectionSuccessDialog extends StatelessWidget {
  const FeeCollectionSuccessDialog({super.key});

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
          SizedBox(height: 16.h),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  // 3D Illustration
                  Image.asset(
                    'assets/images/fee_success_illust.png',
                    width: 120.w,
                    height: 105.h,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 100.w,
                      height: 90.h,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.check_circle,
                        size: 64.w,
                        color: const Color(0xFF03B016),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Title
                  Text(
                    'Collected ₹ 2,943 Successfully',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryOlive,
                      letterSpacing: -0.4,
                    ),
                  ),
                  SizedBox(height: 4.h),

                  // Subtitle
                  Text(
                    'On 12 September 2026, 12:34PM',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryOlive.withValues(alpha: 0.75),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Student Info Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Image.asset(
                                'assets/images/student_avatar_main.png',
                                width: 34.w,
                                height: 34.w,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.person, size: 24.w, color: AppColors.primaryOlive),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ahamed Ali Mohammed',
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryOlive,
                                  ),
                                ),
                                Text(
                                  'Grade 2 B • Roll No:04',
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
                        SizedBox(height: 8.h),
                        Text(
                          'Remaining Balance to pay ₹ 2,943',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF767272),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Receipt Breakdown Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
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
                              width: 32.w,
                              height: 32.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFFB4EBF2),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                'assets/icons/document_bold.svg',
                                width: 16.w,
                                height: 16.w,
                                colorFilter: const ColorFilter.mode(
                                  Color(0xFF007A99),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Receipt RCP-5160',
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryOlive,
                                  ),
                                ),
                                Text(
                                  'Via UPI',
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
                        SizedBox(height: 12.h),

                        // Dashed divider
                        _buildDashedLine(),
                        SizedBox(height: 10.h),

                        // Fee items
                        ...List.generate(7, (index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tuition fee · Term I',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 10.sp,
                                      color: const Color(0xFF767272),
                                    ),
                                  ),
                                  Text(
                                    '₹9,000',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryOlive,
                                    ),
                                  ),
                                ],
                              ),
                              if (index < 6) ...[
                                SizedBox(height: 8.h),
                                _buildDashedLine(),
                                SizedBox(height: 8.h),
                              ],
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
                        backgroundColor: AppColors.oliveButton,
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
                  SizedBox(height: 8.h),

                  // Close Text Button
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryOlive,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
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
