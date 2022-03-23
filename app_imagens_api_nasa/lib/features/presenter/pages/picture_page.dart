import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:project_test/features/domain/entities/space_media.dart';
import 'package:project_test/features/presenter/controllers/home_store.dart';
import 'package:project_test/features/presenter/widgets/custom_video_player.dart';
import 'package:project_test/features/presenter/widgets/description_bottom_sheet.dart';
import 'package:project_test/features/presenter/widgets/image_network_with_loader.dart';
import 'package:project_test/features/presenter/widgets/page_slider_up.dart';

// pagina

class PicturePage extends StatefulWidget {
  late final DateTime? dateSelected;

  PicturePage({
    Key? key,
    this.dateSelected,
  }) : super(key: key);

  PicturePage.fromArgs(dynamic arguments) {
    dateSelected = arguments['dateSelected'];
  }

  static void navigate(DateTime? dateSelected) {
    Modular.to.pushNamed(
      '/picture',
      arguments: {'dateSelected': dateSelected},
    );
  }

  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends ModularState<PicturePage, HomeStore> {
  @override
  void initState() {
    super.initState();
    store.getSpaceMediaFromDate(widget.dateSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ScopedBuilder(
        store: store,
        onLoading: (context) => Center(child: CircularProgressIndicator()),
        onError: (context, error) => Center(
          child: Text(
            'Ocorreu um erro, tente novamente mais tarde.',
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: Colors.white),
          ),
        ),
        onState: (context, SpaceMediaEntity spaceMedia) {
          return PageSliderUp(
            onSlideUp: () => showDescriptionBottomSheet(
              context: context,
              title: spaceMedia.title,
              description: spaceMedia.description,
            ),
            child: spaceMedia.mediaType == 'video' &&
                    spaceMedia.mediaUrl != null
                ? CustomVideoPlayer(spaceMedia)
                : spaceMedia.mediaType == 'image' && spaceMedia.mediaUrl != null
                    ? ImageNetworkWithLoader(spaceMedia.mediaUrl)
                    : Container(),
          );
        },
      ),
    );
  }
}
