import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_test/core/usecase/errors/failures.dart';
import 'package:project_test/features/domain/entities/space_media.dart';
import 'package:project_test/features/domain/repositories/space_media_repository.dart';
import 'package:project_test/features/domain/usecases/get_space_media_from_date_usercase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../features/mocks/date_mock.dart';
import '../../../features/mocks/space_media_entity_mock.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;
  late ParamsGetSpaceMedia paramsDate;
  setUp(() {
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
    paramsDate = ParamsGetSpaceMedia(date: tDate);
  });

  test(
      'deve obter entidade de mídia de espaço para uma determinada data do repositório',
      () async {
    //Arrange
    when(() => repository.getSpaceMediaFromDate(any()))
        .thenAnswer((_) async => Right<Failure, SpaceMediaEntity>(tSpaceMedia));

    //Act
    final result = await usecase(paramsDate);

    //Assert
    expect(result, Right(tSpaceMedia));
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });

  test('deve retornar um ServerFailure quando não tiver sucesso', () async {
    // Arrange
    when(() => repository.getSpaceMediaFromDate(any())).thenAnswer(
        (_) async => Left<Failure, SpaceMediaEntity>(ServerFailure()));
    // Act
    final result = await usecase(paramsDate);
    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });
}
