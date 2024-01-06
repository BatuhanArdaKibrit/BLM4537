// ignore_for_file: prefer_const_constructors

import 'package:cookingrecipes/globals.dart';
import 'package:cookingrecipes/popups/popupmanager.dart';
import 'package:cookingrecipes/view/services/apicallviewmodel.dart';
import 'package:cookingrecipes/view/services/pickfilehelper.dart';
import 'package:cookingrecipes/widgets/buttonwidget.dart';
import 'package:cookingrecipes/widgets/textfieldwidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:io';

class AddRecipeWidget extends StatefulWidget {
  const AddRecipeWidget({super.key});

  @override
  State<AddRecipeWidget> createState() => _AddRecipeWidgetState();
}

class _AddRecipeWidgetState extends State<AddRecipeWidget> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController typeController = TextEditingController(text: "");
  TextEditingController recipeController = TextEditingController(text: "");
  TextEditingController ingredientController = TextEditingController();

  File? image = null;
  List<String> ingredients = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globals.mainColor,
      appBar: AppBar(title: Text("Tarif Ekle")),
      body: SingleChildScrollView(
        child: Container(
          width: 100.w,
          margin: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Yemeğin adı",
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                ),
              ),
              SizedBox(height: 8,),
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Yemeğin türü",
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                ),
              ),
              SizedBox(height: 8,),
              image != null ? 
              Image.file(
                image!,
                width: 90.w,
                height: 30.h,
                fit: BoxFit.contain,
              ) : SizedBox(),
              ElevatedButton(
              onPressed: () async {
                PickFileHelper(context).getImage()
                .then((value) {
                  setState(() {
                    image = value;
                  });
                });
              },
              child: Text('Fotoğraf seç'),
              ),
              SizedBox(height: 8,),
              image != null ? Text("Fotoğraf seçildi",style: TextStyle(color: Colors.white),): SizedBox(),
              SizedBox(height: 16,),
              Text(
                'Malzemeler',
                style: TextStyle(fontSize: 18,color: Colors.white),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: buildChipWidgets(),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      controller: ingredientController,
                      decoration: InputDecoration(
                        labelText: 'Malzeme ekle',
                        labelStyle: TextStyle(color: Colors.white),
                        focusColor: Colors.white,
                        fillColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add,color: Colors.white,),
                    onPressed: () {
                      addIngredient();
                    },
                  ),
                ]
              ),
              SizedBox(height: 24,),
              TextField(
                  controller: recipeController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: 'Tarif',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Tarifini buraya yaz',
                    hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    // Other decoration properties...
                  ),
              ),
              SizedBox(height: 16,),
              ButtonWidget("Tarifi kaydet", (){
                ApiCallViewModel().addRecipe(
                  nameController.text,
                  typeController.text,
                  ingredients.join(","),
                  recipeController.text,
                  image
                ).then((response) {
                  if(response.error == null){
                    PopUpManager().donePopup(context, (){
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },doneText: "Tarif başarılı bir şekilde kaydedilmiştir."
                    );
                  }else{
                    PopUpManager().errorPopup(context, response.data["messsage"]);
                  }
                }
                );
              }),
              SizedBox(height: 16,),
            ],
          ),
        ),
      ),
    );
  }
  List<Widget> buildChipWidgets() {
    return ingredients.map((ingredient) {
      return Chip(
        label: Text(ingredient),
        onDeleted: () {
          removeIngredient(ingredient);
        },
      );
    }).toList();
  }

  void addIngredient() {
    String newIngredient = ingredientController.text.trim();
    if (newIngredient.isNotEmpty && !ingredients.contains(newIngredient)) {
      setState(() {
        ingredients.add(newIngredient);
        ingredientController.clear();
      });
    }
  }

  void removeIngredient(String ingredient) {
    setState(() {
      ingredients.remove(ingredient);
    });
  }
}

