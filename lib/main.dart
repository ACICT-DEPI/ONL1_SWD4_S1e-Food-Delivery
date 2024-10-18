import 'dart:io';

import 'package:delivery_food_app/common/color_extension.dart';
import 'package:delivery_food_app/common/locator.dart';
import 'package:delivery_food_app/firebase_options.dart';
import 'package:delivery_food_app/view/login/welcome_view.dart';
import 'package:delivery_food_app/view/main_tabview/main_tabview.dart';
import 'package:delivery_food_app/view/on_boarding/startup_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'common/globs.dart';
import 'common/my_http_overrides.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setUpLocator();
  runApp(const MyApp(
    defaultHome: WelcomeView(),
  ));
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 5.0
    ..progressColor = TColor.primaryText
    ..backgroundColor = TColor.primary
    ..indicatorColor = Colors.yellow
    ..textColor = TColor.primaryText
    ..userInteractions = false
    ..dismissOnTap = false;
}

final GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => NavigationService());
}

class MyApp extends StatefulWidget {
  final Widget defaultHome;
  const MyApp({super.key, required this.defaultHome});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery',
      debugShowCheckedModeBanner: false,

      themeMode: ThemeMode.dark, // Ensures the dark theme is used

      // Define the light theme (if needed)
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        // Add more light theme configurations if needed
      ),

      // Define the dark theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: TColor.primary, 
        scaffoldBackgroundColor: Colors.black, 
        cardColor: Colors.grey[900], 
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: TColor.primaryText),
        ),
        textTheme: TextTheme(
          bodyText1:
              TextStyle(color: TColor.primaryText), 
          bodyText2: TextStyle(color: TColor.primaryText),
          
        ),
        // Define more colors and styles if needed
      ),

      home: FutureBuilder<String?>(
        future: getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data != null) {
            return const MainTabView();
          } else {
            return const WelcomeView();
          }
        },
      ),

      builder: (context, child) {
        return FlutterEasyLoading(child: child);
      },
    );
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }
}
