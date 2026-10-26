import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../controller/fee_controller.dart';
import '../model/fee_model.dart';

class StudentCollectionHistorySheet extends StatelessWidget {
  const StudentCollectionHistorySheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeeController>();

    return Material(
      color: Colors.transparent,
      child: Container(
        height: 0.88.sh,
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
          SizedBox(height: 14.h),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Student Collection History',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryOlive,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
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
                      size: 20.w,
                      color: AppColors.primaryOlive,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              height: 42.h,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.05),
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/search_linear.svg',
                    width: 16.w,
                    height: 16.w,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF767272),
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 12.sp,
                        color: AppColors.primaryOlive,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search reciept',
                        hintStyle: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 12.sp,
                          color: const Color(0xFF767272),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Month Filter Chips
          SizedBox(
            height: 32.h,
            child: Obx(() {
              final selected = controller.selectedMonth.value;
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                itemCount: controller.monthsList.length,
                separatorBuilder: (context, index) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  final month = controller.monthsList[index];
                  final isSelected = selected == month;
                  return GestureDetector(
                    onTap: () => controller.selectedMonth.value = month,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryOlive
                            : Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Text(
                        month,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : AppColors.primaryOlive,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          SizedBox(height: 16.h),

          // List Grouped by Month
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'April 2026',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryOlive,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '3 Collections  ₹ 62,943',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryOlive,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                _buildStudentReceiptItem(
                  context,
                  controller,
                  'Receipt RCP-5160',
                  '12 September 2026, 12:34PM',
                  '₹ 62,943',
                ),
                _buildStudentReceiptItem(
                  context,
                  controller,
                  'Receipt RCP-5160',
                  '12 September 2026, 12:34PM',
                  '₹ 62,943',
                ),
              ],
            ),
          ),
        ],
      ),
    ),);
  }

  Widget _buildStudentReceiptItem(
    BuildContext context,
    FeeController controller,
    String receiptNo,
    String dateStr,
    String amount,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        child: InkWell(
          onTap: () {
            controller.showCollectionSummarySheet(
              context,
              detail: const ReceiptDetail(
                receiptNo: 'Receipt RCP-5160',
                paymentMode: 'Via UPI',
                studentName: 'Ahamed Ali Mohammed',
                grade: 'Grade 2 B',
                rollNo: '04',
                avatarPath: 'assets/images/student_avatar_main.png',
                totalAmount: 2943,
                collectedOn: '12 September 2026, 12:34PM',
                remainingBalance: 2943,
                items: [
                  ReceiptBreakdownItem(title: 'Tuition fee · Term I', amount: 9000),
                  ReceiptBreakdownItem(title: 'Tuition fee · Term I', amount: 9000),
                  ReceiptBreakdownItem(title: 'Tuition fee · Term I', amount: 9000),
                  ReceiptBreakdownItem(title: 'Tuition fee · Term I', amount: 9000),
                  ReceiptBreakdownItem(title: 'Tuition fee · Term I', amount: 9000),
                  ReceiptBreakdownItem(title: 'Tuition fee · Term I', amount: 9000),
                  ReceiptBreakdownItem(title: 'Tuition fee · Term I', amount: 9000),
                ],
              ),
            );
          },
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        receiptNo,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryOlive,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        dateStr,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 10.sp,
                          color: const Color(0xFF767272),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  amount,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryOlive,
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
