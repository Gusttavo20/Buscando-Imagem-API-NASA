import 'package:flutter/material.dart';
import 'package:social_share/social_share.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;

  CustomAppBar({required this.title}) : preferredSize = Size.fromHeight(50.0);

  compartilharFoto() {
    final foto = "gustavo";
    SocialShare.shareOptions('Gustavo');
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
      ),
      actions: [
        IconButton(
          onPressed: compartilharFoto,
          icon: Icon(Icons.share),
        ),
      ],
      backgroundColor: const Color(0xFF233C5C),
    );
  }
}
