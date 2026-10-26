import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/colors.dart';

class SummaryCarouselCard extends StatelessWidget {
  final PageController pageController;
  final int activeIndex;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onTakeAttendanceTap;
  final VoidCallback onTimetableTap;

  const SummaryCarouselCard({
    super.key,
    required this.pageController,
    required this.activeIndex,
    required this.onPageChanged,
    required this.onTakeAttendanceTap,
    required this.onTimetableTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Carousel Cards
        SizedBox(
          height: 125.h,
          child: PageView(
            controller: pageController,
            onPageChanged: onPageChanged,
            clipBehavior: Clip.none,
            children: [
              // Card 1: Attendance Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: _buildAttendanceCard(),
              ),

              // Card 2: Timetable Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: _buildTimetableCard(),
              ),
            ],
          ),
        ),

        SizedBox(height: 8.h),

        // Carousel Indicator Dots (Figma Frame 1686558233)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            final isActive = index == activeIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              width: isActive ? 20.w : 6.w,
              height: 3.h,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primaryOlive
                    : AppColors.primaryOlive.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.r),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildAttendanceCard() {
    return GestureDetector(
      onTap: onTakeAttendanceTap,
      child: Container(
        height: 125.h,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Figma rendered card background with exact illustrations
              Image.asset(
                'assets/images/card_attendance.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildFallbackAttendanceCard(),
              ),

              // Overlay content for interactivity & crisp text rendering
              // Padding(
              //   padding: EdgeInsets.all(16.r),
              //   child: FittedBox(
              //     fit: BoxFit.scaleDown,
              //     alignment: Alignment.topLeft,
              //     child: ConstrainedBox(
              //       constraints: BoxConstraints(
              //         minWidth: 280.w,
              //         maxWidth: 340.w,
              //         maxHeight: 93.h,
              //       ),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           // Top tag: Attendance
              //           Row(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               SvgPicture.asset(
              //                 'assets/icons/documents_bold.svg',
              //                 width: 14.w,
              //                 height: 14.w,
              //                 colorFilter: const ColorFilter.mode(
              //                   AppColors.primaryOlive,
              //                   BlendMode.srcIn,
              //                 ),
              //               ),
              //               SizedBox(width: 4.w),
              //               Text(
              //                 'Attendance',
              //                 style: TextStyle(
              //                   fontFamily: 'Manrope',
              //                   fontSize: 10.sp,
              //                   fontWeight: FontWeight.w500,
              //                   color: AppColors.primaryOlive,
              //                 ),
              //               ),
              //             ],
              //           ),
              //
              //           // Middle headline: Take attendance >> & Attendance pending
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 mainAxisSize: MainAxisSize.min,
              //                 children: [
              //                   Flexible(
              //                     child: Text(
              //                       'Take attendance',
              //                       maxLines: 1,
              //                       overflow: TextOverflow.ellipsis,
              //                       style: TextStyle(
              //                         fontFamily: 'Manrope',
              //                         fontSize: 16.sp,
              //                         fontWeight: FontWeight.w600,
              //                         color: AppColors.primaryOlive,
              //                       ),
              //                     ),
              //                   ),
              //                   SizedBox(width: 6.w),
              //                   SvgPicture.asset(
              //                     'assets/icons/arrow_right_double.svg',
              //                     width: 12.w,
              //                     height: 12.w,
              //                     colorFilter: const ColorFilter.mode(
              //                       AppColors.primaryOlive,
              //                       BlendMode.srcIn,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               SizedBox(height: 2.h),
              //               Text(
              //                 'Attendance pending',
              //                 maxLines: 1,
              //                 overflow: TextOverflow.ellipsis,
              //                 style: TextStyle(
              //                   fontFamily: 'Manrope',
              //                   fontSize: 10.sp,
              //                   fontWeight: FontWeight.w400,
              //                   color: AppColors.subtitleOlive,
              //                 ),
              //               ),
              //             ],
              //           ),
              //
              //           // Bottom: Grade 2B
              //           Text(
              //             'Grade 2B',
              //             style: TextStyle(
              //               fontFamily: 'Manrope',
              //               fontSize: 12.sp,
              //               fontWeight: FontWeight.w500,
              //               color: AppColors.primaryOlive,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimetableCard() {
    return GestureDetector(
      onTap: onTimetableTap,
      child: Container(
        height: 125.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Figma rendered card background with exact illustrations
              Image.asset(
                'assets/images/card_timetable.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildFallbackTimetableCard(),
              ),

              // Overlay content
              // Padding(
              //   padding: EdgeInsets.all(16.r),
              //   child: FittedBox(
              //     fit: BoxFit.scaleDown,
              //     alignment: Alignment.topLeft,
              //     child: ConstrainedBox(
              //       constraints: BoxConstraints(
              //         minWidth: 280.w,
              //         maxWidth: 340.w,
              //         maxHeight: 93.h,
              //       ),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           // Top tag: Timetable & Next class
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Row(
              //                 mainAxisSize: MainAxisSize.min,
              //                 children: [
              //                   SvgPicture.asset(
              //                     'assets/icons/calendar_mark_bold.svg',
              //                     width: 14.w,
              //                     height: 14.w,
              //                     colorFilter: const ColorFilter.mode(
              //                       AppColors.primaryOlive,
              //                       BlendMode.srcIn,
              //                     ),
              //                   ),
              //                   SizedBox(width: 4.w),
              //                   Text(
              //                     'Timetable',
              //                     style: TextStyle(
              //                       fontFamily: 'Manrope',
              //                       fontSize: 10.sp,
              //                       fontWeight: FontWeight.w500,
              //                       color: AppColors.primaryOlive,
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               Flexible(
              //                 child: Text(
              //                   'Next class',
              //                   maxLines: 1,
              //                   overflow: TextOverflow.ellipsis,
              //                   style: TextStyle(
              //                     fontFamily: 'Manrope',
              //                     fontSize: 10.sp,
              //                     fontWeight: FontWeight.w500,
              //                     color: AppColors.primaryOlive,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //
              //           // Middle: Qur'an & Tajweed & 10:00 am-10:45 am
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 'Qur’an & Tajweed',
              //                 maxLines: 1,
              //                 overflow: TextOverflow.ellipsis,
              //                 style: TextStyle(
              //                   fontFamily: 'Manrope',
              //                   fontSize: 16.sp,
              //                   fontWeight: FontWeight.w600,
              //                   color: AppColors.primaryOlive,
              //                 ),
              //               ),
              //               SizedBox(height: 2.h),
              //               Text(
              //                 '10:00 am–10:45 am',
              //                 maxLines: 1,
              //                 overflow: TextOverflow.ellipsis,
              //                 style: TextStyle(
              //                   fontFamily: 'Manrope',
              //                   fontSize: 10.sp,
              //                   fontWeight: FontWeight.w400,
              //                   color: AppColors.subtitleOlive,
              //                 ),
              //               ),
              //             ],
              //           ),
              //
              //           // Bottom: Grade 2B
              //           Text(
              //             'Grade 2B',
              //             style: TextStyle(
              //               fontFamily: 'Manrope',
              //               fontSize: 12.sp,
              //               fontWeight: FontWeight.w500,
              //               color: AppColors.primaryOlive,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackAttendanceCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8F2CE),
        borderRadius: BorderRadius.circular(24.r),
      ),
    );
  }

  Widget _buildFallbackTimetableCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2EED6),
        borderRadius: BorderRadius.circular(24.r),
      ),
    );
  }
}
