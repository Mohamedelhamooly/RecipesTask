import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posts_task/Const/const.dart';
import 'package:posts_task/layers/presentation/pages/recipesList/recipesList.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController();
  bool save = false;
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    emailController.text = "mohamedelhamooly@gmail.com";
    passwordController.text = "12345";
  }

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height / 2.5,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
                color: kPrimaryColor,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: size.height / 3.4, left: 15, right: 15),
              child: StatefulBuilder(builder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30), color: kWhite),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 25, right: 10, bottom: 20),
                    child: Form(
                      key: globalKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: kInputDecoration.copyWith(
                              hintText: "enter Email Or Phone",
                              labelText: "enter Email Or Phone",
                            ),
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "emptyEmail";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "enter Pass";
                              }
                              return null;
                            }, //Optional
                            obscureText: hidePassword,
                            decoration: kInputDecoration.copyWith(
                              hintText: "password",
                              labelText: "password",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                icon: Icon(
                                  hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: kIconColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height / 30),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 100),
                                  backgroundColor: kPrimaryColor,
                                  textStyle: kTextStyle.copyWith(
                                      color: kWhite,
                                      fontWeight: FontWeight.bold),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  )),
                              onPressed: () {
                                if (validateAndSave()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RecipesList()),
                                  );
                                }
                              },
                              child: Text(
                                "signIn",
                                style: kTextStyle.copyWith(color: kWhite),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height / 20),
                          // Row(children: <Widget>[
                          //   Expanded(
                          //     child: Container(
                          //         margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                          //         child: const Divider(
                          //           color: kBorderColorTextField,
                          //           height: 50,
                          //         )),
                          //   ),
                          //   Text(
                          //     lang.S.of(context).orLogInWith,
                          //     style: kTextStyle.copyWith(color: kSubSubTitleColor),
                          //   ),
                          //   Expanded(
                          //     child: Container(
                          //         margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                          //         child: const Divider(
                          //           color: kBorderColorTextField,
                          //           height: 50,
                          //         )),
                          //   ),
                          // ]),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Image.asset(
                          //       'images/facebook.png',
                          //       width: 28,
                          //       height: 28,
                          //       fit: BoxFit.cover,
                          //     ),
                          //     const SizedBox(width: 20),
                          //     Image.asset(
                          //       'images/apple.png',
                          //       width: 28,
                          //       height: 28,
                          //       fit: BoxFit.cover,
                          //     ),
                          //     const SizedBox(width: 20),
                          //     Image.asset(
                          //       'images/google.png',
                          //       width: 28,
                          //       height: 28,
                          //       fit: BoxFit.cover,
                          //     )
                          //   ],
                          // ),
                          SizedBox(height: size.height / 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "youDontHave",
                                style: kTextStyle.copyWith(
                                    color: kSubSubTitleColor),
                              ),
                              GestureDetector(
                                child: Text(
                                  "signUp",
                                  style: kTextStyle.copyWith(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  validateAndSave();
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      if (emailController.text != "mohamedelhamooly@gmail.com" || passwordController.text != "12345")
        {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("wrong pass or email"),
          ));
          return false;
        }
      return true;
    }
    return false;
  }
}
