import 'package:faker/faker.dart';
import 'package:flutter_nasa_clean_arch/core/errors/exception.dart';
import 'package:flutter_nasa_clean_arch/core/http_client/http_client.dart';
import 'package:flutter_nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:flutter_nasa_clean_arch/features/data/datasources/nasa_datasource_impl.dart';
import 'package:flutter_nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late SpaceMediaDatasource datasource;
  late HttpClient httpClient;
  late Map<String, dynamic> map;
  late DateTime date;
  setUpAll(() {
    httpClient = HttpClientMock();
    datasource = NasaDatasourceImpl(httpClient: httpClient);
    map = {
      'explanation': faker.randomGenerator.string(15),
      'title': faker.randomGenerator.string(15),
      'media_type': faker.randomGenerator.string(15),
      'url': faker.internet.httpUrl()
    };
    date = faker.date.dateTime();
  });
  void successMock() => when(() => httpClient.get(any())).thenAnswer((invocation) async => HttpResponse(data: map, statusCode: 200));
  test('should call the get method with correct url', () async {
    successMock();
    await datasource.getSpaceMediaFromDate(date: date);

    verify(() => httpClient.get(any()));
  });
  test('should return a SpaceMediaModel when is successful', () async {
    successMock();
    final result = await datasource.getSpaceMediaFromDate(date: date);

    expect(result, SpaceMediaModel.fromMap(map: map));
    verify(() => httpClient.get(any()));
  });

  test('should throw ServerException when is unccessful', () async {
    when(() => httpClient.get(any())).thenAnswer((invocation) async => HttpResponse(data: map, statusCode: 500));
    final result = datasource.getSpaceMediaFromDate(date: date);

    expect(() => result, throwsA(ServerException()));
    verify(() => httpClient.get(any()));
  });
}
