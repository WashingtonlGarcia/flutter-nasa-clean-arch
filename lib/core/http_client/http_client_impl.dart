import 'package:dio/dio.dart';
import 'http_client.dart';

class HttpClientImpl implements HttpClient {
  Dio get dio => Dio();

  @override
  Future<HttpResponse> get(String url) async {
    try {
      final response = await dio.get(url);
      return HttpResponse(data: response.data, statusCode: response.statusCode);
    }on DioError catch(error){
      return HttpResponse(data: error.message, statusCode: 400);
    }
  }
}
