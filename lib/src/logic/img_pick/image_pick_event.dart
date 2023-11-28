part of 'image_pick_bloc.dart';

sealed class ImagePickEvent extends Equatable {
  const ImagePickEvent();

  @override
  List<Object> get props => [];
}

class ChooseImageEvent extends ImagePickEvent {
  final ImageSource source;
  const ChooseImageEvent({required this.source});
}