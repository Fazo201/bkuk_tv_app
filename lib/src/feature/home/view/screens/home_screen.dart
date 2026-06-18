import 'dart:async';
import 'dart:io';

import 'package:bkuk_tv_app/src/core/constants/menus.dart';
import 'package:bkuk_tv_app/src/feature/admin/view/screens/admin_home_screen.dart';
import 'package:bkuk_tv_app/src/feature/home/manager/home_provider.dart';
import 'package:bkuk_tv_app/src/feature/home/view/screens/home_detail_screen.dart';
import 'package:bkuk_tv_app/src/feature/home/view/widgets/home_birthday_card.dart';
import 'package:bkuk_tv_app/src/feature/home/view/widgets/home_category_card.dart';
import 'package:bkuk_tv_app/src/feature/home/view/widgets/home_social_card.dart';
import 'package:bkuk_tv_app/src/feature/widgets/date_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with WidgetsBindingObserver {
  Timer? _midnightTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scheduleMidnightRefresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _midnightTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(homeProvider.notifier).getAllBirthdays();
    }
  }

  void _scheduleMidnightRefresh() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    final duration = midnight.difference(now);

    _midnightTimer = Timer(duration, () {
      print("getAllBirthdays");
      ref.read(homeProvider.notifier).getAllBirthdays();
      _scheduleMidnightRefresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/home_background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 54.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20.h,
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 36.h),
                          GestureDetector(
                            onLongPress: () => _showRestartDialog(context),
                            child: SvgPicture.asset('assets/icons/bkuk_logo.svg', height: 100.w),
                          ),
                          Spacer(),
                          Text(
                            'BIRLASHGAN KASABA \nUYUSHMASI TASHKILOTI',
                            style: TextStyle(color: Colors.white, fontSize: 42.sp, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 120.w,
                            child: Divider(color: const Color(0xFFE7B96E), thickness: 1),
                          ),
                          Text(
                            'Yurt taraqqiyoti yo‘lida birlashaylik!'.toUpperCase(),
                            style: TextStyle(color: Color(0xFFE7B96E), fontSize: 20.sp, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: DateTimeWidget(onDoubleTap: () => _showPasswordDialog(context, ref)),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 20.w,
                      children: menus.map((item) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width / 6.5,
                          child: AspectRatio(
                            aspectRatio: 3 / 4,
                            child: HomeCategoryCard(
                              icon: item.icon,
                              title: item.title,
                              onTap: () async {
                                await notifier.changeMenu(item.id);
                                if (context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return HomeDetailScreen();
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                Expanded(
                  flex: 3,
                  child: Row(
                    spacing: 20.w,
                    children: [
                      Expanded(
                        flex: 4,
                        child: HomeBirthdayCard(
                          employees: state.birthdayItems
                              .where((e) {
                                final now = DateTime.now();
                                return e.birthDate.day == now.day && e.birthDate.month == now.month;
                              })
                              .map(
                                (e) => {
                                  "image": e.imagePath,
                                  "birthdayImage": e.birthdayImagePath,
                                  "firstName": e.firstName,
                                  "lastName": e.lastName,
                                  "middleName": e.middleName,
                                  "department": e.department,
                                },
                              )
                              .toList(),
                        ),
                      ),
                      Expanded(flex: 1, child: HomeSocialCard()),
                    ],
                  ),
                ),

                SizedBox(height: 4.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showPasswordDialog(BuildContext context, WidgetRef ref) {
  final controller = TextEditingController();
  bool _obscure = true;
  String? _errorText;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            title: const Text("Admin paroli"),
            content: TextField(
              controller: controller,
              obscureText: _obscure,
              onChanged: (_) => setState(() => _errorText = null),
              decoration: InputDecoration(
                hintText: "Parol",
                errorText: _errorText,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                suffixIcon: IconButton(
                  icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Bekor qilish")),
              ElevatedButton(
                onPressed: () {
                  if (controller.text == 'bkuk_ung_2026') {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => AdminHomeScreen())).then((e) {
                      ref.read(homeProvider.notifier).getAllBirthdays();
                    });
                  } else {
                    setState(() => _errorText = "Parol noto'g'ri!");
                  }
                },
                child: const Text("Kirish"),
              ),
            ],
          );
        },
      );
    },
  );
}

void _showRestartDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 32.w,
        children: [
          /// YOPISH
          IconButton.filled(
            onPressed: () => exit(0),
            icon: Icon(Icons.power_settings_new_rounded, size: 74.sp,),
            color: Colors.white,
            style: IconButton.styleFrom(
              backgroundColor: Colors.red,
              shape: ContinuousRectangleBorder(borderRadius: BorderRadiusGeometry.circular(32.r))
            ),
            tooltip: "Ilovani yopish",
          ),

          /// QAYTA ISHGA TUSHIRISH
          IconButton.filled(
            onPressed: () async {
              final executablePath = Platform.resolvedExecutable;
              await Process.start(executablePath, []);
              exit(0);
            },
            icon: Icon(Icons.refresh_rounded, size: 74.sp,),
            color: Colors.white,
            style: IconButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: ContinuousRectangleBorder(borderRadius: BorderRadiusGeometry.circular(32.r))
            ),
            tooltip: "Qayta ishga tushirish",
          ),
        ],
      ),
    ),
  );
}
