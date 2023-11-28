import 'dart:developer';
import 'dart:io';
import 'package:biller/src/data/repositories/customers_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'image_pick_event.dart';
part 'image_pick_state.dart';

class ImagePickBloc extends Bloc<ImagePickEvent, ImagePickState> {
  final CustomersRepo _customersRepo;
  ImagePickBloc(this._customersRepo) : super(const ImagePickInitial()) {
    on<ChooseImageEvent>((event, emit) async {
      final res = await _customersRepo.pickImg(source: event.source);
      if(res!=null){
        log(res.path);
        emit(ImagePickInitial(selected: res));
      }
    });
  }
}
