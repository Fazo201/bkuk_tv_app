import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDeleteWidget extends StatelessWidget {
  final VoidCallback? onConfirm;

  const CustomDeleteWidget({super.key, this.onConfirm});

  void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("O'chirishni tasdiqlang"),
        content: const Text("Haqiqatan ham o'chirmoqchimisiz?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Bekor qilish"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              onConfirm?.call();
            },
            child: const Text("O'chirish", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showConfirmDialog(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 9.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(54.r),
          border: Border.all(color: Colors.red.withValues(alpha: 0.6), width: 1.2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "O'chirish",
              style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w400),
            ),
            SizedBox(width: 10.w),
            Icon(CupertinoIcons.delete, color: Colors.red, size: 18.sp),
          ],
        ),
      ),
    );
  }
}