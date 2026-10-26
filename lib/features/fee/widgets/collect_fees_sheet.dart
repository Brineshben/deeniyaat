import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../controller/fee_controller.dart';
import '../model/fee_model.dart';

class CollectFeesSheet extends StatelessWidget {
  final StudentFeeItem student;

  const CollectFeesSheet({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeeController>();

    return Material(
      color: Colors.transparent,
      child: Container(
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
          SizedBox(height: 12.h),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Collect Fees',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryOlive,
                    letterSpacing: -0.3,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 36.w,
                    height: 36.w,
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
          SizedBox(height: 12.h),

          // Student Card
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
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
                        color: const Color(0xFFF0EFE9),
                        child: Icon(Icons.person, size: 24.w, color: AppColors.primaryOlive),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
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
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryOlive,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${student.grade} • Roll No:${student.rollNo}',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 10.sp,
                            color: const Color(0xFF767272),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹ 2,943',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFD91010),
                        ),
                      ),
                      Text(
                        'Total Outstanding',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 9.sp,
                          color: const Color(0xFF767272),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Segmented Toggle Tabs
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Obx(() {
              final tab = controller.collectFeesTab.value;
              return Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.collectFeesTab.value = 0,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: tab == 0 ? AppColors.primaryOlive : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            'Choose Fees',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: tab == 0 ? Colors.white : AppColors.primaryOlive,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.collectFeesTab.value = 1,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: tab == 1 ? AppColors.primaryOlive : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            'Auto Distribute',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: tab == 1 ? Colors.white : AppColors.primaryOlive,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          SizedBox(height: 12.h),

          // Scrollable Content
          Expanded(
            child: Obx(() {
              if (controller.collectFeesTab.value == 0) {
                return _buildChooseFeesList(controller);
              } else {
                return _buildAutoDistributeView(controller);
              }
            }),
          ),

          // Fixed Bottom Panel
          _buildBottomActionPanel(context, controller),
        ],
      ),
    ),);
  }

  Widget _buildChooseFeesList(FeeController controller) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      children: [
        // Select Fees Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Fees',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryOlive,
              ),
            ),
            GestureDetector(
              onTap: controller.clearSelection,
              child: Text(
                'Clear All',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF007A99),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),

        // Unpaid Selectable Items
        ...controller.studentFeeItems.where((f) => !f.isPaid).map((item) {
          return GestureDetector(
            onTap: () => controller.toggleFeeSelection(item.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: item.isSelected
                      ? const Color(0xFF03B016)
                      : Colors.transparent,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Circular Checkbox
                  Container(
                    width: 22.w,
                    height: 22.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: item.isSelected
                          ? const Color(0xFF03B016)
                          : Colors.transparent,
                      border: Border.all(
                        color: item.isSelected
                            ? const Color(0xFF03B016)
                            : const Color(0xFFC4C4C4),
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: item.isSelected
                        ? Icon(Icons.check, size: 14.w, color: Colors.white)
                        : null,
                  ),
                  SizedBox(width: 12.w),

                  // Fee Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryOlive,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Text(
                              item.type,
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFD91010),
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Flexible(
                              child: Text(
                                item.dateText,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 10.sp,
                                  color: const Color(0xFF767272),
                                ),
                              ),
                            ),
                          ],
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
                      color: const Color(0xFFD91010),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildAutoDistributeView(FeeController controller) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      children: [
        // Enter Amount Card
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Amount to be Collected',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF767272),
                ),
              ),
              SizedBox(height: 6.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '₹',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryOlive,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  IntrinsicWidth(
                    child: TextField(
                      controller: controller.autoAmountController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryOlive,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter Amount',
                        hintStyle: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 15.sp,
                          color: const Color(0xFF767272),
                        ),
                        isDense: true,
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF767272)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Full Amount Chip
              GestureDetector(
                onTap: controller.setFullAmount,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD6F0F6),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    'Full ₹ 2,943',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF007A99),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.h),

        // Section Title
        Text(
          'Auto Distribution · Oldest Due First',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryOlive,
          ),
        ),
        SizedBox(height: 8.h),

        // Fee Distribution List
        Container(
          padding: EdgeInsets.all(14.r),
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
            children: [
              _buildDistributionItem('Exam Fee', 'Arrear Due Amount: ₹ 2,943', '₹ 2,943'),
              const Divider(color: Color(0xFFF0EFE9), height: 16),
              _buildDistributionItem('Exam Fee', 'Arrear Due Amount: ₹ 2,943', '₹ 2,943'),
              const Divider(color: Color(0xFFF0EFE9), height: 16),
              _buildDistributionItem('Exam Fee', 'Arrear Due Amount: ₹ 2,943', '₹ 2,943'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDistributionItem(String title, String subtitle, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryOlive,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 10.sp,
                color: const Color(0xFF767272),
              ),
            ),
          ],
        ),
        Text(
          amount,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryOlive,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionPanel(BuildContext context, FeeController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8EF),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Selected summary row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '6/12 Fees Selected',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF767272),
                ),
              ),
              Text(
                '₹24,000',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF03B016),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // Payment Mode Selector Tabs
          Obx(() {
            final mode = controller.paymentMode.value;
            return Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Row(
                children: ['Cash', 'Card', 'UPI'].map((m) {
                  final isSelected = mode == m;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => controller.paymentMode.value = m,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryOlive : Colors.transparent,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          m,
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : AppColors.primaryOlive,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
          SizedBox(height: 12.h),

          // Collect Button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () => controller.submitCollection(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.oliveButton,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
              ),
              child: Text(
                'Collect ₹ 2,943',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
