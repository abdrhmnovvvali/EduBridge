extension ObjectExtension on Object? {
  String? get valueOrNull => this == null ? null : '$this';
}
