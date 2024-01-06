// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cookingrecipes/globals.dart';
import 'package:cookingrecipes/model/recipemodel.dart';
import 'package:cookingrecipes/popups/popupmanager.dart';
import 'package:cookingrecipes/view/services/apicallviewmodel.dart';
import 'package:cookingrecipes/view/services/pickfilehelper.dart';
import 'package:cookingrecipes/widgets/buttonwidget.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditRecipeWidget extends StatefulWidget {
  int foodId;
  EditRecipeWidget({super.key,required this.foodId});

  @override
  State<EditRecipeWidget> createState() => _EditRecipeWidgetState();
}

class _EditRecipeWidgetState extends State<EditRecipeWidget> {
  late int foodId;
  late RecipeModel? recipe;
  late TextEditingController nameController;
  late TextEditingController typeController;
  late TextEditingController recipeController;
  TextEditingController ingredientController = TextEditingController();
  late Uint8List? oldImage;
  File? image;
  late List<String> ingredients;

  @override
  void initState() {
    setState(() {      
      foodId = widget.foodId;
      recipe = null;
      nameController = TextEditingController(text: "");
      typeController = TextEditingController(text: "");
      recipeController = TextEditingController(text: "");          
      oldImage = null;
      ingredients = [];
    });
    ApiCallViewModel().getFoodDetail(Globals.email, foodId).then((value) {
        if(value != null){
          setState(() {
            recipe = value;
            nameController = TextEditingController(text: recipe!.name);
            typeController = TextEditingController(text: recipe!.type);
            recipeController = TextEditingController(text: recipe!.recipe);
            ingredients = recipe!.ingredients.split(',');
            oldImage = base64Decode(recipe!.image);
          });
        }
      }
    );
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globals.mainColor,
      appBar: AppBar(title: Text("Tarifi Düzenle")),
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
              ) : (oldImage != null ?
              Image(
              image: MemoryImage(oldImage!,),
              width: 90.w,
              height: 30.h,
              fit: BoxFit.contain
              ,)
              :
              SizedBox())
              ,
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
              image == null ? SizedBox() : Text("Fotoğraf seçildi",style: TextStyle(color: Colors.white),),
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
              ButtonWidget("Tarifi düzenle", ()async {
                image ??= await writeToFile(recipe!.imageName, oldImage!);
                ApiCallViewModel().editRecipe(
                  foodId,
                  nameController.text,
                  typeController.text,
                  ingredients.join(","),
                  recipeController.text,
                  image
                ).then((response) {
                  if(response.error == null){
                    PopUpManager().donePopup(context, (){
                      Navigator.of(context).pop();
                      Navigator.of(context).pop({
                        "isChanged":true
                      });
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
  Future<File> writeToFile(String imageName,Uint8List data)async{
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath + "/$imageName";
    return new File(filePath).writeAsBytes(data);
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