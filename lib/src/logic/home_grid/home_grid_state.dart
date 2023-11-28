part of 'home_grid_bloc.dart';

sealed class HomeGridState extends Equatable {
  const HomeGridState({this.gridIndex});
  final int? gridIndex;
  @override
  List<Object> get props => [identityHashCode(this)];
}

final class HomeGridInitial extends HomeGridState {
  final int? selected;
  const HomeGridInitial({this.selected}):super(gridIndex: selected);
}
