import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../utils/const.dart';
import '../utils/show_msg_utils.dart';

class LogOutBtn extends StatelessWidget {
  const LogOutBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Provider.of<AuthProvider>(context, listen: false).signOut();

        Navigator.of(context).pop();
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppConst.secondaryColor,
            border: Border.all(),
            borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Title(
            color: Colors.black,
            child: const Text("Log Out"),
          ),
        ),
      ),
    );
  }
}

class GmailButton extends StatelessWidget {
  final AuthProvider authProvider;
  const GmailButton({super.key, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.redAccent,
      onTap: () async {
        try {
          final String uid = await authProvider.googleSignIn();
          if (uid.isNotEmpty) {
          } else {}
        } catch (e) {
          ShowMsgUtils.showsnackBar(title: "Something went wrong");
        }
        // do something when the button is pressed
      },
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(
                  "assets/gmail1.png",
                  fit: BoxFit.fill,
                )),
            const SizedBox(width: 18),
            const Text(
              'Sign in with Gmail',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
