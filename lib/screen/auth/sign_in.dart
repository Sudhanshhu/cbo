import 'package:cbo_employee/screen/home_page.dart';
import 'package:cbo_employee/utils/const.dart';
import 'package:cbo_employee/widget/custom_text_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../provider/auth_provider.dart';
import '../../utils/show_msg_utils.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_clipper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pswdController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pswdController.dispose();

    super.dispose();
  }

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
                print("User is ${authProvider.getuser()}");
                // Navigator.of(context).pushNamed("homePage");
                return const HomePage();
              } else {
                print("User is ${authProvider.getuser()}");
                // Navigator.of(context).pushNamed("googleSignInPage");
                return
                    // Container();
                    SingleChildScrollView(
                  child: SizedBox(
                    height: double.maxFinite,
                    child: Column(
                      children: [
                        ClipPath(
                          clipper: WaveClipper(),
                          child: Container(
                            height: 200,
                            color: const Color.fromARGB(255, 230, 215, 170),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomTextForm(
                            controller: emailController,
                            validator: (String? value) {
                              if (value!.isEmpty || !value.contains("@")) {
                                return "Please enter correct Email";
                              }
                              return null;
                            },
                            hintText: "Enter email "),
                        CustomTextForm(
                            controller: pswdController,
                            validator: (String? value) {
                              if (value!.length < 7) {
                                return "Please enter minimum 7 letter password";
                              }
                              return null;
                            },
                            hintText: "Enter password "),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have Account"),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed("signUpScreen");
                                },
                                child: const Text("Sign Up"))
                          ],
                        ),
                        const SizedBox(height: 40),
                        InkWell(
                          onTap: () async {
                            if (emailController.text.length < 5) {
                              return ShowMsgUtils.showsnackBar(
                                  title: "please enter correct Email addres",
                                  color: Colors.red);
                            }
                            if (pswdController.text.length < 7) {
                              return ShowMsgUtils.showsnackBar(
                                  title: "please enter correct Password",
                                  color: Colors.red);
                            }
                            try {
                              await authProvider.signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: pswdController.text,
                                  signUp: false);
                              // if (uid.isNotEmpty) {
                              // } else {}
                            } catch (e) {
                              ShowMsgUtils.showsnackBar(
                                  title: "Something went wrong");
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: AppConst.primaryColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text("Sign in"),
                              )),
                        ),
                        const SizedBox(height: 30),
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
                    ),
                  ),
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
