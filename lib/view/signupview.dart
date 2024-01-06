import 'package:cookingrecipes/globals.dart';
import 'package:cookingrecipes/popups/popupmanager.dart';
import 'package:cookingrecipes/view/services/apicallviewmodel.dart';
import 'package:cookingrecipes/view/signinview.dart';
import 'package:cookingrecipes/widgets/buttonwidget.dart';
import 'package:cookingrecipes/widgets/textfieldwidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController nameController = TextEditingController(text: "");

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
          TextFieldWidget(nameController, "Ad-Soyad"),
          SizedBox(height: 3.h),
          TextFieldWidget(emailController, "Email"),
          SizedBox(height: 3.h),
          TextFieldWidget(isObscure:true,passwordController, "Parola"),
          SizedBox(height: 3.h),
          ButtonWidget("Kayıt ol", () {
            ApiCallViewModel()
                .postSignUp(nameController.text, emailController.text,
                    passwordController.text)
                .then((response) {
              if(response.error == null){
              PopUpManager().donePopup(context,(){Navigator.pop(context);
                   Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => SignInView()));
              },doneText: "Kullanıcı başarıyla kaydedilmiştir");
         
              }else{
                PopUpManager().errorPopup(context, response.data["message"]);
              }
            });
          }),
          SizedBox(height: 5.h),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SignInView()));
            },
            child: Text("Giriş ekranı",
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
