import 'package:cookingrecipes/globals.dart';
import 'package:cookingrecipes/model/recipemodel.dart';
import 'package:cookingrecipes/view/services/apicallviewmodel.dart';
import 'package:cookingrecipes/widgets/buttonwidget.dart';
import 'package:cookingrecipes/widgets/fooditem.dart';
import 'package:cookingrecipes/widgets/textfieldwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>{
  TextEditingController searchController = TextEditingController(text: "");
  List<RecipeModel>? recipeModel;
  List<RecipeModel>? filterModel;
  @override
  void initState() {
    ApiCallViewModel().getAllFood(Globals.email).then((value) {
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
        body: recipeModel != null ? (recipeModel!.isEmpty ? 
        Center(child: Text("Uygulamada hiçbir tarif bulunmamaktadır.",style: TextStyle(color: Colors.white,fontSize: 18.sp))) :
        SafeArea(
          child: Column(
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
              (filterModel!.isEmpty ? Container(
                height: 60.h,
                alignment: Alignment.center,
                child: Text("Aradığınız tarif bulunmamaktadır.",style: TextStyle(color: Colors.white,fontSize: 18.sp))
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
