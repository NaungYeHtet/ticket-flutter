import 'package:flutter/material.dart';
import 'package:ticketing_system/config/size_config.dart';
import 'package:ticketing_system/dashboard.dart';
import 'package:ticketing_system/login.dart';
import 'package:ticketing_system/middlewares/guest.dart';
import 'package:ticketing_system/register.dart';
import 'package:ticketing_system/style/colors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: AppColors.primaryBg),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const GuestMiddleware(child: RegisterPage()),
      },
      home: Dashboard(), // Use the LoginPage widget as the home page
    );
  }
}
