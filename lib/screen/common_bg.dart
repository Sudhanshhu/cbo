import 'package:cbo_employee/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../utils/const.dart';

class CommonBackground extends StatelessWidget {
  final String title;
  final bool isBackBtnEnabled;
  final Widget child;
  final List<Widget> actionWidget;
  CommonBackground(
      {Key? key,
      required this.title,
      required this.child,
      required this.actionWidget,
      required this.isBackBtnEnabled})
      : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    User? user = authProvider.getuser();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: _key,
        body: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: AppConst.primaryColor,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Row(
                        children: [
                          if (user != null &&
                              user.photoURL != null &&
                              user.photoURL!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadiusDirectional.circular(16),
                                child: CircleAvatar(
                                    radius: 30,
                                    child: Image.network(
                                      user.photoURL!,
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            ),
                          Expanded(
                            child: Center(
                                child: Text(title,
                                    style: GoogleFonts.notoSans(fontSize: 26))),
                          ),
                          Row(children: actionWidget),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: double.maxFinite,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: child,
                      ),
                    )
                  ],
                )),
            if (isBackBtnEnabled)
              Positioned(
                  height: 220,
                  right: 2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.black12,
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
