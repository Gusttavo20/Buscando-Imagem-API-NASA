import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:project_test/core/usecase/errors/exceptions.dart';
import 'package:project_test/core/utils/keys/convertes/date_input_converter.dart';
import 'package:project_test/features/data/datasources/space_media_datasource_implementation.dart';
import 'package:http/http.dart' as http;
import 'package:project_test/features/data/models/space_media_model.dart';

import '../../mocks/space_media_mock.dart';

class MockDateInputConverter extends Mock implements DateInputConverter {}

class MockClient extends Mock implements http.Client {}

void main() {
  late SpaceMediaDatasouceImplementation datasource;
  late DateInputConverter converter;
  late http.Client client;

  setUp(() {
    converter = MockDateInputConverter();
    client = MockClient();
    datasource = SpaceMediaDatasouceImplementation(
      converter: converter,
      client: client,
    );
    registerFallbackValue<DateTime>(DateTime(2000));
    registerFallbackValue<Uri>(Uri());
  });

  final tDateTimeString = '2021-02-02';

  final tDateTime = DateTime(2021, 02, 02);

  final tSpaceMediaModel = SpaceMediaModel(
    description: 'Gustavo Marques',
    mediaType: 'image',
    title: 'Gustavo',
    mediaUrl:
        'https://apod.nasa.gov/apod/image/2102/MeteorStreak_Kuszaj_1080.jpg',
  );
  void successMock() {
    when(() => converter.format(any())).thenReturn(tDateTimeString);
    when(() => client.get(any()))
        .thenAnswer((_) async => http.Response(spaceMediaMock, 200));
  }

  test('deve chamar DateInputConverter para converter o DateTime em uma String',
      () async {
    // Arrange
    successMock();
    // Act
    await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    verify(() => converter.format(tDateTime)).called(1);
  });

  test('deve chamar o método get com o URL correto', () async {
    // Arrange
    successMock();
    // Act
    await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    verify(() => client.get(Uri.https('api.nasa.gov', '/planetary/apod', {
          'api_key': 'DEMO_KEY',
          'date': '2021-02-02',
        }))).called(1);
  });
  test('deve retornar um SpaceMediaModel quando a chamada for bem-sucedida',
      () async {
    // Arrange
    successMock();
    // Act
    final result = await datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    expect(result, tSpaceMediaModel);
    verify(() => converter.format(tDateTime)).called(1);
  });
  test('deve lançar um ServerException quando a chamada não for acessada',
      () async {
    // Arrange
    when(() => converter.format(any())).thenReturn(tDateTimeString);
    when(() => client.get(any()))
        .thenAnswer((_) async => http.Response('algo deu errado', 400));
    // Act
    final result = datasource.getSpaceMediaFromDate(tDateTime);
    // Assert
    expect(() => result, throwsA(ServerExceptions()));
    verify(() => converter.format(tDateTime)).called(1);
  });
}
