import 'package:cbo_employee/provider/auth_provider.dart';
import 'package:cbo_employee/screen/common_bg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/show_msg_utils.dart';
import '../../widget/custom_text_form.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "signUpScreen";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pswdController = TextEditingController();
  TextEditingController confirmPswdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    pswdController.dispose();
    confirmPswdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      title: "Sign Up ",
      actionWidget: const [],
      isBackBtnEnabled: true,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 150),
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
                      CustomTextForm(
                          controller: confirmPswdController,
                          validator: (String? value) {
                            if (value != pswdController.text) {
                              return "password does not match";
                            }
                            return null;
                          },
                          hintText: "Confirm password "),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an Account"),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Sign In"))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            var isValid = _formKey.currentState!.validate();
                            if (!isValid) {
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              await Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: pswdController.text,
                                      signUp: true);
                              ShowMsgUtils.showsnackBar(
                                  title: "Successfully Login",
                                  color: Colors.green);
                              if (mounted) {
                                Navigator.of(context).pop();
                              }
                              // if (uid.isNotEmpty) {
                              // } else {}
                            } catch (e) {
                              ShowMsgUtils.showsnackBar(
                                  title: "Something went wrong");
                            }
                          },
                          child: const Text("Sign Up")),
                    ],
                  )),
            ),
    );
  }
}
