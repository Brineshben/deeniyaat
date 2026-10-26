import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../controller/fee_controller.dart';
import '../model/fee_model.dart';

class CollectionHistorySheet extends StatelessWidget {
  const CollectionHistorySheet({super.key});

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Collection History',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryOlive,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        'All Time',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryOlive.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Row(
                  children: [
                    // Calendar Button
                    GestureDetector(
                      onTap: () {},
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
                        child: SvgPicture.asset(
                          'assets/icons/calendar_mark_bold.svg',
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

                    // Close Button
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
                        hintText: 'Search student/reciept',
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

          // Grade Filter Pills
          SizedBox(
            height: 32.h,
            child: Obx(() {
              final selected = controller.selectedGrade.value;
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                itemCount: controller.gradesList.length,
                separatorBuilder: (context, index) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  final grade = controller.gradesList[index];
                  final isSelected = selected == grade;
                  return GestureDetector(
                    onTap: () => controller.selectedGrade.value = grade,
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
                        grade,
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
          SizedBox(height: 14.h),

          // Receipts List Grouped by Date
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                _buildDateSection(context, controller, 'Today', '3 Collections ₹ 62,943'),
                SizedBox(height: 14.h),
                _buildDateSection(context, controller, '22 Oct 26, Mon', '3 Collections ₹ 62,943'),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    ),);
  }

  Widget _buildDateSection(
    BuildContext context,
    FeeController controller,
    String dateTitle,
    String summarySubtitle,
  ) {
    final items = controller.collectionHistory
        .where((h) => h.dateGroup == dateTitle)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dateTitle,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryOlive,
              ),
            ),
            Flexible(
              child: Text(
                summarySubtitle,
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
        SizedBox(height: 8.h),

        // Items
        ...items.map((item) => _buildReceiptCard(context, controller, item)),
      ],
    );
  }

  Widget _buildReceiptCard(
    BuildContext context,
    FeeController controller,
    CollectionHistoryReceipt item,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
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
              detail: ReceiptDetail(
                receiptNo: 'Receipt ${item.receiptNo}',
                paymentMode: 'Via UPI',
                studentName: item.studentName,
                grade: item.grade,
                rollNo: '04',
                avatarPath: item.avatarPath,
                totalAmount: item.amount,
                collectedOn: '12 September 2026, ${item.time}',
                remainingBalance: 2943,
                items: const [
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
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Row(
              children: [
                // Avatar
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    item.avatarPath,
                    width: 38.w,
                    height: 38.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 38.w,
                      height: 38.w,
                      color: const Color(0xFFF0EFE9),
                      child: Icon(Icons.person, size: 20.w, color: AppColors.primaryOlive),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                // Name & Grade / RCP
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.studentName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryOlive,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '${item.grade} • ${item.receiptNo}',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 10.sp,
                          color: const Color(0xFF767272),
                        ),
                      ),
                    ],
                  ),
                ),

                // Amount
                Text(
                  item.formattedAmount,
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
