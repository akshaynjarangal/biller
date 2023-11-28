part of 'home_grid_bloc.dart';

sealed class HomeGridEvent extends Equatable {
  const HomeGridEvent();

  @override
  List<Object> get props => [];
}

final class ChangeGridIndex extends HomeGridEvent {
  final int index;
  const ChangeGridIndex({required this.index});
}