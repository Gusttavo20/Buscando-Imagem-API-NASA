import 'package:project_test/core/usecase/errors/failures.dart';
import 'package:project_test/features/data/datasources/space_media_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_test/features/data/repositories/space_media_repository_implementations.dart';
import 'package:project_test/features/data/models/space_media_model.dart';
import 'package:project_test/core/usecase/errors/exceptions.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource);
  });

  final tSpaceMediaModel = SpaceMediaModel(
    description: 'Gustavo Marques',
    mediaType: 'image',
    title: 'Gustavo',
    mediaUrl:
        'https://apod.nasa.gov/apod/image/2102/MeteorStreak_Kuszaj_1080.jpg',
  );

  final tDate = DateTime(
    2021,
    02,
    02,
  );

  test('deve retornar o modelo de mídia espacial quando chama a fonte de dados',
      () async {
    //Arrange
    when(() => datasource.getSpaceMediaFromDate(any()))
        .thenAnswer((_) async => tSpaceMediaModel);
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, Right(tSpaceMediaModel));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });

  test(
      'deve retornar uma falha no servidor quando a chamada para a fonte de dados não for bem-sucedida',
      () async {
    // Arrange
    when(() => datasource.getSpaceMediaFromDate(any()))
        .thenThrow(ServerExceptions());
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });
}
