// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:ffi';

import 'package:cookingrecipes/globals.dart';
import 'package:cookingrecipes/view/fooddetail.dart';
import 'package:cookingrecipes/view/services/apicallviewmodel.dart';
import 'package:cookingrecipes/widgets/buttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cookingrecipes/model/recipemodel.dart';

import 'dart:convert';
import 'dart:typed_data';

class FoodItem extends StatefulWidget {
  RecipeModel recipe;
  Uint8List image;
  final Function(int)? onDislike; 
  final Function(int) onDelete;
  final Function(int, RecipeModel) onChange;
  FoodItem({super.key,
      required this.recipe,
      this.onDislike,
      required this.onDelete,
      required this.onChange})
    :image = base64Decode(recipe.image);

  @override
  State<FoodItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  late RecipeModel recipe;
  late Uint8List image;
  Function? onDislike;
  late Function onDelete;
  late Function onChange;
    @override
  void initState() {
      setState(() {
        recipe = widget.recipe;
        image = widget.image;
        onDislike = widget.onDislike;
        onDelete = widget.onDelete;
        onChange = widget.onChange;
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h),
        padding: EdgeInsets.all(10),
        decoration: Globals.boxRoundedDecoration(),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 80.w,
                  child: Text(
                    recipe.name,
                    style: TextStyle(fontSize: 17.sp),
                  ),
                ),
                LikeButton()
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Container(
              height: 1,
              width: 100.w,
              color: Colors.grey,
            ),
            SizedBox(height: 1.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 90.w,
                  height: 20.h,
                  child: Image.memory(
                      image,
                      fit: BoxFit.cover,
                  )
                )
              ],
            ),
            SizedBox(height: 1.h),
            Container(
              height: 1,
              width: 100.w,
              color: Colors.grey,
            ),
            SizedBox(height: 1.h),
            Text(
              "Tarifi yapan: " + recipe.createdBy,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 1.h),
            ButtonWidget(
                "Tarif",
                height: 4.h,
                bgColor: Globals.buttonColor,
                textColor: Colors.white,
                () async {
                  var result = await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => FoodDetail(foodId:recipe.id)));
                  if(result != null){
                    if(result["isDeleted"] != null){
                      onDelete(recipe.id);
                    }else{
                      setState((){
                        recipe = result["recipe"];
                        image = result["image"];
                        onChange(recipe.id,recipe);
                        if(!recipe.isLiked){
                          onDislike?.call(recipe.id);
                        } 
                      });
                    }
                  }
                },
                ),
          ],
        ),
      ),
    );
  }
  Widget LikeButton(){
    return GestureDetector(
    onTap: () {
      recipe.isLiked ? 
        ApiCallViewModel().dislikeFood(Globals.email, recipe.id): 
        ApiCallViewModel().likeFood(Globals.email, recipe.id);
      
      setState(() {
        recipe.isLiked = !recipe.isLiked;
      });
      onDislike?.call(recipe.id);
      
    },
    child: Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: recipe.isLiked ? Globals.buttonColor : Globals.unselectButtonColor,
      ),
      child: Center(
              child: Icon(
                recipe.isLiked? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
            ),
        ),
      );
  }
}
