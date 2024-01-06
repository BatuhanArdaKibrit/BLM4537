import 'package:cookingrecipes/globals.dart';
import 'package:cookingrecipes/popups/popupmanager.dart';
import 'package:cookingrecipes/view/base.dart';
import 'package:cookingrecipes/view/services/apicallviewmodel.dart';
import 'package:cookingrecipes/view/signupview.dart';
import 'package:cookingrecipes/widgets/buttonwidget.dart';
import 'package:cookingrecipes/widgets/textfieldwidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globals.mainColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Cooking Recipes",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 5.h),
          TextFieldWidget(emailController, "Email"),
          SizedBox(height: 3.h),
          TextFieldWidget(isObscure: true, passwordController, "Parola"),
          SizedBox(height: 3.h),
          ButtonWidget("Giriş", () {
            ApiCallViewModel()
                .postSignIn(emailController.text, passwordController.text)
                .then((response) {
              if (response.error == null) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => BaseView()));
              } else {
                PopUpManager().errorPopup(context, response.data["message"]);
              }
            });
          }),
          SizedBox(height: 5.h),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SignUpView()));
            },
            child: Text("Kayıt ol",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
