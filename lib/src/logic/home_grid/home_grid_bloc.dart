import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_grid_event.dart';
part 'home_grid_state.dart';

class HomeGridBloc extends Bloc<HomeGridEvent, HomeGridState> {
  HomeGridBloc() : super(const HomeGridInitial()) {
    on<ChangeGridIndex>((event, emit) {
      emit(HomeGridInitial(selected: event.index));
    });
  }
}
