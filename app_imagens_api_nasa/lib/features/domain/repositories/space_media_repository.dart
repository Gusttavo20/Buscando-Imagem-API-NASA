import 'package:dartz/dartz.dart';
import 'package:project_test/core/usecase/errors/failures.dart';
import 'package:project_test/features/domain/entities/space_media.dart';

//Garantirá que quem implementá-la terá que implementar todos os métodos.
abstract class ISpaceMediaRepository {
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date);
}
