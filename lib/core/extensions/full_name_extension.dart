extension FullNameExt on String? {
  String combine(String? other) {
    final a = (this ?? '').trim();
    final b = (other ?? '').trim();

    if (a.isEmpty && b.isEmpty) return '';
    if (a.isEmpty) return b;
    if (b.isEmpty) return a;

    return '$a $b';
  }
}
