// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cookingrecipes/globals.dart';
import 'package:cookingrecipes/popups/popupmanager.dart';
import 'package:cookingrecipes/view/base.dart';
import 'package:cookingrecipes/view/changepassword.dart';
import 'package:cookingrecipes/view/profileview.dart';
import 'package:cookingrecipes/view/services/apicallviewmodel.dart';
import 'package:cookingrecipes/view/signinview.dart';
import 'package:cookingrecipes/widgets/buttonwidget.dart';
import 'package:cookingrecipes/widgets/textfieldwidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  bool isEmailEnable = false;
  bool isNameEnable = false;
  TextEditingController emailController = TextEditingController(text: Globals.email);
  TextEditingController nameController = TextEditingController(text:Globals.name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globals.mainColor,
      appBar: AppBar(
        title: Text("Hesabı düzenle"),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back)),
        ),
      body: SingleChildScrollView(
        child: Container(
          width: 100.w,
          height: 80.h,
          margin: EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFieldWidget(nameController, "Ad-Soyad",isEnable: isNameEnable),
              SizedBox(height:15),
              ButtonWidget("Ad-Soyad düzenle", () {
                setState(() {
                  isNameEnable = !isNameEnable;
                  isEmailEnable = false;
                });
              },
              svgIconPath: isNameEnable ? "assets/svg/edit.svg" : "",
              ),
              SizedBox(height:30),
              TextFieldWidget(emailController, "Email",isEnable: isEmailEnable),
              SizedBox(height:15),
              ButtonWidget("Emaili düzenle", () {
                setState(() {
                  isEmailEnable = !isEmailEnable;
                  isNameEnable = false;
                });
              },
              svgIconPath: isEmailEnable ? "assets/svg/edit.svg" : "",
              ),
              Spacer(),
              ButtonWidget("Kaydet", (){
                setState(() {
                  isEmailEnable = false;
                  isNameEnable = false;
                });
                if(nameController.text != Globals.name){
                  ApiCallViewModel().changeName(nameController.text, Globals.email);
                  Globals.name = nameController.text;
                }
                if(emailController.text != Globals.email){
                  ApiCallViewModel().changeEmail(Globals.email, emailController.text);
                  Globals.email = emailController.text;
                }
                PopUpManager().donePopup(context, (){
                  Navigator.of(context).pop();
                },
                doneText: "Ayarlar başarılı bir şekilde kaydedilmiştir."
                );
              },),
              SizedBox(height: 30,),
              ButtonWidget("Parolayı düzenle", (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChangePasswordWidget()));
              }),
              SizedBox(height: 30,),
              ButtonWidget("Hesabı sil",(){
                PopUpManager().confirmPopup(context,(){
                  ApiCallViewModel().deleteAccount(Globals.email);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignInView()));
                },
                (){
                  Navigator.of(context).pop();
                },
                text: "Hesabınız kalıcı olarak silinecektir emin misiniz?",
                acceptText: "Hesabımı sil",
                declineText: "İptal et",
                );
              },svgIconPath: "assets/svg/warning.svg",
              ),
              SizedBox(height: 120,),

            ]
          ),
        ),
      ),
    );
  }
}