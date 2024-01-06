
import 'package:cookingrecipes/widgets/buttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class ErrorPanelWidget extends StatefulWidget {
  String text;
  bool colorGray;
  ErrorPanelWidget(this.text, {this.colorGray = false});

  @override
  State<ErrorPanelWidget> createState() => _ErrorPanelWidgetState();
}

class _ErrorPanelWidgetState extends State<ErrorPanelWidget> {
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
                Padding(
                  padding: EdgeInsets.only(top: 1.5.h),
                  child: Container(
                    width: 10.w,
                    height: 4,
                    decoration: new BoxDecoration(
                        color: Color(0xffdbdbdb),
                        borderRadius:
                            new BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                SizedBox(height: 3.h),
                SvgPicture.asset(
                  widget.colorGray
                      ? "assets/svg/popupicons/erroricon3.svg"
                      : "assets/svg/popupicons/erroricon1.svg",
                  height: 12.h,
                ),
                SizedBox(height: 2.h),
                Container(
                    width: 100.w,
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Color(0xff4d4d4e), fontSize: 13.sp),
                    )),
                SizedBox(height: 3.h),
                ButtonWidget("Tamam", () => {Navigator.pop(context)})
              ],
            ),
          ),
        ],
      ),
    );
  }
}
