import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase/usecase.dart';
import '../entities/space_media_entity.dart';
import '../repositories/space_media_repository.dart';

class GetSpaceMediaFromDateUsecase implements Usecase<SpaceMediaEntity, Params> {
  final SpaceMediaRepository repository;

  const GetSpaceMediaFromDateUsecase({required this.repository});

  @override
  Future<Either<Failure, SpaceMediaEntity>> call({required Params params}) {
    return repository.getSpaceMediaFromDate(date: params.date);
  }
}

class Params extends Equatable {
  final DateTime date;

  const Params({required this.date});

  @override
  List<Object?> get props => [date];
}
