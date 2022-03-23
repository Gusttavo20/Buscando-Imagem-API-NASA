import 'package:flutter_triple/flutter_triple.dart';
import 'package:project_test/core/usecase/errors/failures.dart';
import 'package:project_test/features/domain/entities/space_media.dart';
import 'package:project_test/features/domain/usecases/get_space_media_from_date_usercase.dart';

// controle das paginas

class HomeStore extends NotifierStore<Failure, SpaceMediaEntity> {
  final GetSpaceMediaFromDateUsecase usecase;

  HomeStore(this.usecase)
      : super(
          const SpaceMediaEntity(
              description: '', mediaType: '', title: '', mediaUrl: ''),
        );

  getSpaceMediaFromDate(DateTime? date) async {
    setLoading(true);
    final result = await usecase(ParamsGetSpaceMedia(date: date!));
    result.fold(
      (error) => setError(error),
      (success) => update(success),
    );
    setLoading(false);
  }
}
