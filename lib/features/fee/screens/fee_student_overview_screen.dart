import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/responsive.dart';
import '../controller/fee_controller.dart';
import '../model/fee_model.dart';
import '../widgets/fee_summary_card.dart';

class FeeStudentOverviewScreen extends StatelessWidget {
  const FeeStudentOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<FeeController>()
        ? Get.find<FeeController>()
        : Get.put(FeeController());

    return Scaffold(
      backgroundColor: const Color(0xFFEBF6D2),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/home_screen_bg.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFEBF6D2),
                      Color(0xFFF3F9E6),
                      Color(0xFFFAFCF5),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Main Responsive Content
          SafeArea(
            bottom: false,
            child: MaxWidthBox(
              maxWidth: 480,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      _buildHeader(context, controller),
                      SizedBox(height: 12.h),

                      // Outstanding Balance Summary Card
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: FeeSummaryCard(
                          outstandingBalance: controller.outstandingBalance,
                          fromStudentsCount: 0,
                          totalPayable: controller.totalPayable,
                          totalCollected: controller.totalCollected,
                          progressFraction: controller.progressFraction,
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Filter Chips
                      _buildStatusFilterChips(controller),
                      SizedBox(height: 10.h),

                      // Term Grouped Fee Items
                      Expanded(
                        child: Obx(() {
                          final fees = controller.filteredStudentFees;
                          final term1Fees = fees.where((f) => f.term == 'Term I').toList();
                          final term2Fees = fees.where((f) => f.term == 'Term II').toList();

                          return ListView(
                            padding: EdgeInsets.only(
                              left: 16.w,
                              right: 16.w,
                              bottom: 90.h,
                            ),
                            children: [
                              if (term1Fees.isNotEmpty) ...[
                                _buildTermHeader('Term I'),
                                SizedBox(height: 8.h),
                                ...term1Fees.map((f) => _buildFeeItemCard(f)),
                                SizedBox(height: 12.h),
                              ],
                              if (term2Fees.isNotEmpty) ...[
                                _buildTermHeader('Term II'),
                                SizedBox(height: 8.h),
                                ...term2Fees.map((f) => _buildFeeItemCard(f)),
                              ],
                            ],
                          );
                        }),
                      ),
                    ],
                  ),

                  // Fixed Bottom Collect Fees Button
                  Positioned(
                    left: 16.w,
                    right: 16.w,
                    bottom: 20.h,
                    child: SizedBox(
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          final student = controller.selectedStudent.value ??
                              (controller.allStudents.isNotEmpty
                                  ? controller.allStudents.first
                                  : null);
                          if (student != null) {
                            controller.showCollectFeesSheet(context, student);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.oliveButton,
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shadowColor: Colors.black.withValues(alpha: 0.15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                        ),
                        child: Text(
                          'Collect Fees',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, FeeController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Obx(() {
        final student = controller.selectedStudent.value;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  // Back Button
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
                  SizedBox(width: 10.w),

                  // Avatar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.asset(
                      student?.avatarPath ?? 'assets/images/student_avatar_main.png',
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
                  SizedBox(width: 10.w),

                  // Name & Grade / Roll
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student?.name ?? 'Ahamed Ali Mohammed',
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
                          '${student?.grade ?? 'Grade 2 B'} • Roll No:${student?.rollNo ?? '04'}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 10.sp,
                            color: const Color(0xFF767272),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),

            // History Button
            GestureDetector(
              onTap: () => controller.showStudentCollectionHistorySheet(context),
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
                  'assets/icons/icon_history.svg',
                  width: 18.w,
                  height: 18.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryOlive,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildStatusFilterChips(FeeController controller) {
    return SizedBox(
      height: 32.h,
      child: Obx(() {
        final selected = controller.selectedStudentStatusFilter.value;
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          scrollDirection: Axis.horizontal,
          children: controller.studentStatusFilters.map((filter) {
            final isSelected = selected == filter;
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: GestureDetector(
                onTap: () => controller.selectedStudentStatusFilter.value = filter,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryOlive
                        : Colors.white.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    filter,
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
        );
      }),
    );
  }

  Widget _buildTermHeader(String termName) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.black.withValues(alpha: 0.1), endIndent: 8)),
        Text(
          termName,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF767272),
          ),
        ),
        Expanded(child: Divider(color: Colors.black.withValues(alpha: 0.1), indent: 8)),
      ],
    );
  }

  Widget _buildFeeItemCard(FeeItemDetail item) {
    final isArrear = item.type == 'Arrear';
    final isPaid = item.type == 'Paid';

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
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
      child: Row(
        children: [
          // Icon badge (danger circle red or check circle green)
          Container(
            width: 28.w,
            height: 28.w,
            decoration: BoxDecoration(
              color: isArrear
                  ? const Color(0xFFD91010)
                  : (isPaid ? const Color(0xFF03B016) : const Color(0xFF767272)),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              isArrear ? Icons.priority_high : Icons.check,
              size: 16.w,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 12.w),

          // Details
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
                        color: isArrear
                            ? const Color(0xFFD91010)
                            : (isPaid ? const Color(0xFF03B016) : const Color(0xFF767272)),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: Text(
                        item.dateText.replaceAll(item.type, '').trim(),
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
              color: isArrear
                  ? const Color(0xFFD91010)
                  : (isPaid ? const Color(0xFF03B016) : AppColors.primaryOlive),
            ),
          ),
        ],
      ),
    );
  }
}
