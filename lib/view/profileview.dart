import 'package:cookingrecipes/globals.dart';
import 'package:cookingrecipes/view/accountsettings.dart';
import 'package:cookingrecipes/view/signinview.dart';
import 'package:cookingrecipes/widgets/buttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: 100.w,
        child: Column(
            children: <Widget>[
                Container(
                  width: 100.w,
                  height: 30.h,
                  padding: EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    color: Globals.unselectButtonColor,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(60.0)),
                  ),
                  child: SafeArea(child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/icon.png'))
                    ),
                  )),
                ),
                Container(
                  height: 50.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          Globals.name,
                          style: TextStyle(fontSize: 24,color: Globals.mainColor),
                          
                        ),
                        
                      ),
                      Container(
                      margin: EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        Globals.email,
                        style: TextStyle(fontSize: 24,color: Globals.mainColor),
                      ),
                    ),
                    ButtonWidget("Hesabı düzenle", ()async {
                      await Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AccountSettings()));
                      setState((){});
                    },
                      textColor: Colors.white,
                      bgColor: Globals.mainColor,
                    ),
                    SizedBox(height: 50,),
                    ButtonWidget("Çıkış yap", (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => SignInView()));
                    },
                    textColor: Colors.white,
                    bgColor: Globals.mainColor,
                    ),
                    ],
                  ),
                ),
            ]
            ),
      ));
  }
}
