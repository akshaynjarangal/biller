import 'package:biller/src/data/service/abstraction/db_service.dart';

class DBRepository {
  final DBService _dbService;
  DBRepository({required DBService dbService}) : _dbService = dbService;

  void setupDBAdapter () {
    _dbService.registerAdapter();
  }
}