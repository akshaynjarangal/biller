part of 'bottom_nav_bloc.dart';

sealed class BottomNavState extends Equatable {
  const BottomNavState({required this.index});
  final int index;
  @override
  List<Object> get props => [identityHashCode(this)];
}

final class BottomNavInitial extends BottomNavState {
  final int selectedIndex;
  const BottomNavInitial({required this.selectedIndex}):super(index: selectedIndex);
}
