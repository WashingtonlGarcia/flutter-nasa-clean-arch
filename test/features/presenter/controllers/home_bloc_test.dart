import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:flutter_nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:flutter_nasa_clean_arch/features/domain/usecases/get_space_media_from_date_use_case.dart';
import 'package:flutter_nasa_clean_arch/features/presenter/controllers/home/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetSpaceMediaFromDateUsecaseMock extends Mock implements GetSpaceMediaFromDateUsecase {}

void main() {
  late HomeBloc bloc;
  late GetSpaceMediaFromDateUsecase usecase;
  late SpaceMediaEntity spaceMedia;
  late Params params;
  setUpAll(() {
    usecase = GetSpaceMediaFromDateUsecaseMock();
    bloc = HomeBloc(usecase: usecase);
    spaceMedia = SpaceMediaEntity(
        description: faker.randomGenerator.string(15),
        title: faker.randomGenerator.string(15),
        mediaType: faker.randomGenerator.string(15),
        mediaUrl: faker.internet.httpUrl());
    params = Params(date: DateTime.now());
  });
  tearDownAll(() {
    bloc.close();
  });

  blocTest<HomeBloc, HomeState>(
    'should return a SpaceMedia From the usecase',
    build: () => bloc,
    act: (bloc) async {
      when(() => usecase(params: params)).thenAnswer((invocation) async => Right(spaceMedia));
      bloc.add(HomeGetSpaceMediaFromDateEvent(dateTime: params.date));
    },
    expect: () => [HomeLoadingState(), HomeSuccessState(entity: spaceMedia)],
  );
}
