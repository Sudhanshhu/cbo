import 'package:cbo_employee/screen/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../provider/auth_provider.dart';
import '../../utils/const.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_clipper.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return StreamBuilder<User?>(
            stream: authProvider.authListener(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  authProvider.status == Status.Authenticating) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Text("Something went wrong Error is ${snapshot.error}");
              }
              if (snapshot.hasData) {
                // Navigator.of(context).pushNamed("homePage");
                return const HomePage();
              } else {
                // Navigator.of(context).pushNamed("googleSignInPage");
                return
                    // Container();
                    Column(
                  children: [
                    ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        height: 200,
                        color: AppConst.primaryColor,
                      ),
                    ),
                    const Spacer(),
                    GmailButton(authProvider: authProvider),
                    const Spacer(),
                    Center(
                      child: Text("please Sign in to continue",
                          style: GoogleFonts.lobster(fontSize: 25)),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                  ],
                );
              }
              // return Text("Loading");
            },
          );
        },
        // child:

        // authProvider.user == null
        //     ? Column(
        //         children: [
        //           const SizedBox(height: 150),
        //           Center(
        //               child: OutlinedButton(
        //                   onPressed: () async {
        //                     final String uid =
        //                         await authProvider.googleSignIn();
        //                     if (uid.isNotEmpty) {
        //                       print("Authenticated");
        //                     } else {
        //                       print("Not Authenticated");
        //                     }
        //                   },
        //                   child: const Text("Sign in with Gmail"))),
        //           Text(authProvider.status.toString()),
        //           Text(authProvider.user.toString()),
        //         ],
        //       )
        //     :
      ),
    );
  }
}
