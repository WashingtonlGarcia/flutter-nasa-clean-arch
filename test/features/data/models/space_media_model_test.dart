import 'package:faker/faker.dart';
import 'package:flutter_nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:flutter_nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:flutter_test/flutter_test.dart';

const entity = TypeMatcher<SpaceMediaEntity>();

void main() {
  late SpaceMediaModel model;
  late  Map<String, dynamic> map;
  setUpAll(() {
    map = {
      'explanation': faker.randomGenerator.string(15),
      'title': faker.randomGenerator.string(15),
      'media_type': faker.randomGenerator.string(15),
      'url': faker.internet.httpUrl()
    };
    model = SpaceMediaModel.fromMap(map: map);
  });
  test('should be a subclass of SpaceMediaEntity', () {
    expect(model, entity);
  });

  test('should return a valid model', () {
    final result = model.toMap();
    expect(result, map);
  });
}
