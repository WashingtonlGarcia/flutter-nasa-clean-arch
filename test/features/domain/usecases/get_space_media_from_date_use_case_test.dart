import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:flutter_nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:flutter_nasa_clean_arch/features/domain/repositories/space_media_repository.dart';
import 'package:flutter_nasa_clean_arch/features/domain/usecases/get_space_media_from_date_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_nasa_clean_arch/core/errors/failure.dart';

class SpaceMediaRepositoryMock extends Mock implements SpaceMediaRepository {}

void main() {
  late SpaceMediaEntity spaceMedia;
  late GetSpaceMediaFromDateUsecase usecase;
  late SpaceMediaRepository repository;
  late Params params;
  setUpAll(() {
    repository = SpaceMediaRepositoryMock();
    usecase = GetSpaceMediaFromDateUsecase(repository: repository);
    spaceMedia = SpaceMediaEntity(
        description: faker.randomGenerator.string(15),
        title: faker.randomGenerator.string(15),
        mediaType: faker.randomGenerator.string(15),
        mediaUrl: faker.internet.httpUrl());
    params = Params(date: faker.date.dateTime());
  });

  test('should get space media entity for a given data from the repository', () async {
    when(() => repository.getSpaceMediaFromDate(date: params.date)).thenAnswer((_) async => Right<Failure, SpaceMediaEntity>(spaceMedia));
    final result = await usecase(params: params);
    expect(result, Right<Failure, SpaceMediaEntity>(spaceMedia));
    verify(() => repository.getSpaceMediaFromDate(date: params.date));
  });

  test('should return a ServerFailure whtn dont succeed', () async {
    when(() => repository.getSpaceMediaFromDate(date: params.date)).thenAnswer((_) async => Left<Failure, SpaceMediaEntity>(ServerFailure()));
    final result = await usecase(params: params);
    expect(result,Left<Failure, SpaceMediaEntity>(ServerFailure()));
    verify(() => repository.getSpaceMediaFromDate(date: params.date));
  });
}
