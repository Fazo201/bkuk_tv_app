import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateTimeWidget extends StatefulWidget {
  const DateTimeWidget({super.key, this.color, this.onDoubleTap});
  final Color? color;
  final VoidCallback? onDoubleTap;

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  late DateTime _now;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _time {
    final h = _now.hour.toString().padLeft(2, '0');
    final m = _now.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String get _date {
    const months = [
      'Yanvar',
      'Fevral',
      'Mart',
      'Aprel',
      'May',
      'Iyun',
      'Iyul',
      'Avgust',
      'Sentabr',
      'Oktabr',
      'Noyabr',
      'Dekabr',
    ];
    const weekdays = [
      'Dushanba',
      'Seshanba',
      'Chorshanba',
      'Payshanba',
      'Juma',
      'Shanba',
      'Yakshanba',
    ];
    final day = _now.day;
    final month = months[_now.month - 1];
    final weekday = weekdays[_now.weekday - 1];
    final year = _now.year;
    return '$day $month $year, $weekday';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: widget.onDoubleTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 12.h,
        children: [
          Text(
            _time,
            style: TextStyle(
              color: widget.color ?? const Color(0xFF061E3A),
              fontSize: 62.sp,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
          Text(
            _date,
            style: TextStyle(
              color: widget.color ?? const Color(0xFF061E3A),
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
