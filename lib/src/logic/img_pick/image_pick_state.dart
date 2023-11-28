part of 'image_pick_bloc.dart';

sealed class ImagePickState extends Equatable {
  const ImagePickState({this.file});
    final File? file;

  @override
  List<Object?> get props => [identityHashCode(this),file];
}

final class ImagePickInitial extends ImagePickState {
  final File? selected;
  const ImagePickInitial({this.selected}):super(file: selected);
}
