import 'package:cookingrecipes/globals.dart';
import 'package:cookingrecipes/popups/popupmanager.dart';
import 'package:cookingrecipes/view/services/apicallviewmodel.dart';
import 'package:cookingrecipes/view/services/apimanager.dart';
import 'package:cookingrecipes/widgets/buttonwidget.dart';
import 'package:cookingrecipes/widgets/textfieldwidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({super.key});

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  TextEditingController oldPasswdController = TextEditingController(text: "");
  TextEditingController passwdController = TextEditingController(text: "");
  late ResponseModel response;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globals.mainColor,
      appBar: AppBar(
        title: Text("Parola değiştir"),
      ),
      body: Container(
        width: 100.w,
        height: 80.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFieldWidget(oldPasswdController, "Eski parola",isObscure: true),
            SizedBox(height: 15,),
            TextFieldWidget(passwdController,"Yeni parola",isObscure: true),
            SizedBox(height: 30,),
            ButtonWidget("Parolayı değiştir",(){
              ApiCallViewModel().changePasswd(Globals.email, passwdController.text, oldPasswdController.text).then((response) {
                if(response.error == null){
                  PopUpManager().donePopup(context, (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                  },doneText: "Parola başarılı bir şekilde kaydedilmiştir."
                  );
                }
                else{
                  PopUpManager().errorPopup(context, response.data["message"]);
                }
              });
            })
          ]
        ),
      ),
    );
  }
}