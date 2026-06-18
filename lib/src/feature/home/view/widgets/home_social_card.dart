import 'dart:ui';

import 'package:bkuk_tv_app/src/feature/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSocialCard extends StatefulWidget {
  const HomeSocialCard({super.key});

  @override
  State<HomeSocialCard> createState() => _HomeSocialCardState();
}

class _HomeSocialCardState extends State<HomeSocialCard> with SingleTickerProviderStateMixin {
  static const Color _darkBlue = Color(0xFF061E3A);
  static const Color _blue = Color(0xFF0B2F5B);

  String? _qrImagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_blue.withAlpha(153), _darkBlue.withAlpha(153)],
            ),
            border: Border.all(color: Colors.white10, width: 1.2),
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Stack(
            children: [
              /// ASOSIY KONTENT
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 18.h,
                  children: [
                    Text(
                      "IJTIMOIY TARMOQLARIMIZ",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 21.sp, fontWeight: FontWeight.w500, height: 1),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          spacing: 10.h,
                          children: [
                            SocialButton(
                              title: "Telegram",
                              subtitle: "kanalimizga a'zo bo'ling",
                              iconPath: 'assets/icons/telegram_logo.svg',
                              onTap: () => setState(() => _qrImagePath = 'assets/images/telegram_qr.png'),
                            ),
                            SocialButton(
                              title: "Instagram",
                              subtitle: "sahifamizni kuzatib boring",
                              iconPath: 'assets/icons/instagram_logo.svg',
                              onTap: () => setState(() => _qrImagePath = 'assets/images/instagram_qr.png'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// QR KOD OVERLAY
              if (_qrImagePath != null)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () => setState(() => _qrImagePath = null),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(
                        color: _darkBlue.withAlpha(200),
                        child: Image.asset(_qrImagePath!, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
