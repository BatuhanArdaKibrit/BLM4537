import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextFieldWidget extends StatefulWidget {
  TextEditingController controller;
  String hintText;
  String iconPath;
  int width;
  int height;
  int maxLines;
  BorderRadius radius;
  TextStyle? style;
  TextStyle? hintStyle;
  bool isObscure;
  bool noBorder;
  bool isHaveEye;
  Widget? endEyeItem;
  Color bgColor;
  bool canNotBeEmpty;
  bool isEnable;
  String errorText;
  bool isCounterEnable;
  int maxLength;
  int minLenght;
  bool checkMinLenght;
  bool textOnly;
  bool numberOnly;
  bool emailValidator;
  bool passwordValidator;
  TextFieldWidget(
    this.controller,
    this.hintText, {
    this.width = 90,
    this.height = 6,
    this.maxLines = 1,
    this.style = null,
    this.hintStyle = null,
    this.radius = BorderRadius.zero,
    this.iconPath = "",
    this.isObscure = false,
    this.isHaveEye = false,
    this.endEyeItem = null,
    this.noBorder = false,
    this.bgColor = Colors.white,
    this.canNotBeEmpty = true,
    this.isEnable = true,
    this.errorText = "This field must be filled out.",
    this.isCounterEnable = false,
    this.maxLength = 5000,
    this.minLenght = 0,
    this.checkMinLenght = false,
    this.textOnly = false,
    this.numberOnly = false,
    this.emailValidator = false,
    this.passwordValidator = false,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool showErrorMessage = false;
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            height: widget.height.h,
            width: widget.width.w,
            decoration: BoxDecoration(
                color: widget.bgColor,
                borderRadius: widget.radius == BorderRadius.zero
                    ? BorderRadius.all(Radius.circular(10))
                    : widget.radius),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                widget.iconPath != ""
                    ? Row(
                        children: [
                          Container(
                            width: 15.w,
                            height: 14.w,
                            decoration: const BoxDecoration(
                              color: Color(0xAAfafafa),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                widget.iconPath,
                                height: 22,
                                // scale: 22,
                              ),
                            ),
                          ),
                          Container(
                            height: 14.w,
                            width: 1,
                            color: Colors.grey,
                          )
                        ],
                      )
                    : Container(),
                TextFormField(
                    enabled: widget.isEnable,
                    maxLines: widget.maxLines,
                    maxLength: widget.maxLength,
                    controller: widget.controller,
                    obscureText: widget.isObscure,
                    validator: (value) {
                      if (widget.canNotBeEmpty) {
                        if (value!.isEmpty) {
                          setState(() {
                            showErrorMessage = true;
                          });
                          return "";
                        } else {
                          setState(() {
                            showErrorMessage = false;
                          });
                        }

                        if (widget.emailValidator &&
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          setState(() {
                            showErrorMessage = true;
                          });
                          return "";
                        }

                        if (widget.passwordValidator &&
                            !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{8,}$')
                                .hasMatch(value)) {
                          setState(() {
                            showErrorMessage = true;
                          });
                          return "";
                        }

                        return null;
                      } else {
                        if (value!.length != 0 &&
                            widget.checkMinLenght &&
                            (value.length < widget.minLenght)) {
                          setState(() {
                            showErrorMessage = true;
                          });
                          return "";
                        } else {
                          setState(() {
                            showErrorMessage = false;
                          });
                          return null;
                        }
                      }
                    },
                    onChanged: (value) {
                      // validator(value);
                      setState(() {
                        counter = value.length;
                      });
                    },
                    style: widget.style != null
                        ? widget.style
                        : TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 1.6.h),
                      border: OutlineInputBorder(
                        borderSide: widget.noBorder
                            ? BorderSide.none
                            : BorderSide(color: Colors.grey),
                        borderRadius: widget.radius == BorderRadius.zero
                            ? BorderRadius.circular(10.0)
                            : widget.radius,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      prefix: Container(
                        width: widget.iconPath != "" ? 17.w : 5.w,
                        height: 0.h,
                      ),
                      // errorStyle: const TextStyle(fontSize: 0.01),
                      // helperText: ' '
                      errorStyle: TextStyle(height: 0),
                      hintText: widget.hintText,
                      // hintStyle: widget.hintStyle != null
                      //     ? widget.hintStyle
                      //     : AppDesign.hintStyle,
                      counterText: "",
                    )),
                widget.isHaveEye
                    ? Positioned(
                        right: 3.w,
                        top: 2.h,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.isObscure = !widget.isObscure;
                            });
                          },
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          SizedBox(height: 3),
          showErrorMessage
              ? SizedBox(
                  width: widget.width.w,
                  child: Text(
                    widget.errorText,
                    maxLines: 2,
                    style: TextStyle(color: Colors.redAccent, fontSize: 10.sp),
                  ),
                )
              : Container(),
          widget.isCounterEnable
              ? SizedBox(
                  width: widget.width.w,
                  child: Text(
                    counter.toString() + "/" + widget.maxLength.toString(),
                    maxLines: 2,
                    style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
