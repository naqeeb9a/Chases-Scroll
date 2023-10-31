class EventDraftModel {
  String? eventType;
  String? eventName;
  String? eventDescription;
  String? locationType;
  String? currency;
  String? currentPicUrl;
  String? eventFunnelGroupID;
  String? mediaType;
  String? currentVideoUrl;
  bool? isPublic;
  bool? isExclusive;
  bool? mask;
  bool? attendeesVisibility;
  int? startTime;
  int? endTime;
  int? startDate;
  int? endDate;
  int? expirationDate;
  Location? location;

  EventDraftModel(
      {this.eventType,
      this.eventName,
      this.eventDescription,
      this.locationType,
      this.currency,
      this.currentPicUrl,
      this.eventFunnelGroupID,
      this.mediaType,
      this.currentVideoUrl,
      this.isPublic,
      this.isExclusive,
      this.mask,
      this.attendeesVisibility,
      this.startTime,
      this.endTime,
      this.startDate,
      this.endDate,
      this.expirationDate,
      this.location});

  EventDraftModel.fromJson(Map<String, dynamic> json) {
    eventType = json['eventType'];
    eventName = json['eventName'];
    eventDescription = json['eventDescription'];
    locationType = json['locationType'];
    currency = json['currency'];
    currentPicUrl = json['currentPicUrl'];
    eventFunnelGroupID = json['eventFunnelGroupID'];
    mediaType = json['mediaType'];
    currentVideoUrl = json['currentVideoUrl'];
    isPublic = json['isPublic'];
    isExclusive = json['isExclusive'];
    mask = json['mask'];
    attendeesVisibility = json['attendeesVisibility'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    expirationDate = json['expirationDate'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventType'] = eventType;
    data['eventName'] = eventName;
    data['eventDescription'] = eventDescription;
    data['locationType'] = locationType;
    data['currency'] = currency;
    data['currentPicUrl'] = currentPicUrl;
    data['eventFunnelGroupID'] = eventFunnelGroupID;
    data['mediaType'] = mediaType;
    data['currentVideoUrl'] = currentVideoUrl;
    data['isPublic'] = isPublic;
    data['isExclusive'] = isExclusive;
    data['mask'] = mask;
    data['attendeesVisibility'] = attendeesVisibility;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['expirationDate'] = expirationDate;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class Location {
  String? link;
  String? address;
  String? locationDetails;
  String? latlng;
  String? placeIds;
  bool? toBeAnnounced;

  Location(
      {this.link,
      this.address,
      this.locationDetails,
      this.latlng,
      this.placeIds,
      this.toBeAnnounced});

  Location.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    address = json['address'];
    locationDetails = json['locationDetails'];
    latlng = json['latlng'];
    placeIds = json['placeIds'];
    toBeAnnounced = json['toBeAnnounced'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['link'] = link;
    data['address'] = address;
    data['locationDetails'] = locationDetails;
    data['latlng'] = latlng;
    data['placeIds'] = placeIds;
    data['toBeAnnounced'] = toBeAnnounced;
    return data;
  }
}
