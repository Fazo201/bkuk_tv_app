import 'package:bkuk_tv_app/src/feature/home/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
  designSize: const Size(1920, 1080),
  minTextAdapt: true,
  builder: (_, child) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: child,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
    );
  },
  child: const HomeScreen(),
);
  }
}
