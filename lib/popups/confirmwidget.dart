import 'package:cookingrecipes/widgets/buttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ConfirmWidget extends StatefulWidget {
  String text;
  String acceptText;
  String declineText;
  Function acceptFun;
  Function declineFun;
  ConfirmWidget(this.text,this.acceptText,this.acceptFun,this.declineText,this.declineFun);

  @override
  State<ConfirmWidget> createState() => _ConfirmWidgetState();
}

class _ConfirmWidgetState extends State<ConfirmWidget> {
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
                  "assets/svg/popupicons/exclamation.svg",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(widget.declineText, widget.declineFun,width:100,),
                    SizedBox(width: 3.w,),
                    ButtonWidget(widget.acceptText, widget.acceptFun,width:100,),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}