import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCardWidget extends StatefulWidget {
  final String title;
  final String description;
  final String? date;
  final String? imageUrl;
  final VoidCallback? onTap;

  const CustomCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    this.imageUrl,
    this.onTap,
  });

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  bool _isHovered = false;

  static const Color _cardBlue = Color(0xFF0D2A4E);
  static const Color _cardBlueLighter = Color(0xFF1B4677);
  static const Color _gold = Color(0xFFD4A842);
  static const Color _goldLight = Color(0xFFECC96A);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 140));
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool active = _isHovered;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_cardBlueLighter.withValues(alpha: 0.75), _cardBlue.withValues(alpha: 0.55)],
              ),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: active ? _gold.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.2),
                  blurRadius: active ? 20 : 10,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                /// RASM
                _CardImage(imageUrl: widget.imageUrl),
          
                /// CONTENT
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// TITLE
                            Text(
                              widget.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                              ),
                            ),
          
                            SizedBox(height: 12.h),
          
                            /// DESCRIPTION
                            Text(
                              widget.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 22.sp,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
          
                /// DATE + BUTTON
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    spacing: 18.h,
                    children: [
                      /// DATE
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined, color: _gold.withValues(alpha: 0.85), size: 18.sp),
                          SizedBox(width: 6.w),
                          Text(
                            widget.date ?? '',
                            style: TextStyle(color: _gold, fontSize: 18.sp, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
          
                      /// BATAFSIL BUTTON
                      MouseRegion(
                        onEnter: (_) => setState(() => _isHovered = true),
                        onExit: (_) => setState(() => _isHovered = false),
                        cursor: SystemMouseCursors.click,
                        child: _DetailButton(isHovered: active, gold: _gold, goldLight: _goldLight),
                      ),
                    ],
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

// ─── CARD IMAGE ───────────────────────────────────────────────────

class _CardImage extends StatelessWidget {
  final String? imageUrl;

  static const Color _darkBlue = Color(0xFF071B34);

  const _CardImage({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12.r)),
      child: SizedBox(
        width: 180.w,
        height: 140.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            imageUrl != null
                ? Image.file(File(imageUrl!), fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholder())
                : _placeholder(),

            /// GRADIENT OVERLAY
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.transparent, _darkBlue.withValues(alpha: 0.35)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: const Color(0xFF0D2A4E),
      child: Center(
        child: Icon(Icons.image_outlined, color: Colors.white24, size: 32.sp),
      ),
    );
  }
}

// ─── DETAIL BUTTON ────────────────────────────────────────────────

class _DetailButton extends StatelessWidget {
  final bool isHovered;
  final Color gold;
  final Color goldLight;

  const _DetailButton({required this.isHovered, required this.gold, required this.goldLight});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 9.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(54.r),
        color: isHovered ? gold.withValues(alpha: 0.12) : Colors.transparent,
        border: Border.all(color: gold.withValues(alpha: 0.6), width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Batafsil",
            style: TextStyle(color: isHovered ? goldLight : Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w400),
          ),
          SizedBox(width: 16.w),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: isHovered ? (Matrix4.identity()..translate(3.0, 0.0)) : Matrix4.identity(),
            child: Icon(CupertinoIcons.chevron_right, color: isHovered ? goldLight : Colors.white, size: 18.sp),
          ),
        ],
      ),
    );
  }
}
