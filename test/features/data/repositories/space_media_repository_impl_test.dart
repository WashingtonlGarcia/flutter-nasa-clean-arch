import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:flutter_nasa_clean_arch/core/errors/exception.dart';
import 'package:flutter_nasa_clean_arch/core/errors/failure.dart';
import 'package:flutter_nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:flutter_nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:flutter_nasa_clean_arch/features/data/repositories/space_media_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SpaceMediaDatasourceMock extends Mock implements SpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImpl repository;
  late SpaceMediaDatasource datasource;
  late SpaceMediaModel model;
  late DateTime date;

  setUpAll(() {
    datasource = SpaceMediaDatasourceMock();
    repository = SpaceMediaRepositoryImpl(datasource: datasource);
    model = SpaceMediaModel(
        description: faker.randomGenerator.string(15),
        title: faker.randomGenerator.string(15),
        mediaType: faker.randomGenerator.string(15),
        mediaUrl: faker.internet.httpUrl());
    date = faker.date.dateTime();
  });

  test('should return space media model when calls the datasources', () async {
    when(() => datasource.getSpaceMediaFromDate(date: date)).thenAnswer((_) async => model);
    final result = await repository.getSpaceMediaFromDate(date: date);

    expect(result, Right(model));

    verify(() => datasource.getSpaceMediaFromDate(date: date));
  });

  test('should return a server failure space when call to datasources is unsuccessful', () async {
    when(() => datasource.getSpaceMediaFromDate(date: date)).thenThrow(ServerException());
    final result = await repository.getSpaceMediaFromDate(date: date);

    expect(result, Left(ServerFailure()));

    verify(() => datasource.getSpaceMediaFromDate(date: date));
  });
}
