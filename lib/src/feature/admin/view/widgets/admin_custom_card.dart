import 'dart:io';

import 'package:bkuk_tv_app/src/feature/widgets/custom_delete_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminCustomCard extends StatelessWidget {
  final String title;
  final String? description;
  final String? imagePath;
  final String date;
  final VoidCallback? onDelete;
  final VoidCallback? onUpdate;

  static const Color _cardBlue = Color(0xff001B44);
  static const Color _cardBlueLighter = Color(0xff001B44);
  static const Color _gold = Color.fromARGB(255, 255, 198, 65);

  const AdminCustomCard({
    super.key,
    required this.title,
    required this.date,
    this.onDelete,
    this.description,
    this.imagePath,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_cardBlueLighter.withValues(alpha: 0.75), _cardBlue.withValues(alpha: 0.55)],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08), width: 1.2),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          /// RASM
          Stack(
            children: [
              _CardImage(imagePath: imagePath),
              Positioned(
                bottom: 4.h,
                left: 4.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.calendar_today_outlined, color: _gold, size: 14.sp),
                      SizedBox(width: 5.w),
                      Text(
                        date,
                        style: TextStyle(color: _gold, fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

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
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),

                      if (description != null && description!.isNotEmpty) ...[
                        SizedBox(height: 12.h),

                        /// DESCRIPTION
                        Text(
                          description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 22.sp, height: 1.2),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),

          /// DELETE + UPDATE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              spacing: 18.h,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// UPDATE BUTTON
                if(onUpdate != null)
                GestureDetector(
                  onTap: onUpdate,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 9.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(54.r),
                      border: Border.all(color: _gold.withValues(alpha: 0.6), width: 1.2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Tahrirlash",
                          style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(width: 10.w),
                        Icon(CupertinoIcons.pencil, color: _gold, size: 18.sp),
                      ],
                    ),
                  ),
                ),

                /// DELETE BUTTON
                CustomDeleteWidget(onConfirm: onDelete),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── CARD IMAGE ───────────────────────────────────────────────────

class _CardImage extends StatelessWidget {
  final String? imagePath;

  static const Color _darkBlue = Color(0xFF071B34);

  const _CardImage({this.imagePath});

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
            imagePath != null
                ? Image.file(File(imagePath!), fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholder())
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
