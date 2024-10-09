import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:the_initials/screens/SplashScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await  Hive.initFlutter();

    await Hive.openBox('settingsBox');

    await Supabase.initialize(
        url: 'https://tvlzedhwqzkmdcfmjzmq.supabase.co',
        anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR2bHplZGh3cXprbWRjZm1qem1xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQ0MjI1MTEsImV4cCI6MjAyOTk5ODUxMX0.iqpKNCDX2ZrXBlea-O31wefCfbupTQFTfn7CgMT8XxA');

    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        splitScreenMode: true,
        builder: (builder, child) {
          return const GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'The Initials',
            home: SplashScreen(),
          );
        });
  }
}
