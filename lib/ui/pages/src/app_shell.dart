import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pic_sum/logic/logic.dart';
import 'package:pic_sum/ui/ui.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final filterAuthor = context.read<PicsCubit>().filterByAuthor;
    final setLimit = context.read<PicsCubit>().setPageSize;
    return BlocListener<PicsCubit, PicsState>(
      listener: (context, state) {
        if (state is UIMessage) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
              ),
              backgroundColor: state.successful ? Colors.green : Colors.red,
              duration: const Duration(
                seconds: 2,
              ),
            ),
          );
        } else if (state is DialogInput) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text(state.input == Input.string
                      ? 'Filter by authors'
                      : 'Number of items per page'),
                  content: state.input == Input.string
                      ? TextField(
                          onSubmitted: (value) {
                            filterAuthor(value);
                          },
                        )
                      : PagePicker(select: (index) => setLimit(index)));
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const PhotoFilterBar()),
        body: const Center(
          child: PhotoPage(),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                final cubit = context.read<PicsCubit>();
                cubit.previousPage();
              },
              child: const Icon(Icons.arrow_back),
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () {
                final cubit = context.read<PicsCubit>();
                cubit.nextPage();
              },
              child: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
    );
  }
}
