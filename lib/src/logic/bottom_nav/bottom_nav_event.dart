part of 'bottom_nav_bloc.dart';

sealed class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object> get props => [];
}

final class ChangeIndex extends BottomNavEvent {
  final int index;

  const ChangeIndex({required this.index});
}