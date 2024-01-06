import 'package:cookingrecipes/globals.dart';
import 'package:cookingrecipes/view/onboarding/onboardview.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  void initState() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => OnBoardView()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Globals.mainColor,
        body: Center(
          child: Text(
            'Cooking Recipes',
            style: TextStyle(
              fontSize: 25.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
