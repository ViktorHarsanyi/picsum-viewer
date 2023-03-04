import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pic_sum/logic/logic.dart';

class PhotoFilterBar extends StatefulWidget {
  const PhotoFilterBar({super.key});

  @override
  State<PhotoFilterBar> createState() => _PhotoFilterBarState();
}

class _PhotoFilterBarState extends State<PhotoFilterBar> {
  late final TextEditingController _limitController;
  late final TextEditingController _filterController;
  @override
  Widget build(BuildContext context) {
    final requestInput = context.read<PicsCubit>().requestInputDialog;
    return BlocBuilder<PicsCubit, PicsState>(
        buildWhen: (p, c) => c is PageStatus,
        builder: (context, state) {
          _limitController.text =
              state is PageStatus ? state.limit.toString() : '';
          _filterController.text = state is PageStatus ? state.filter : '';
          return Row(
            children: [
              IconButton(
                onPressed: () => requestInput(Input.number),
                icon: const Icon(Icons.numbers),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.topCenter,
                  child: Text(
                    state is PageStatus ? state.pageNumber.toString() : '',
                  ),
                ),
              ),
              IconButton(
                onPressed: () => requestInput(Input.string),
                icon: const Icon(Icons.search),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _limitController = TextEditingController();
    _filterController = TextEditingController();
  }

  @override
  void dispose() {
    _filterController.dispose();
    _limitController.dispose();
    super.dispose();
  }
}
