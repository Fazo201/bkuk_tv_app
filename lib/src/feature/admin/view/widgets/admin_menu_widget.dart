import 'dart:ui';

import 'package:bkuk_tv_app/src/core/constants/menus.dart';
import 'package:bkuk_tv_app/src/feature/admin/manager/admin_provider.dart';
import 'package:bkuk_tv_app/src/feature/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminMenuWidget extends ConsumerWidget {
  const AdminMenuWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMenuId = ref.watch(adminProvider.select((s) => s.selectedMenuId));
    final notifier = ref.read(adminProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Admin",
          style: TextStyle(color: Colors.white, fontSize: 54.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 24.h),

        CustomDivider(),

        SizedBox(height: 12.h),

        /// MENYU RO'YXATI
        Expanded(
          child: ListView.builder(
            itemCount: menus.length + 1,
            itemBuilder: (context, index) {
              // Birthday tugmasi — BOSHIDA
              if (index == 0) {
                return _MenuItemTile(
                  item: _BirthdayMenuItem(),
                  isSelected: selectedMenuId == 999,
                  onTap: () async => await notifier.changeMenuToBirthday(),
                );
              }

              final item = menus[index - 1]; // <-- index - 1
              final isSelected = selectedMenuId == item.id;

              return _MenuItemTile(item: item, isSelected: isSelected, onTap: () => notifier.changeMenu(item.id));
            },
          ),
        ),

        SizedBox(height: 12.h),

        CustomDivider(),

        /// ORQAGA QAYTISH
        _BackButton(onTap: () => Navigator.pop(context)),
      ],
    );
  }
}

// ─── MENU ITEM TILE ───────────────────────────────────────────────

class _MenuItemTile extends StatefulWidget {
  final dynamic item;
  final bool isSelected;
  final VoidCallback onTap;

  const _MenuItemTile({required this.item, required this.isSelected, required this.onTap});

  @override
  State<_MenuItemTile> createState() => _MenuItemTileState();
}

class _MenuItemTileState extends State<_MenuItemTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  bool _isHovered = false;

  static const Color _cardBlue = Color(0xFF12345B);
  static const Color _cardBlueLighter = Color(0xFF1B4677);
  static const Color _gold = Color(0xFFD4A842);
  static const Color _goldLight = Color(0xFFECC96A);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 140));
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool active = widget.isSelected || _isHovered;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTapDown: (_) => _controller.forward(),
          onTapUp: (_) {
            _controller.reverse();
            widget.onTap();
          },
          onTapCancel: () => _controller.reverse(),
          child: ScaleTransition(
            scale: _scaleAnim,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    gradient: widget.isSelected
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [_cardBlueLighter.withValues(alpha: 0.85), _cardBlue.withValues(alpha: 0.55)],
                          )
                        : _isHovered
                        ? LinearGradient(colors: [_cardBlue.withValues(alpha: 0.5), _cardBlue.withValues(alpha: 0.2)])
                        : null,
                    border: Border.all(
                      color: widget.isSelected
                          ? _gold.withValues(alpha: 0.55)
                          : _isHovered
                          ? Colors.white.withValues(alpha: 0.12)
                          : Colors.white.withValues(alpha: 0.08),
                      width: 1.8,
                    ),
                    boxShadow: widget.isSelected
                        ? [
                            BoxShadow(
                              color: _gold.withValues(alpha: 0.08),
                              blurRadius: 16,
                              spreadRadius: 0,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      /// ICON
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: active ? _gold.withValues(alpha: 0.12) : Colors.white.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: active ? _gold.withValues(alpha: 0.25) : Colors.white.withValues(alpha: 0.06),
                          ),
                        ),
                        child: Icon(
                          widget.item.icon,
                          color: active ? _goldLight : Colors.white.withValues(alpha: 0.55),
                          size: 32.sp,
                        ),
                      ),

                      SizedBox(width: 14.w),

                      /// TITLE
                      Expanded(
                        child: Text(
                          widget.item.title,
                          style: TextStyle(
                            color: active ? Colors.white : Colors.white.withValues(alpha: 0.65),
                            fontSize: 20.sp,
                            fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                            height: 1.3,
                          ),
                        ),
                      ),

                      /// ARROW
                      AnimatedOpacity(
                        opacity: widget.isSelected ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          transform: widget.isSelected
                              ? Matrix4.identity()
                              : (Matrix4.identity()..translate(-6.0, 0.0)),
                          child: Icon(Icons.chevron_right_rounded, color: _goldLight, size: 20.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── BACK BUTTON ─────────────────────────────────────────────────

class _BackButton extends StatefulWidget {
  final VoidCallback onTap;

  const _BackButton({required this.onTap});

  @override
  State<_BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<_BackButton> {
  bool _isHovered = false;

  static const Color _gold = Color(0xFFD4A842);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: EdgeInsets.only(top: 8.h, right: 32.w),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.white.withValues(alpha: 0.05),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: _isHovered ? (Matrix4.identity()..translate(-4.0, 0.0)) : Matrix4.identity(),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: _isHovered ? _gold : Colors.white.withValues(alpha: 0.45),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                "Asosiy ekranga qaytish",
                style: TextStyle(
                  color: _isHovered ? _gold : Colors.white.withValues(alpha: 0.45),
                  fontSize: 20.sp,
                  fontWeight: _isHovered ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BirthdayMenuItem {
  final int id = 0;
  final String title = "Tug'ilgan kunlar";
  final IconData icon = Icons.cake_outlined;
}
