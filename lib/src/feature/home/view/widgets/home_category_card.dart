import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCategoryCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final double? height;
  final double? width;
  final VoidCallback? onTap;

  const HomeCategoryCard({super.key, required this.icon, required this.title, this.height, this.width, this.onTap});

  @override
  State<HomeCategoryCard> createState() => _HomeCategoryCardState();
}

class _HomeCategoryCardState extends State<HomeCategoryCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));

    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static const Color _darkBlue = Color(0xFF071B34);
  static const Color _cardBlue = Color(0xFF12345B);
  static const Color _cardBlueLighter = Color(0xFF1B4677);

  static const Color _gold = Color(0xFFD4A842);
  static const Color _goldLight = Color(0xFFECC96A);

  static const Color _white = Colors.white;

  @override
  Widget build(BuildContext context) {
    final bool active = _isHovered;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap?.call();
        },
        onTapCancel: () => _controller.reverse(),
        child: ScaleTransition(
          scale: _scaleAnim,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                height: widget.height,
                width: widget.width,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.r),

                  /// GLASS EFFECT
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: active
                        ? [_cardBlueLighter.withValues(alpha: 0.72), _cardBlue.withValues(alpha: 0.32)]
                        : [_cardBlue.withValues(alpha: 0.58), _darkBlue.withValues(alpha: 0.18)],
                  ),

                  border: Border.all(
                    color: active ? _gold.withValues(alpha: 0.45) : Colors.white10,
                    width: 1.8,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: active ? _gold.withValues(alpha: 0.12) : Colors.black.withValues(alpha: 0.18),
                      blurRadius: active ? 20 : 12,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// ICON
                    SizedBox(height: 24.h),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: active ? _gold.withValues(alpha: 0.12) : Colors.white.withValues(alpha: 0.03),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                      ),
                      child: Icon(widget.icon, color: active ? _goldLight : _gold, size: 72.sp),
                    ),

                    SizedBox(height: 18.h),

                    /// TITLE
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: _white, fontSize: 22.sp, fontWeight: FontWeight.w500, height: 1.4),
                    ),

                    const Spacer(),

                    /// ARROW
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      transform: active ? (Matrix4.identity()..translate(5.0, 0.0)) : Matrix4.identity(),
                      child: Icon(Icons.arrow_forward_rounded, color: _white.withValues(alpha: 0.9), size: 24.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
