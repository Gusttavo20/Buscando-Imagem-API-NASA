import 'package:equatable/equatable.dart';

//Parte das entidades que ficam dentro de domain. As famosas "Classes"

class SpaceMediaEntity extends Equatable {
  final String description;
  final String mediaType;
  final String title;
  final String mediaUrl;

  const SpaceMediaEntity({
    required this.description,
    required this.mediaType,
    required this.title,
    required this.mediaUrl,
  });

  @override
  List<Object> get props => [
        description,
        mediaType,
        title,
        mediaUrl,
      ];
}
