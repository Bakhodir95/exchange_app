import 'package:exchange_app/src/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 480),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ExchangeRateScreen(),
      ),
    );
  }
}
