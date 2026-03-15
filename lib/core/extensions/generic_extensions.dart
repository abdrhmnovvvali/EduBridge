import '../base/model/base_model.dart';

extension GenericExtensions<T> on T? {
  Map<dynamic, dynamic> get convertToMap => (this as BaseModel).toJson();
}
