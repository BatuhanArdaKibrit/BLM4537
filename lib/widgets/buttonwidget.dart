import 'package:cookingrecipes/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ButtonWidget extends StatelessWidget {
  Function fun;
  String text;
  Color bgColor;
  Color? textColor;
  double? width;
  double? height;
  double? textSize;
  bool isBold;
  bool isHaveBorder;
  Color? borderColor;
  String svgIconPath;
  Widget endWidget;
  BorderRadius? borderRadius;
  BoxDecoration? decoration;

  ButtonWidget(this.text, this.fun,
      {this.bgColor = Colors.white,
      this.textColor = const Color(0xffc71e38),
      this.width,
      this.height,
      this.textSize,
      this.isBold = true,
      this.isHaveBorder = false,
      this.borderColor,
      this.borderRadius,
      this.endWidget = const SizedBox(),
      this.svgIconPath = "",
      this.decoration = null});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: SizedBox(
        height: height ?? 5.h,
        width: width ?? 90.w,
        child: TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                svgIconPath != "" ? SvgPicture.asset(
                  svgIconPath,
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                  color: textColor == null ? Colors.white : textColor,
                ) : SizedBox(),
                svgIconPath != "" ? SizedBox(width: 3.w) : SizedBox(),
                Text(text,
                    style: TextStyle(
                        fontSize: textSize == null ? 16.sp : textSize,
                        fontWeight:
                            isBold ? FontWeight.w600 : FontWeight.normal,
                        color: textColor == null ? Colors.white : textColor)),
                endWidget
              ],
            ),
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(
                  left: 1.w,
                  right: 1.w,
                )),
                backgroundColor: MaterialStateProperty.all<Color>(bgColor),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        side: BorderSide(
                            color: isHaveBorder
                                ? borderColor ?? Colors.white
                                : Colors.transparent,
                            width: isHaveBorder ? 1 : 0,
                            style: BorderStyle.solid),
                        borderRadius:
                            borderRadius ?? BorderRadius.circular(10.0)))),
            onPressed: () => {fun()}),
      ),
    );
  }
}
