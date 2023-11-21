import 'package:alandalos/screens/splash_screen/splash_screen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/resources/app_colors.dart';
import 'firebase_notification/notification_services.dart';
import 'main.dart';
BuildContext? appContext;
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.requestPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.getDeviceToken();
  }
  @override
  Widget build(BuildContext context) {
    appContext = context;
    return MaterialApp(
      color:Theme.of(context).scaffoldBackgroundColor,
      localizationsDelegates: [
        CountryLocalizations.delegate, ...context.localizationDelegates,
      ],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Alandalos',
      theme: Theme.of(context).copyWith(
        textTheme: GoogleFonts.almaraiTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: AppColors.colorPrimary,
        ),
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: const SplashScreen(),
    );
  }
}

