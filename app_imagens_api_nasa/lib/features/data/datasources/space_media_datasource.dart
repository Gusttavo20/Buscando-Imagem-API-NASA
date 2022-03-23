import 'package:project_test/features/data/models/space_media_model.dart';

// contrato de como deve ser a conexão com a API

abstract class ISpaceMediaDatasource {
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date);
}
