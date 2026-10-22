import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/colors.dart';

class LeaveOverviewCard extends StatelessWidget {
  final int studentsOnLeave;
  final String leaveDescription;
  final int pendingRequestsCount;
  final VoidCallback onViewLeaves;

  const LeaveOverviewCard({
    super.key,
    required this.studentsOnLeave,
    required this.leaveDescription,
    required this.pendingRequestsCount,
    required this.onViewLeaves,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.leaveGradientStart, // #698F6E
            AppColors.leaveGradientEnd,   // #1F291E
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Upper White Card (Figma Frame 1686558193)
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header: Leave Overview
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/document_bold.svg',
                      width: 14.w,
                      height: 14.w,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primaryOlive,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Leave Overview',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryOlive,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),

                // Stats & Avatar Stack Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$studentsOnLeave Students on leave',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryOlive,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            leaveDescription,
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

                    // Avatar Stack (Figma 41:1864)
                    _buildAvatarStack(),
                  ],
                ),
              ],
            ),
          ),

          // Bottom Green Strip: Pending leave requests & view >>
          InkWell(
            onTap: onViewLeaves,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24.r),
              bottomRight: Radius.circular(24.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '$pendingRequestsCount Pending leave requests',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'view',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      SvgPicture.asset(
                        'assets/icons/arrow_right_double.svg',
                        width: 10.w,
                        height: 10.w,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarStack() {
    return SizedBox(
      width: 68.w,
      height: 32.h,
      child: Image.asset(
        'assets/images/avatar_stack.png',
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // Fallback overlapping circles if image fails
          return Stack(
            children: List.generate(4, (index) {
              return Positioned(
                left: index * 14.w,
                child: Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.w),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 16.sp,
                    color: Colors.white,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
