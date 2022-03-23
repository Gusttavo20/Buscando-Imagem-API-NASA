import 'package:project_test/features/domain/entities/space_media.dart';
import 'package:project_test/core/usecase/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:project_test/features/domain/repositories/space_media_repository.dart';
import 'package:project_test/core/usecase/errors/exceptions.dart';
import '../datasources/space_media_datasource.dart';

//A lógica de negócio para chamar os dados da API.

class SpaceMediaRepositoryImplementation implements ISpaceMediaRepository {
  final ISpaceMediaDatasource datasource;

  SpaceMediaRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date) async {
    try {
      final result = await datasource.getSpaceMediaFromDate(date);
      return Right(result);
    } on ServerExceptions {
      return Left(
        ServerFailure(),
      );
    }
  }
}
