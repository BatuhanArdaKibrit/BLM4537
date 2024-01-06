import 'package:cookingrecipes/popups/confirmwidget.dart';
import 'package:cookingrecipes/popups/donewidget.dart';
import 'package:cookingrecipes/popups/errorpanelwidget.dart';
import 'package:flutter/material.dart';

class PopUpManager {
  
  void donePopup(BuildContext context, Function fun, {String doneText = ""}) {
    doneText == "" ? doneText = "İşlem başarılı bir şekilde gerçekleşmiştir." : "";
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        )),
        builder: (context) {
          return DoneWidget(doneText, fun);
        });
  }

  void errorPopup(BuildContext context, String errorText,
      {bool colorGray = false}) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        )),
        builder: (context) {
          return ErrorPanelWidget(
            errorText,
            colorGray: colorGray,
          );
        });
  }
  void confirmPopup(BuildContext context,Function acceptFun,Function declineFun,
  {String text = "Emin misiniz",String acceptText = "Onaylıyorum",String declineText = "İptal"}) {
    text == "" ? text = "Emin misiniz" : "";
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        )),
        builder: (context) {
          return ConfirmWidget(text,acceptText,acceptFun,declineText,declineFun);
        });
  }
 
}