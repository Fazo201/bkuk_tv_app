import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBirthdayCard extends StatefulWidget {
  final List<Map<String, dynamic>> employees;

  const HomeBirthdayCard({super.key, required this.employees});

  @override
  State<HomeBirthdayCard> createState() => _HomeBirthdayCardState();
}

class _HomeBirthdayCardState extends State<HomeBirthdayCard> with SingleTickerProviderStateMixin {
  static const Color _darkBlue = Color(0xFF061E3A);
  static const Color _blue = Color(0xFF0B2F5B);
  static const Color _gold = Color(0xFFE3B55F);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_blue.withAlpha(153), _darkBlue.withAlpha(153)],
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.10), width: 1.2),
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 18.h,
            children: [
              Row(
                spacing: 12.w,
                children: [
                  Icon(Icons.cake_rounded, color: _gold, size: 28.sp),
                  Text(
                    "BUGUN TAVALLUD KUNINI NISHONLAYOTGAN XODIMLARIMIZ",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: _gold, fontSize: 21.sp, fontWeight: FontWeight.w500, height: 1),
                  ),
                ],
              ),
              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.employees.length,
                  separatorBuilder: (context, index) => Container(
                    width: 2.w,
                    margin: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
                    color: Colors.white.withAlpha(20),
                  ),
                  itemBuilder: (context, index) {
                    final employee = widget.employees[index];
                    return GestureDetector(
                      onTap: () => _showBirthdayFullscreen(context, employee),
                      child: SizedBox(
                        // color: Colors.white.withAlpha(20),
                        width: 280.w,
                        child: SingleChildScrollView(
                          child: Column(
                            spacing: 12.h,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 40.w,
                                    backgroundImage: employee['image'] != null
                                        ? FileImage(File(employee['image']))
                                        : null,
                                    child: employee['image'] == null
                                        ? Icon(Icons.person, size: 40.w, color: Colors.white54)
                                        : null,
                                  ),
                        
                                  SizedBox(width: 14.w),
                        
                                  /// info
                                  SizedBox(
                                    width: 180.w,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${employee['firstName']}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2,
                                          ),
                                        ),
                                        Text(
                                          '${employee['lastName']}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2,
                                          ),
                                        ),
                                        Text(
                                          '${employee['middleName']}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      employee['department'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: _gold, fontSize: 18.sp, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                        
                                  SizedBox(width: 12.w),
                        
                                  Container(
                                    width: 42.w,
                                    height: 42.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withAlpha(20),
                                      border: Border.all(color: Colors.white.withAlpha(20), width: 2),
                                    ),
                                    child: Icon(Icons.card_giftcard_rounded, color: Colors.white, size: 22.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBirthdayFullscreen(BuildContext context, Map<String, dynamic> employee) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (_) => Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: employee['birthdayImage'] != null
                ? Image.file(File(employee['birthdayImage']), fit: BoxFit.contain)
                : Icon(Icons.cake_rounded, color: _gold, size: 120.sp),
          ),
        ),
      ),
    );
  }
}
