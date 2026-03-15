import 'package:uuid/uuid.dart';

class IdGeneratorService {
  static const Uuid _uuid = Uuid();

  static String get generateId => _uuid.v1();
}
