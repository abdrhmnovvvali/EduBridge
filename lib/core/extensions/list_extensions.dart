import '../base/model/base_model.dart';

extension ListExtensions<T> on List<T>? {
  bool get isNotEmptyOrNull => this != null && this!.isNotEmpty;
  bool get isEmptyOrNull => this == null || this!.isEmpty;

  List<Map<dynamic, dynamic>>? get convertToMapList {
    if (this == null) return null;
    final List<Map<dynamic, dynamic>> items = [];
    for (final item in this!) {
      items.add((item as BaseModel).toJson());
    }
    return items;
  }

  List<T> asMapEntries(T Function(MapEntry<int, T>) child) =>
      this!.asMap().entries.map(child).toList();

  // Function to split list into sublists
  List<List<T>> splitList(int chunkSize) {
    final List<List<T>> chunks = [];
    for (var i = 0; i < this!.length; i += chunkSize) {
      final int end = (i + chunkSize < this!.length)
          ? i + chunkSize
          : this!.length;
      chunks.add(this!.sublist(i, end));
    }
    return chunks;
  }

  void addIfNotExists(T value) {
    if (!this!.contains(value)) this!.add(value);
  }
}
