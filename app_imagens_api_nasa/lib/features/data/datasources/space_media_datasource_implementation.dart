//Fazer chamada para API

import 'dart:convert';
import 'package:project_test/core/usecase/errors/exceptions.dart';
import 'package:project_test/core/utils/keys/convertes/date_input_converter.dart';
import 'package:project_test/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:project_test/features/data/datasources/space_media_datasource.dart';
import 'package:project_test/features/data/models/space_media_model.dart';
import 'package:http/http.dart' as http;

// faz a ligação com a API
class SpaceMediaDatasouceImplementation implements ISpaceMediaDatasource {
  final DateInputConverter converter;
  final http.Client client;

  SpaceMediaDatasouceImplementation({
    required this.converter,
    required this.client,
  });

// Caso a conexão com a API der FALHA, retorna o erro 200. caso seja SUCESSO, retorna "ServerExceptions"
  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final dateConverted = converter.format(date);
    final response = await client.get(
      NasaEndpoints.getSpaceMedia(
        'DEMO_KEY',
        dateConverted,
      ),
    );
    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw ServerExceptions();
    }
  }
}
