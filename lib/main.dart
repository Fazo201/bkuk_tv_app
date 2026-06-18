import 'package:bkuk_tv_app/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await windowManager.ensureInitialized();
  
  WindowOptions windowOptions = const WindowOptions(
    title: '', // bo'sh — sarlavha ko'rinmaydi
    titleBarStyle: TitleBarStyle.hidden, // sarlavha paneli yashiriladi
    fullScreen: true, // to'liq ekran
  );
  
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(ProviderScope(child: const App()));
}
