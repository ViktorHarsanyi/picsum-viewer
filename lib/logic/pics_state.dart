part of 'pics_cubit.dart';

@immutable
abstract class PicsState {
  final List<Photo> photos;
  const PicsState(this.photos);
}

class Empty extends PicsState {
  const Empty() : super(const []);
}

class Update extends PicsState {
  const Update(super.photos);
}

class Loading extends PicsState {
  const Loading() : super(const []);
}

class PageStatus extends PicsState {
  final int limit;
  final int pageNumber;
  final String filter;

  const PageStatus(
    this.limit,
    this.pageNumber,
    this.filter,
  ) : super(const []);
}

class UIMessage extends PicsState {
  final String message;
  final bool successful;
  const UIMessage(this.message, this.successful) : super(const []);
}

class DialogInput extends PicsState {
  final Input input;
  const DialogInput(this.input) : super(const []);
}

enum Input {
  number,
  string,
}
