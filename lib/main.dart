// import 'package:cbo_employee/screen/auth/google_signin_screen.dart';
import 'package:cbo_employee/screen/employee_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/auth_provider.dart';
import 'screen/auth/sign_in.dart';
import 'screen/home_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      // builder: ,
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "employeeFormScreen": (context) => const EmployeeFormScreen(),
        "homePage": (context) => const HomePage(),
        // "googleSignInPage": (context) => const GoogleSignInPage(),
      },
      home: const SignInScreen(),
    );
  }
}


// SHA-256: EC:C2:6B:FF:B0:F6:D5:39:1A:CD:99:11:B5:04:AE:C0:FE:CF:8D:04:76:36:90:45:C2:55:AA:50:C0:08:F2:05
// SHA1: 92:16:16:0F:E8:FD:F7:5F:9A:19:7D:A7:6B:EF:FC:04:80:33:00:1D


