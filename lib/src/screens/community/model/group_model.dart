class CommunityInfoModel {
  String? groupId;
  String? name;
  String? image;
  dynamic content;
  String? description;
  bool? isPublic;

  CommunityInfoModel(
      {this.groupId, this.name, this.image, this.content, this.description, this.isPublic});
}
