// ignore_for_file: sort_child_properties_last

import 'dart:convert';
import 'dart:typed_data';

import 'package:cookingrecipes/globals.dart';
import 'package:cookingrecipes/model/recipemodel.dart';
import 'package:cookingrecipes/popups/popupmanager.dart';
import 'package:cookingrecipes/view/editrecipe.dart';
import 'package:cookingrecipes/view/services/apicallviewmodel.dart';
import 'package:cookingrecipes/widgets/buttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FoodDetail extends StatefulWidget {
  int foodId;
  FoodDetail({required this.foodId});

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  RecipeModel? recipe;
  late int foodId;
  late Uint8List image;
  late List<String>ingredients;
  late bool isOwner;

  @override
  void initState() {
    setState(() {
      foodId = widget.foodId;
    });
    ApiCallViewModel().checkOwner(foodId).then((value) {
      if(value != null){
      setState(() {
          isOwner = value == Globals.email ? true : false;
      });
      }else{
        setState(() {
          isOwner = false;
        });
      }
    });
    ApiCallViewModel().getFoodDetail(Globals.email,foodId).then((value) {
      if(value != null){
        setState(() {
          recipe = value;
          image = base64Decode(recipe!.image);
          ingredients = recipe!.ingredients.split(',');
        });
      }else{
        setState(() {
          recipe = null;
          image = Uint8List(0);
          ingredients = [];
        });
      }
    });
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: recipe != null ? SingleChildScrollView(
        child: Column(
          children: <Widget>[
          Container(
            width: 100.w,
            height: 30.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(image),
                fit: BoxFit.cover,
              )
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              padding: EdgeInsets.all(10.0),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe!.name,
                          style: TextStyle(color: Colors.white,fontSize: 18.sp),
                        ),
                        Text(
                          recipe!.type,
                          style: TextStyle(color: Colors.white70),
                        )
                      ]
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: LikeButton()
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Globals.mainColor,
                      ),
                      child: Center(
                        child: IconButton(
                          color: Colors.white,
                          onPressed:() {
                            Navigator.of(context).pop({
                              "recipe":recipe,
                              "image":image
                            });
                          },
                          icon: Icon(Icons.arrow_back),
                          iconSize: 20.0,
                        ),
                      ),
                    ),
                  )  
                ],
              )
            ),
          ),
          Container(
            width: 90.w,
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.only(bottom: 10.0,top: 10.0),
            child: Column(
              children: <Widget>[
                Text("Malzemeler",style: TextStyle(fontSize: 17.sp,color: Globals.mainColor)),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: ingredients.map((String ingredient) {
                      return Chip(
                        label: Text(ingredient),
                      );                   
                  }).toList(),
                ),
                SizedBox(height: 1.h,),
                Container(height: 1,width: 100.w,color: Colors.grey),
                SizedBox(height: 1.h,),
                Text("Tarif",style: TextStyle(fontSize: 17.sp,color: Globals.mainColor)),
                Text("${recipe!.recipe}" )
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black,width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
          ),
          isOwner ? Container(
            width: 100.w,
            margin: EdgeInsets.only(bottom: 40.0),
            child: Row(
              children: [
                ButtonWidget("Tarifi Sil", (){
                  PopUpManager().confirmPopup(context, (){
                    ApiCallViewModel().deleteRecipe(foodId).then((value) {
                      if(value){
                        Navigator.of(context).pop();
                        Navigator.of(context).pop({
                          "isDeleted":true
                        });
                      }else{
                        Navigator.of(context).pop();
                        PopUpManager().errorPopup(context, "Silmeye çalışırken bir hata meydana geldi.");
                      }
                    });
                  },
                  (){
                    Navigator.of(context).pop();
                  },acceptText: "Tarifi sil",
                  declineText: "İptal",
                  text: "Tarif silindiği zaman bir daha erişilemeyecektir\nEmin misiniz."
                  );
                },width: 50.w,
                ),
                ButtonWidget("Tarifi düzenle", ()async{
                  var result = await Navigator.of(context).push(MaterialPageRoute(builder: ((context) => EditRecipeWidget(foodId: foodId,))));
                  if(result!= null && result["isChanged"] != null){
                    ApiCallViewModel().getFoodDetail(Globals.email,foodId).then((value) {
                      if(value != null){
                        setState(() {
                          recipe = value;
                          image = base64Decode(recipe!.image);
                          ingredients = recipe!.ingredients.split(',');
                        });
                      }
                    });
                  }
                  

                }
                ,width: 50.w,),
              ],
            ),
          ) : SizedBox()
          ],
        ),
      ) :  
      Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
          
  }

  Widget LikeButton(){
  return GestureDetector(
    onTap: () {
      recipe!.isLiked ? 
        ApiCallViewModel().dislikeFood(Globals.email, recipe!.id): 
        ApiCallViewModel().likeFood(Globals.email, recipe!.id);
      
      setState(() {
        recipe!.isLiked = !(recipe!.isLiked);
      });
      
      
    },
    child: Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: recipe!.isLiked ? Globals.buttonColor : Globals.unselectButtonColor,
      ),
      child: Center(
              child: Icon(
                recipe!.isLiked? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
            ),
        ),
      );
  }
}



