import 'package:app/core/theme/app_palette.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/features/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppPalette.backgroundColor,
      // statusBarBrightness: Brightness.light,
      // statusBarIconBrightness: Brightness.light,
      // systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Howiya Press',
        theme: AppTheme.lightTheme,
        home: const HomePage(),
      ),
    );
  }
}
