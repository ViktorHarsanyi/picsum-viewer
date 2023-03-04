import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pic_sum/logic/logic.dart';

import 'package:pic_sum/ui/ui.dart';

import 'photo_detail_page.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({super.key});

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  late final ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PicsCubit, PicsState>(
      buildWhen: (p, c) => c.photos.isNotEmpty,
      builder: (context, state) {
        return state is Update
            ? PhotoGrid(
                state.photos,
                controller: _controller,
                onPressed: (photo) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          PhotoDetailsPage(photo),
                    ),
                  );
                },
              )
            : const CircularProgressIndicator.adaptive();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }
}
