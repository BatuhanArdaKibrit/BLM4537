import 'package:cookingrecipes/globals.dart';
import 'package:dio/dio.dart';

class ApiManager {
  final _dio = Dio();

  Future<ResponseModel> get(String endPoint,
      {Map<String, dynamic>? body = null,
      Map<String, dynamic>? queryParameters = null,
      isHaveHeader = true}) async {
    var response = await _dio.get(
      endPoint,
      data: body,
      options: Options(
          headers: isHaveHeader
              ? {"Authorization": "Bearer " + Globals.token}
              : null,
          followRedirects: false,
          validateStatus: (status) {
            return status! <= 500;
          }),
      queryParameters: queryParameters,
    );
    try {
      if (response.statusCode! < 210 && response.statusCode! >= 200) {
        return ResponseModel(ResponseEnum.success, data: response.data);
      } else {
        return ResponseModel(ResponseEnum.error,
            error: response.statusMessage, data: response.data);
      }
    } catch (e) {
      return ResponseModel(ResponseEnum.error, error: e.toString());
    }
  }

  Future<ResponseModel> post(String endPoint,
      {var body = null,
      Map<String, dynamic>? queryParameters = null,
      bool isHaveHeader = true}) async {
    try {
      var response = await _dio.post(endPoint,
          data: body,
          queryParameters: queryParameters,
          options: Options(
              headers: isHaveHeader
                  ? {"Authorization": "Bearer " + Globals.token}
                  : null,
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }));

      if (response.statusCode! < 210 && response.statusCode! >= 200) {
        return ResponseModel(ResponseEnum.success, data: response.data);
      } else {
        return ResponseModel(ResponseEnum.error,
            error: response.statusMessage, data: response.data);
      }
    } catch (e) {
      print(e.toString());
      return ResponseModel(ResponseEnum.error, error: e.toString());
    }
  }

  Future<ResponseModel> put(String endPoint,
      {var body = null,
      Map<String, dynamic>? queryParameters = null,
      bool isHaveHeader = true}) async {
    try {
      var response = await _dio.put(endPoint,
          data: body,
          queryParameters: queryParameters,
          options: Options(
              headers: isHaveHeader
                  ? {"Authorization": "Bearer " + Globals.token}
                  : null,
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }));

      if (response.statusCode! < 210 && response.statusCode! >= 200) {
        return ResponseModel(ResponseEnum.success, data: response.data);
      } else {
        print(response.data.toString());

        return ResponseModel(ResponseEnum.error,
            error: response.statusMessage, data: response.data);
      }
    } catch (e) {
      print(e.toString());
      return ResponseModel(ResponseEnum.error, error: e.toString());
    }
  }

  Future<bool> delete(String endPoint) async {
    try {
      await _dio.delete(endPoint,
          options: Options(
              headers: {"Authorization": "Bearer " + Globals.token},
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }));
      print('deleted!');
      return true;
    } catch (e) {
      print('Error deleting: $e');
      return false;
    }
  }
}

class ResponseModel<T> {
  final ResponseEnum status;
  T? data;
  String? error;

  ResponseModel(this.status, {this.data, this.error});
}

enum ResponseEnum { success, error }
