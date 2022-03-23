import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:project_test/features/data/models/space_media_model.dart';
import 'package:project_test/features/domain/entities/space_media.dart';

import '../../../features/mocks/space_media_mock.dart';

void main() {
  final tSpaceMediaModel = SpaceMediaModel(
    description: 'Gustavo Marques',
    mediaType: 'image',
    title: 'Gustavo',
    mediaUrl:
        'https://apod.nasa.gov/apod/image/2102/MeteorStreak_Kuszaj_1080.jpg',
  );
  test('deve ser uma subclasse de SpaceMediaEnttity', () {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  //"Json" pegar dados da API
  test('deve retornar um modelo válido', () {
    //Arrange
    final Map<String, dynamic> jsonMap = json.decode(spaceMediaMock);

    //Act
    final result = SpaceMediaModel.fromJson(jsonMap);

    //Assert
    expect(result, tSpaceMediaModel);
  });

  //"FromJson" Mardar dados para API
  test('deve retornar um mapa json contendo os dados apropriados', () {
    //Arrange
    final expectedMap = {
      "explanation": "Gustavo Marques",
      "media_type": "image",
      "title": "Gustavo",
      "url":
          "https://apod.nasa.gov/apod/image/2102/MeteorStreak_Kuszaj_1080.jpg"
    };

    //Act
    final result = tSpaceMediaModel.toJson();

    //Assert
    expect(result, expectedMap);
  });
}
