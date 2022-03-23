import 'package:dartz/dartz.dart';

import 'package:project_test/core/usecase/errors/failures.dart';
import 'package:project_test/core/usecase/usecase.dart';
import 'package:project_test/features/domain/entities/space_media.dart';
import 'package:project_test/features/domain/repositories/space_media_repository.dart';

//Parte onde esta a regra de negocio e onde faz a ligação com o repositorio.

class GetSpaceMediaFromDateUsecase
    implements Usecase<SpaceMediaEntity, ParamsGetSpaceMedia> {
  final ISpaceMediaRepository repository;

  GetSpaceMediaFromDateUsecase(this.repository);

  @override
  Future<Either<Failure, SpaceMediaEntity>> call(params) async {
    return await repository.getSpaceMediaFromDate(params.date);
  }
}

class ParamsGetSpaceMedia {
  final DateTime date;
  ParamsGetSpaceMedia({
    required this.date,
  });
}
