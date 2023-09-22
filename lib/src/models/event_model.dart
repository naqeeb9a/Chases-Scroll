class ContentEvent {
  String id;
  dynamic createdDate;
  EdBy lastModifiedBy;
  EdBy createdBy;
  dynamic lastModifiedDate;
  bool isDeleted;
  List<String> picUrls;
  String eventName;
  String eventDescription;
  String eventType;
  String joinSetting;
  String locationType;
  String currency;
  String currentPicUrl;
  dynamic eventFunnelGroupId;
  String mediaType;
  dynamic currentVideoUrl;
  bool isPublic;
  bool isExclusive;
  dynamic mask;
  bool isOrganizer;
  bool attendeesVisibility;
  bool isJoined;
  dynamic minPrice;
  dynamic maxPrice;
  dynamic startTime;
  dynamic endTime;
  dynamic startDate;
  dynamic endDate;
  dynamic expirationDate;
  int memberCount;
  Location location;
  List<ProductTypeDatum> productTypeData;

  ContentEvent({
    required this.id,
    required this.createdDate,
    required this.lastModifiedBy,
    required this.createdBy,
    required this.lastModifiedDate,
    required this.isDeleted,
    required this.picUrls,
    required this.eventName,
    required this.eventDescription,
    required this.eventType,
    required this.joinSetting,
    required this.locationType,
    required this.currency,
    required this.currentPicUrl,
    this.eventFunnelGroupId,
    required this.mediaType,
    this.currentVideoUrl,
    required this.isPublic,
    required this.isExclusive,
    this.mask,
    required this.isOrganizer,
    required this.attendeesVisibility,
    required this.isJoined,
    this.minPrice,
    this.maxPrice,
    required this.startTime,
    required this.endTime,
    required this.startDate,
    required this.endDate,
    this.expirationDate,
    required this.memberCount,
    required this.location,
    required this.productTypeData,
  });

  factory ContentEvent.fromJson(Map<String, dynamic> json) => ContentEvent(
        id: json["id"],
        createdDate: json["createdDate"],
        lastModifiedBy: EdBy.fromJson(json["lastModifiedBy"]),
        createdBy: EdBy.fromJson(json["createdBy"]),
        lastModifiedDate: json["lastModifiedDate"],
        isDeleted: json["isDeleted"],
        picUrls: List<String>.from(json["picUrls"].map((x) => x)),
        eventName: json["eventName"],
        eventDescription: json["eventDescription"],
        eventType: json["eventType"],
        joinSetting: json["joinSetting"],
        locationType: json["locationType"],
        currency: json["currency"],
        currentPicUrl: json["currentPicUrl"],
        eventFunnelGroupId: json["eventFunnelGroupID"],
        mediaType: json["mediaType"],
        currentVideoUrl: json["currentVideoUrl"],
        isPublic: json["isPublic"],
        isExclusive: json["isExclusive"],
        mask: json["mask"],
        isOrganizer: json["isOrganizer"],
        attendeesVisibility: json["attendeesVisibility"],
        isJoined: json["isJoined"],
        minPrice: json["minPrice"],
        maxPrice: json["maxPrice"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        expirationDate: json["expirationDate"],
        memberCount: json["memberCount"],
        location: Location.fromJson(json["location"]),
        productTypeData: List<ProductTypeDatum>.from(
            json["productTypeData"].map((x) => ProductTypeDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate,
        "lastModifiedBy": lastModifiedBy.toJson(),
        "createdBy": createdBy.toJson(),
        "lastModifiedDate": lastModifiedDate,
        "isDeleted": isDeleted,
        "picUrls": List<dynamic>.from(picUrls.map((x) => x)),
        "eventName": eventName,
        "eventDescription": eventDescription,
        "eventType": eventType,
        "joinSetting": joinSetting,
        "locationType": locationType,
        "currency": currency,
        "currentPicUrl": currentPicUrl,
        "eventFunnelGroupID": eventFunnelGroupId,
        "mediaType": mediaType,
        "currentVideoUrl": currentVideoUrl,
        "isPublic": isPublic,
        "isExclusive": isExclusive,
        "mask": mask,
        "isOrganizer": isOrganizer,
        "attendeesVisibility": attendeesVisibility,
        "isJoined": isJoined,
        "minPrice": minPrice,
        "maxPrice": maxPrice,
        "startTime": startTime,
        "endTime": endTime,
        "startDate": startDate,
        "endDate": endDate,
        "expirationDate": expirationDate,
        "memberCount": memberCount,
        "location": location.toJson(),
        "productTypeData":
            List<dynamic>.from(productTypeData.map((x) => x.toJson())),
      };
}

class EdBy {
  String userId;
  String firstName;
  String lastName;
  String username;
  String dob;
  bool publicProfile;
  String joinStatus;
  Map<String, Datum> data;

  EdBy({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.dob,
    required this.publicProfile,
    required this.joinStatus,
    required this.data,
  });

  factory EdBy.fromJson(Map<String, dynamic> json) => EdBy(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        username: json["username"],
        dob: json["dob"],
        publicProfile: json["publicProfile"],
        joinStatus: json["joinStatus"],
        data: Map.from(json["data"])
            .map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "dob": dob,
        "publicProfile": publicProfile,
        "joinStatus": joinStatus,
        "data": Map.from(data)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Datum {
  bool objectPublic;
  dynamic value;

  Datum({
    required this.objectPublic,
    this.value,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        objectPublic: json["objectPublic"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "objectPublic": objectPublic,
        "value": value,
      };
}

class Location {
  dynamic link;
  String address;
  String locationDetails;
  String? latlng; // Nullable String
  String? placeIds; // Nullable String

  Location({
    this.link,
    required this.address,
    required this.locationDetails,
    this.latlng, // Nullable String
    this.placeIds, // Nullable String
  });

  factory Location.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Location(
        address: '',
        locationDetails: '',
      );
    }

    return Location(
      link: json["link"],
      address: json["address"] ?? '',
      locationDetails: json["locationDetails"] ?? '',
      latlng: json["latlng"],
      placeIds: json["placeIds"],
    );
  }

  Map<String, dynamic> toJson() => {
        "link": link,
        "address": address,
        "locationDetails": locationDetails,
        "latlng": latlng,
        "placeIds": placeIds,
      };
}

class ProductTypeDatum {
  dynamic totalNumberOfTickets;
  dynamic ticketPrice;
  String ticketType;
  int ticketsSold;
  dynamic sale;
  int minTicketBuy;
  dynamic maxTicketBuy;

  ProductTypeDatum({
    this.totalNumberOfTickets,
    required this.ticketPrice,
    required this.ticketType,
    required this.ticketsSold,
    this.sale,
    required this.minTicketBuy,
    this.maxTicketBuy,
  });

  factory ProductTypeDatum.fromJson(Map<String, dynamic> json) =>
      ProductTypeDatum(
        totalNumberOfTickets: json["totalNumberOfTickets"],
        ticketPrice: json["ticketPrice"],
        ticketType: json["ticketType"],
        ticketsSold: json["ticketsSold"],
        sale: json["sale"],
        minTicketBuy: json["minTicketBuy"],
        maxTicketBuy: json["maxTicketBuy"],
      );

  Map<String, dynamic> toJson() => {
        "totalNumberOfTickets": totalNumberOfTickets,
        "ticketPrice": ticketPrice,
        "ticketType": ticketType,
        "ticketsSold": ticketsSold,
        "sale": sale,
        "minTicketBuy": minTicketBuy,
        "maxTicketBuy": maxTicketBuy,
      };
}
