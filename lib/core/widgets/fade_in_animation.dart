import 'package:flutter/material.dart';

/// No-op pass-through — all entrance animations have been removed per UX
/// audit. Kept as a named widget so existing call sites compile unchanged.
class FadeInAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Offset slideOffset;

  const FadeInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.delay = Duration.zero,
    this.slideOffset = Offset.zero,
  });

  @override
  Widget build(BuildContext context) => child;
}
