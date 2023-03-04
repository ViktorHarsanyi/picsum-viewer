import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pic_sum/data/data.dart';
import 'package:pic_sum/service/service.dart';
import 'package:rxdart/rxdart.dart';

part 'pics_state.dart';

class PicsCubit extends Cubit<PicsState> {
  final PhotoService _api;
  final _pageSizeController = BehaviorSubject<int>.seeded(100);

  late final StreamSubscription _pageSizeSubscription;

  PicsCubit({PhotoService? service})
      : _api = service ?? PhotoService(),
        super(const Empty()) {
    _pageSizeSubscription = _pageSizeController
        .debounceTime(const Duration(milliseconds: 500))
        .listen((pageSize) {
      emit(const Loading());
      loadPhotos();
    });
  }

  Future<void> loadPhotos() async {
    final photos = await _api.getPhotos(limit: _pageSizeController.value);
    if (photos.isNotEmpty) {
      emit(Update(photos));
      _api.resetFilter();
      emit(_api.status);
    } else {
      emit(const UIMessage(
        'Failed to load photos.',
        false,
      ));
    }
  }

  void nextPage() async {
    bool pageValid = _api.nextPage();
    if (pageValid) {
      await loadPhotos();
    } else {
      previousPage();
      emit(const UIMessage(
        'Page not found',
        false,
      ));
    }
  }

  void previousPage() async {
    bool pageValid = _api.previousPage();
    if (pageValid) {
      await loadPhotos();
    } else {
      emit(const UIMessage(
        'Page not found',
        false,
      ));
    }
  }

  void setPageSize(int size) async {
    _pageSizeController.add(size);
    _api.resetPage();
    await loadPhotos();
  }

  void requestInputDialog(Input input) {
    emit(DialogInput(input));
  }

  void filterByAuthor(String? runes) {
    if (runes != null && runes.isNotEmpty) {
      List<Photo> matched = _api.filter(runes);

      if (matched.isNotEmpty) {
        emit(Update(matched));
        emit(_api.status);
        emit(UIMessage(
          'Search matched ${matched.length} photos',
          true,
        ));
      } else {
        emit(const UIMessage(
          'No matches found.',
          false,
        ));
      }
    } else if (state.photos.isEmpty) {
      final cache = _api.cache;
      if (cache.isNotEmpty) {
        emit(Update(cache));
        emit(_api.status);
      } else {
        loadPhotos();
      }
    }
  }

  @override
  Future<void> close() {
    _pageSizeSubscription.cancel();
    _pageSizeController.close();
    return super.close();
  }
}
