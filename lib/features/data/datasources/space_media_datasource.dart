import '../models/space_media_model.dart';

abstract class SpaceMediaDatasource {
  Future<SpaceMediaModel> getSpaceMediaFromDate({required DateTime date});
}
