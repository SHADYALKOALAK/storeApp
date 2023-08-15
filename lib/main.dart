import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:storeonline/providers/language_provider.dart';
import 'package:storeonline/screens/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => LanguageProvider()),
          ],
          child: const MyMaterialApp(),
        );
      },
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, lang, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: const Color(0xff40BFFF)),
          home: const SplashScreen(),
          locale: Locale(lang.language),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: const [
            Locale('ar'),
            Locale('en'),
          ],
        );
      },
    );
  }
}
