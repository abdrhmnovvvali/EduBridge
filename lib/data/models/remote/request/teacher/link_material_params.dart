class LinkMaterialParams {
  final int classId;
  final String title;
  final String linkUrl;
  final String type;

  LinkMaterialParams({
    required this.classId,
    required this.title,
    required this.linkUrl,
    this.type = 'LINK',
  });

  Map<String, dynamic> toJson() => {
        "classId": classId,
        "title": title,
        "linkUrl": linkUrl,
        "type": type,
      };
}
