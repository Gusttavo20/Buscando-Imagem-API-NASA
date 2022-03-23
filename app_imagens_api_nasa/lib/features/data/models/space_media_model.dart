import 'package:project_test/features/domain/entities/space_media.dart';

//Extendendo a Entidade
class SpaceMediaModel extends SpaceMediaEntity {
  const SpaceMediaModel({
    required String description,
    required String mediaType,
    required String title,
    required String mediaUrl,
  }) : super(
          description: description,
          mediaType: mediaType,
          title: title,
          mediaUrl: mediaUrl,
        );
  //Receber dados da API
  factory SpaceMediaModel.fromJson(Map<String, dynamic> json) =>
      SpaceMediaModel(
        description: json['explanation'],
        mediaType: json['media_type'],
        title: json['title'],
        mediaUrl: json['url'],
      );
  //Enviar dados para API
  Map<String, dynamic> toJson() => {
        'explanation': description,
        'media_type': mediaType,
        'title': title,
        'url': mediaUrl,
      };
}
