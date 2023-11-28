import 'dart:io';

import 'package:biller/src/data/models/customers_list_model.dart';
import 'package:biller/src/data/service/abstraction/customers_service.dart';
import 'package:biller/src/data/service/abstraction/image_pick_service.dart';
import 'package:image_picker/image_picker.dart';

class CustomersRepo {
  final CustomersService _customersService;
  final ImagePickerService _imagePickerService;

  CustomersRepo({required CustomersService customersService, required ImagePickerService imagePickerService}) : _customersService = customersService, _imagePickerService = imagePickerService;

  Future<List<CustomersListModel>> getCustomers() async {
    return _customersService.getCustomers();
  }

  Future<File?> pickImg({required ImageSource source}){
    return _imagePickerService.pickImageFromDevice(source: source);
  }

  Future<bool> createCustomer({required Map<String, String> customer, required File path}) async {
    return _customersService.createCustomer(customer: customer, path: path);
  }
}