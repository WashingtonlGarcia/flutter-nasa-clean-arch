import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../entities/space_media_entity.dart';

abstract class SpaceMediaRepository {
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate({required DateTime date});
}
