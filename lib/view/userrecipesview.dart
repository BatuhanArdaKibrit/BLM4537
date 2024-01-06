import 'package:cookingrecipes/globals.dart';
import 'package:cookingrecipes/model/recipemodel.dart';
import 'package:cookingrecipes/view/addrecipe.dart';
import 'package:cookingrecipes/view/services/apicallviewmodel.dart';
import 'package:cookingrecipes/widgets/buttonwidget.dart';
import 'package:cookingrecipes/widgets/fooditem.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserRecipesView extends StatefulWidget {
  const UserRecipesView({super.key});

  @override
  State<UserRecipesView> createState() => _UserRecipesViewState();
}

class _UserRecipesViewState extends State<UserRecipesView> {
  List<RecipeModel>? recipeModel;
  List<RecipeModel>? filterModel;
  TextEditingController searchController = TextEditingController(text: "");

  @override
  void initState() {
    ApiCallViewModel().getUserFood(Globals.email).then((value) {
      if (value != null) {
        setState(() {
          recipeModel = value;
          filterModel = value;
        });
      }
    });
    super.initState();
  }
 void searching(String value){
    if(value.isEmpty){
      setState(() {
        filterModel = recipeModel;
      });
    }
    setState(() {
      filterModel = recipeModel!.where((e) => e.name.trim().toLowerCase().contains(value.trim().toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Globals.mainColor,
        body: recipeModel != null ?
        SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 60.w,
                    margin: EdgeInsets.only(bottom: 12),
                    child: TextField(
                      cursorColor: Globals.mainColor,
                      controller: searchController,
                      
                      onChanged: (value) {
                        searching(value);
                      },
                      decoration: InputDecoration(
                        filled: true,
                        enabled: recipeModel!.isNotEmpty,
                        fillColor: Colors.white,
                        hintText: "Arama yap...",
                        prefixIcon: Icon(Icons.search,color: Globals.mainColor,),
                        suffixIcon: searchController.text.isNotEmpty ?
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              searchController.text = "";
                              filterModel = recipeModel;
                            });
                          },
                          child: Icon(Icons.clear,color: Globals.mainColor,)
                        )
                        :null,
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
                    )
                  ),
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: ButtonWidget("Tarif Ekle", ()async {
                        await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddRecipeWidget()));
                        ApiCallViewModel().getUserFood(Globals.email).then((value){
                          if (value != null) {
                            setState(() {
                              searchController.text = "";
                              recipeModel = value;
                              filterModel = value;
                            });
                          }
                        });
                    },width: 100,),
                  ),
                ],
              ),
              (filterModel!.isEmpty ? Container(
                height: 60.h,
                alignment: Alignment.center,
                child: recipeModel!.isEmpty ?
                Text(
                  "Tarifiniz bulunmamaktadır.\nHemen bir tane ekleyin.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,fontSize: 18.sp))
                 :
                Text("Aradığınız tarif bulunmamaktadır.",style: TextStyle(color: Colors.white,fontSize: 18.sp))
                )
              : 
              Expanded(
                child: ListView.builder(
                    itemCount: filterModel!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FoodItem(
                        key: UniqueKey(),
                        recipe: filterModel!.elementAt(index),
                        onDelete: (int foodId){
                          setState(() {
                            recipeModel!.removeWhere((e) => e.id == foodId);
                            filterModel!.removeWhere((e) => e.id == foodId);
                          });
                        },
                        onChange: (int foodId,RecipeModel recipe){
                          setState(() {
                            RecipeModel oldRecipe = recipeModel!.firstWhere((e) => e.id == foodId);
                            oldRecipe.name = recipe.name;
                            oldRecipe.image = recipe.image;
                            oldRecipe.isLiked = recipe.isLiked;
                            filterModel=recipeModel;
                            searchController.text = ""; 
                          });
                        },
                      );
                    }),
              )),
            ],
          ),
        )
        :
        Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
    );
  }
}



