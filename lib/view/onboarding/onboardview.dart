import 'package:cookingrecipes/globals.dart';
import 'package:cookingrecipes/view/base.dart';
import 'package:cookingrecipes/view/signinview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnBoardView extends StatefulWidget {
  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView> {
  int pageIndex = 0;

  List<String> imgList = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
  ];

  List<String> titleList = [
    'Kurtarıcınıza\nHoş Geldiniz!',
    'Yerel tarifleri\nkeşfet',
    'Onyalanmış\nbinlerce tarif',
  ];

  List<String> subTitleList = [
    'Mutfak maceranız\nburada başlıyor.',
    'En sevdiğiniz yemeği\nbulabilirsiniz.',
    'Hepsi en güzel lezzetiyle.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imgList[pageIndex]),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7.h),
            SizedBox(
              width: 90.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignInView()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Atla",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    SizedBox(width: 2.w),
                    Container(
                      width: 30,
                      height: 30,
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Globals.buttonColor),
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            Text(
              titleList[pageIndex],
              style: TextStyle(
                  fontSize: 22.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              subTitleList[pageIndex],
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                pageIndex != 0
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            pageIndex--;
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.white,
                            size: 25,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Globals.mainColor),
                        ),
                      )
                    : Container(),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (pageIndex == 2) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => SignInView()));
                      } else {
                        pageIndex++;
                      }
                    });
                  },
                  child: pageIndex == 2
                      ? Container(
                          width: 160,
                          height: 40,
                          child: Center(
                            child: Text(
                              "Tarifleri gör",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.sp),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Globals.mainColor),
                        )
                      : Container(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Globals.mainColor),
                        ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    ));
  }
}
