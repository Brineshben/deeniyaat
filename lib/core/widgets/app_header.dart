import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/fade_in_animation.dart';

import 'package:deeniyat/core/theme/colors.dart';
/// Standardized app header widget
/// Replaces inconsistent header implementations across 20+ screens
///
/// Usage:
/// ```dart
/// AppHeader(
///   title: 'Screen Title',
///   onBackPressed: () => Navigator.pop(context),
///   trailing: Widget,
/// )
/// ```
class AppHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final Widget? trailing;
  final bool useGradient;

  const AppHeader({
    super.key,
    required this.title,
    this.onBackPressed,
    this.trailing,
    this.useGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      delay: const Duration(milliseconds: 100),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            if (onBackPressed != null)
              _buildBackButton()
            else
              const SizedBox(width: 42),
            const SizedBox(width: 12),
            Expanded(
              child:
                  useGradient
                      ? _buildGradientTitle()
                      : Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.21,
                          color: AppColors.white,
                        ),
                      ),
            ),
            if (trailing != null)
              trailing!
            else if (onBackPressed != null)
              const SizedBox(width: 42),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: onBackPressed,
      child: SvgPicture.asset(
        'assets/icons/icon_arrow_left.svg',
        width: 42,
        height: 42,
      ),
    );
  }

  Widget _buildGradientTitle() {
    return ShaderMask(
      shaderCallback:
          (bounds) => const LinearGradient(
            colors: [AppColors.textPrimary, AppColors.accentPurple2],
          ).createShader(bounds),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.21,
          color: AppColors.white,
        ),
      ),
    );
  }
}
