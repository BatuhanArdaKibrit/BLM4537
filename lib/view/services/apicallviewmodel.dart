import 'dart:convert';
import 'dart:io';

import 'package:cookingrecipes/globals.dart';
import 'package:cookingrecipes/model/recipemodel.dart';
import 'package:cookingrecipes/model/usermodel.dart';
import 'package:cookingrecipes/view/services/apimanager.dart';
import 'package:cookingrecipes/view/services/apipath.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:path/path.dart';


class ApiCallViewModel {
  Future<ResponseModel> postSignIn(String email, String password) async {
    ResponseModel response = await ApiManager().post(ApiPath.signIn,
        body: {"email": email, "password": password}, isHaveHeader: false);

    if (response.status == ResponseEnum.success) {
      // context.push("/home");
      print("Login Successfull");
      Globals.token = response.data["token"];

      // Credentialları al
      Map<String, dynamic> decodedToken = JwtDecoder.decode(Globals.token);
      Globals.name = decodedToken[
          "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"];
      Globals.email = decodedToken[
          "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"];
      return response;
    } else {
      print("Login ERROR !");

      return response;
    }
  }

  Future<ResponseModel> postSignUp(String name, String email, String password) async {
    ResponseModel response = await ApiManager().post(ApiPath.signUp,
        body: {"name": name, "email": email, "password": password});

    if (response.status == ResponseEnum.success) {
      // context.push("/home");
      print("SignUp Successfull");
      return response;
    } else {
      print("SignUp ERROR !");

      return response;
    }
  }

  Future<List<RecipeModel>?> getAllFood(String email) async {
    ResponseModel response =
        await ApiManager().get(ApiPath.getAllFood, queryParameters: {
      "email": email,
    });

    if (response.status == ResponseEnum.success) {
      List<RecipeModel> recipeModel = dynamictoListRecipeModel(response.data);
      print("data get it Successfull");
      return recipeModel;
    } else {
      print("Some ERROR !");
      return null;
    }
  }
  Future<List<RecipeModel>?> getLikedFood(String email) async {
    ResponseModel response =
        await ApiManager().get(ApiPath.getLikedFood, queryParameters: {
      "email": email,
    });

    if (response.status == ResponseEnum.success) {
      List<RecipeModel> recipeModel = dynamictoListRecipeModel(response.data);
      print("data get it Successfull");
      return recipeModel;
    } else {
      print("Some ERROR !");
      return null;
    }
  }
   Future<List<RecipeModel>?> getUserFood(String email) async {
    ResponseModel response =
        await ApiManager().get(ApiPath.userFood, queryParameters: {
      "email": email,
    });

    if (response.status == ResponseEnum.success) {
      List<RecipeModel> recipeModel = dynamictoListRecipeModel(response.data);
      print("data get it Successfull");
      return recipeModel;
    } else {
      print("Some ERROR !");
      return null;
    }
  }

  Future likeFood(String email,int foodId) async{
    ResponseModel response = await ApiManager().post(ApiPath.likeFood,body: {
      "email":email,
      "foodId":foodId
    });
  }
  Future dislikeFood(String email,int foodId) async{
    ResponseModel response = await ApiManager().post(ApiPath.dislikeFood,body: {
      "email":email,
      "foodId":foodId
    });
  }
  Future getFoodDetail(String email,int foodId) async{
    ResponseModel response = await ApiManager().get("${ApiPath.food}/$foodId",queryParameters: {
      "email":email
    });
    if (response.status == ResponseEnum.success) {
      RecipeModel recipeModel = RecipeModel.fromJson(response.data);
      print("data get it Successfull");
      return recipeModel;
    } else {
      print("Some ERROR !");
      return null;
    }
  }
  Future deleteAccount(String email) async{
    bool response = await ApiManager().delete("${ApiPath.account}/$email");
    if (response) {
      print("account deleted");
      return "account deleted";
    } else {
      print("Some ERROR !");
      return "Some ERROR !";
    }
  }
  Future changeName(String name,String email) async{
    ResponseModel response = await ApiManager().put("${ApiPath.account}/name",body: {
      "name" : name,
      "email": email
    });
    if (response.status == ResponseEnum.success) {
      return response;
    } else {
      print("Some ERROR !");
      return null;
    }
  }
  Future changeEmail(String oldEmail,String email) async{
    ResponseModel response = await ApiManager().put("${ApiPath.account}/email",body: {
      "old_email" : oldEmail,
      "email": email
    });
    if (response.status == ResponseEnum.success) {
      return response;
    } else {
      print("Some ERROR !");
      return null;
    }
  }
  Future<ResponseModel> changePasswd(String email,String passwd,String oldPasswd) async{
    ResponseModel response = await ApiManager().put("${ApiPath.account}/passwd",body: {
      "email" : email,
      "password": passwd,
      "old_password":oldPasswd
    });
    if (response.status == ResponseEnum.success) {
      return response;
    } else {
      print("Some ERROR !");
      return response;
    }
  }
  Future<ResponseModel> addRecipe(String name,String type,String ingredients,String recipe,File? image) async{
    ResponseModel response;
    if(image == null){
      response = ResponseModel(ResponseEnum.error);
      response.error = "Lütfen fotoğraf ekleyiniz";
      return response;
    }
    String image_name = basename(image.path);
    FormData formData = FormData.fromMap({
      "name":name,
      "type":type,
      "image": await MultipartFile.fromFile(image.path, filename: image_name),
      "imageName": image_name,
      "recipe":recipe,
      "ingredients": ingredients,
      "createdBy":Globals.email
    });
    response = await ApiManager().post("${ApiPath.food}",body: formData);
    if (response.status == ResponseEnum.success) {
      return response;
    }else {
      print("Some ERROR !");
      return response;
    }
  }
  Future<String?> checkOwner(int foodId) async{
    ResponseModel response = await ApiManager().get("${ApiPath.food}/$foodId/check_ownership");
    if (response.status == ResponseEnum.success) {
      return response.data;
    }else {
      print("Some ERROR !");
      return null;
    }
  }
  Future<bool> deleteRecipe(int foodId) async{
    bool response = await ApiManager().delete("${ApiPath.food}/$foodId");
    return response;
  }
  Future<ResponseModel> editRecipe(int foodId,String name,String type,String ingredients,String recipe,File? image) async{
    ResponseModel response;
    if(image == null){
      response = ResponseModel(ResponseEnum.error);
      response.error = "Lütfen fotoğraf ekleyiniz";
      return response;
    }
    String image_name = basename(image.path);

    FormData formData = FormData.fromMap({
      "name":name,
      "type":type,
      "image": await MultipartFile.fromFile(image.path, filename: image_name),
      "imageName": image_name,
      "recipe":recipe,
      "ingredients": ingredients,
      "createdBy":Globals.email
    });
    response = await ApiManager().put("${ApiPath.food}/$foodId",body: formData);
    if (response.status == ResponseEnum.success) {
      return response;
    }else {
      print("Some ERROR !");
      return response;
    }

  }
  
}
