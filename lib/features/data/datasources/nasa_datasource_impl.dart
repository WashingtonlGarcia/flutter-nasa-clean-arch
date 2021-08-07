import 'package:flutter_nasa_clean_arch/core/errors/exception.dart';

import '../../../core/http_client/http_client.dart';
import '../../../core/utils/converters/data_to_string_converter.dart';
import '../../../core/utils/keys/nasa_api_keys.dart';
import '../models/space_media_model.dart';
import 'endpoints/nasa_endpoints.dart';
import 'space_media_datasource.dart';

class NasaDatasourceImpl implements SpaceMediaDatasource {
  final HttpClient httpClient;

  NasaDatasourceImpl({required this.httpClient});

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate({required DateTime date}) async {
    final response = await httpClient.get(NasaEdpoints.apod(apiKey: NasaApiKeys.apiKey, date: DateToStringConvert.convert(date: date)));
    if (response.statusCode! != 200) {
      throw ServerException();
    }

    return SpaceMediaModel.fromMap(map: response.data as Map<String, dynamic>);
  }
}
