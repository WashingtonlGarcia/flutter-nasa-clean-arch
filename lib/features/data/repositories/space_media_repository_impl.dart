import 'package:dartz/dartz.dart';
import 'package:flutter_nasa_clean_arch/core/errors/exception.dart';
import '../../../core/errors/failure.dart';
import '../../domain/entities/space_media_entity.dart';
import '../../domain/repositories/space_media_repository.dart';
import '../datasources/space_media_datasource.dart';

class SpaceMediaRepositoryImpl implements SpaceMediaRepository {
  final SpaceMediaDatasource datasource;

  SpaceMediaRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate({required DateTime date}) async {
    try {
      final result = await datasource.getSpaceMediaFromDate(date: date);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
