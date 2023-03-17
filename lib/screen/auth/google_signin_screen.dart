// import 'package:cbo_employee/provider/auth_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../common_bg.dart';

// class GoogleSignInPage extends StatelessWidget {
//   static const routeName = "googleSignInPage";
//   const GoogleSignInPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var authProvider = Provider.of<AuthProvider>(context, listen: false);
//     return CommonBackground(
//       title: "Sign In to continue",
//       actionWidget: const [],
//       isBackBtnEnabled: true,
//       child: Column(children: [
//         OutlinedButton(
//             onPressed: () async {
//               final String uid = await authProvider.googleSignIn();
//               if (uid.isNotEmpty) {
//                 print("Authenticated");
//               } else {
//                 print("Not Authenticated");
//               }
//             },
//             child: const Text("Sign in with google"))
//       ]),
//     );
//   }
// }
