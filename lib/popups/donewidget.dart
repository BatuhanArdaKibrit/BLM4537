import 'package:cookingrecipes/widgets/buttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DoneWidget extends StatefulWidget {
  String text;
  Function doneFun;
  DoneWidget(this.text, this.doneFun);

  @override
  State<DoneWidget> createState() => _DoneWidgetState();
}

class _DoneWidgetState extends State<DoneWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 40.h,
      child: Column(
        children: [
          Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(30.0),
                  topRight: const Radius.circular(30.0),
                )),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 2.h),
                  width: 10.w,
                  height: 4,
                  decoration: new BoxDecoration(
                      color: Color(0xffdbdbdb),
                      borderRadius: new BorderRadius.all(Radius.circular(20))),
                ),
                SizedBox(height: 3.h),
                SvgPicture.asset(
                  "assets/svg/popupicons/doneicon.svg",
                  height: 12.h,
                ),
                SizedBox(height: 2.h),
                Container(
                    width: 100.w,
                    child: Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Color(0xff4d4d4e), fontSize: 14.sp),
                    )),
                SizedBox(height: 3.h),
                ButtonWidget("Tamam", widget.doneFun),
              ],
            ),
          ),
        ],
      ),
    );
  }
}