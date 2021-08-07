import 'package:dio/dio.dart';
import 'http_client.dart';

class HttpClientImpl implements HttpClient {
  Dio get dio => Dio();

  @override
  Future<HttpResponse> get(String url) async {
    final response = await dio.get(url);
    return HttpResponse(data: response.data, statusCode: response.statusCode);
  }
}
