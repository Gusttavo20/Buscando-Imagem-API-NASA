import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_test/core/usecase/errors/failures.dart';
import 'package:project_test/features/domain/usecases/get_space_media_from_date_usercase.dart';
import 'package:project_test/features/presenter/controllers/home_store.dart';

import '../../../features/mocks/date_mock.dart';
import '../../../features/mocks/space_media_entity_mock.dart';

class MockGetSpaceMediafromDateUsecase extends Mock
    implements GetSpaceMediaFromDateUsecase {}

void main() {
  late HomeStore store;
  late GetSpaceMediaFromDateUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockGetSpaceMediafromDateUsecase();
    store = HomeStore(mockUsecase);
    registerFallbackValue(ParamsGetSpaceMedia(date: tDate));
  });

  test('deve retornar um SpaceMedia do caso de uso', () async {
    //Arrange
    when(() => mockUsecase(any())).thenAnswer((_) async => Right(tSpaceMedia));

    //Act
    store.getSpaceMediaFromDate(tDate);

    //Assert
    store.observer(onState: (state) {
      expect(state, tSpaceMedia);
      verify(() => mockUsecase(any())).called(1);
    });
  });

  final tFailure = ServerFailure();
  test('deve retornar uma falha do caso de uso quando houver um erro',
      () async {
    //Arrange
    when(() => mockUsecase(any())).thenAnswer((_) async => Left(tFailure));

    //Act
    await store.getSpaceMediaFromDate(tDate);

    //Assert
    store.observer(
      onError: (error) {
        expect(error, tFailure);
        verify(() => mockUsecase(any())).called(1);
      },
    );
  });
}
