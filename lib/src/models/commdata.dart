class CommunityData {
  String? groupId;
  String? imageUrl;
  String? name;
  String? description;
  int? count;
  bool? isPublic;
  CommunityData({
    this.name,
    this.description,
    this.count,
    this.imageUrl,
    this.groupId,
    this.isPublic = false,
  });
}
