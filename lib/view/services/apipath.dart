class ApiPath {
  static const String prodURL = 'http://localhost:5066/api';

  static const String signIn = '$prodURL/auth/login';
  static const String signUp = '$prodURL/auth/register';
  static const String getAllFood = '$prodURL/food/all';
  static const String likeFood = '$prodURL/food/like';
  static const String userFood = '$prodURL/food/user';
  static const String food = '$prodURL/food';
  static const String dislikeFood = '$prodURL/food/dislike';
  static const String getLikedFood = '$prodURL/food/like';
  static const String account ='$prodURL/account';
}
