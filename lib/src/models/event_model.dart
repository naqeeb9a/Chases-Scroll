//suggested users
class Content {
  String? id;
  int? createdDate;
  LastModifiedBy? lastModifiedBy;
  LastModifiedBy? createdBy;
  int? lastModifiedDate;
  bool? isDeleted;
  List<String>? picUrls;
  String? eventName;
  String? eventDescription;
  String? eventType;
  String? locationType;
  String? currency;
  String? currentPicUrl;
  String? eventFunnelGroupID;
  String? mediaType;
  String? currentVideoUrl;
  bool? isPublic;
  bool? isExclusive;
  bool? mask;
  bool? isOrganizer;
  bool? attendeesVisibility;
  bool? isJoined;
  bool? isSaved;
  bool? isFree;
  bool? isBought;
  bool? ticketBought;
  double? minPrice;
  double? maxPrice;
  int? startTime;
  int? endTime;
  int? startDate;
  int? endDate;
  int? expirationDate;
  int? memberCount;
  Location? location;
  List<ProductTypeData>? productTypeData;

  Content({
    this.id,
    this.createdDate,
    this.lastModifiedBy,
    this.createdBy,
    this.lastModifiedDate,
    this.isDeleted,
    this.picUrls,
    this.eventName,
    this.eventDescription,
    this.eventType,
    this.locationType,
    this.currency,
    this.currentPicUrl,
    this.eventFunnelGroupID,
    this.mediaType,
    this.currentVideoUrl,
    this.isPublic,
    this.isExclusive,
    this.mask,
    this.isOrganizer,
    this.attendeesVisibility,
    this.isJoined,
    this.isSaved,
    this.isFree,
    this.isBought,
    this.ticketBought,
    this.minPrice,
    this.maxPrice,
    this.startTime,
    this.endTime,
    this.startDate,
    this.endDate,
    this.expirationDate,
    this.memberCount,
    this.location,
    this.productTypeData,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'],
      createdDate: json['createdDate'],
      lastModifiedBy: json['lastModifiedBy'] != null
          ? LastModifiedBy.fromJson(json['lastModifiedBy'])
          : null,
      createdBy: json['createdBy'] != null
          ? LastModifiedBy.fromJson(json['createdBy'])
          : null,
      lastModifiedDate: json['lastModifiedDate'],
      isDeleted: json['isDeleted'],
      picUrls: json['picUrls'].cast<String>(),
      eventName: json['eventName'],
      eventDescription: json['eventDescription'],
      eventType: json['eventType'],
      locationType: json['locationType'],
      currency: json['currency'],
      currentPicUrl: json['currentPicUrl'],
      eventFunnelGroupID: json['eventFunnelGroupID'],
      mediaType: json['mediaType'],
      currentVideoUrl: json['currentVideoUrl'],
      isPublic: json['isPublic'],
      isExclusive: json['isExclusive'],
      mask: json['mask'],
      isOrganizer: json['isOrganizer'],
      attendeesVisibility: json['attendeesVisibility'],
      isJoined: json['isJoined'],
      isSaved: json['isSaved'],
      isFree: json['isFree'],
      isBought: json['isBought'],
      ticketBought: json['ticketBought'],
      minPrice: json['minPrice'],
      maxPrice: json['maxPrice'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      expirationDate: json['expirationDate'],
      memberCount: json['memberCount'],
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      productTypeData: json['productTypeData'] != null
          ? (json['productTypeData'] as List)
              .map((v) => ProductTypeData.fromJson(v))
              .toList()
          : null,
    );
  }

  @override
  String toString() {
    return 'Content{id: $id, createdDate: $createdDate, lastModifiedBy: $lastModifiedBy, createdBy: $createdBy, lastModifiedDate: $lastModifiedDate, isDeleted: $isDeleted, picUrls: $picUrls, eventName: $eventName, eventDescription: $eventDescription, eventType: $eventType, locationType: $locationType, currency: $currency, currentPicUrl: $currentPicUrl, eventFunnelGroupID: $eventFunnelGroupID, mediaType: $mediaType, currentVideoUrl: $currentVideoUrl, isPublic: $isPublic, isExclusive: $isExclusive, mask: $mask, isOrganizer: $isOrganizer, attendeesVisibility: $attendeesVisibility, isJoined: $isJoined, isSaved: $isSaved, isFree: $isFree, isBought: $isBought, ticketBought: $ticketBought, minPrice: $minPrice, maxPrice: $maxPrice, startTime: $startTime, endTime: $endTime, startDate: $startDate, endDate: $endDate, expirationDate: $expirationDate, memberCount: $memberCount, location: $location, productTypeData: $productTypeData}';
  }
}

////////////////////////////////////////////////////////////////////////////////
///
///
///
class ContentEvent {
  List<ContentUser>? content;
  Pageable? pageable;
  int? totalPages;
  int? totalElements;
  bool? last;
  int? size;
  int? number;
  Sort? sort;
  bool? first;
  int? numberOfElements;
  bool? empty;

  ContentEvent(
      {this.content,
      this.pageable,
      this.totalPages,
      this.totalElements,
      this.last,
      this.size,
      this.number,
      this.sort,
      this.first,
      this.numberOfElements,
      this.empty});

  factory ContentEvent.fromJson(Map<String, dynamic> json) {
    return ContentEvent(
      content: json['content'] != null
          ? (json['content'] as List)
              .map((v) => ContentUser.fromJson(v))
              .toList()
          : null,
      pageable:
          json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null,
      totalPages: json['totalPages'],
      totalElements: json['totalElements'],
      last: json['last'],
      size: json['size'],
      number: json['number'],
      sort: json['sort'] != null ? Sort.fromJson(json['sort']) : null,
      first: json['first'],
      numberOfElements: json['numberOfElements'],
      empty: json['empty'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    if (pageable != null) {
      data['pageable'] = pageable!.toJson();
    }
    data['totalPages'] = totalPages;
    data['totalElements'] = totalElements;
    data['last'] = last;
    data['size'] = size;
    data['number'] = number;
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['first'] = first;
    data['numberOfElements'] = numberOfElements;
    data['empty'] = empty;
    return data;
  }

  @override
  String toString() {
    return 'ContentEvent{content: $content, pageable: $pageable, totalPages: $totalPages, totalElements: $totalElements, last: $last, size: $size, number: $number, sort: $sort, first: $first, numberOfElements: $numberOfElements, empty: $empty}';
  }
}

class ContentUser {
  String? userId;
  String? firstName;
  String? lastName;
  String? username;
  String? dob;
  bool? publicProfile;
  String? joinStatus;
  Data? data;

  ContentUser({
    this.userId,
    this.firstName,
    this.lastName,
    this.username,
    this.dob,
    this.publicProfile,
    this.data,
    this.joinStatus,
  });

  ContentUser.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] ?? "";
    firstName = json['firstName'] ?? "";
    lastName = json['lastName'] ?? "";
    username = json['username'] ?? "";
    dob = json['dob'] ?? "";

    publicProfile = json['publicProfile'] ?? false;
    joinStatus = json['joinStatus'] ?? "";
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['username'] = username;
    data['dob'] = dob;
    data['joinStatus'] = joinStatus;
    data['publicProfile'] = publicProfile;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return '{userId: $userId, firstName: $firstName, lastName: $lastName, username: $username, dob: $dob, publicProfile: $publicProfile, joinStatus: $joinStatus, data: $data}';
  }
}

class Country {
  bool? objectPublic;
  String? value;

  Country({this.objectPublic, this.value});

  Country.fromJson(Map<String, dynamic> json) {
    objectPublic = json['objectPublic'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectPublic'] = objectPublic;
    data['value'] = value;
    return data;
  }
}

class Data {
  MobilePhone? mobilePhone;
  Country? country;
  MobilePhone? imgMain;
  Country? images;
  MobilePhone? gender;
  Country? city;
  MobilePhone? webAddress;
  Country? work;
  MobilePhone? about;
  Country? state;
  Country? userSchool;
  Country? maritalStatus;
  Country? favorites;

  Data(
      {this.mobilePhone,
      this.country,
      this.imgMain,
      this.images,
      this.gender,
      this.city,
      this.webAddress,
      this.work,
      this.about,
      this.state,
      this.userSchool,
      this.maritalStatus,
      this.favorites});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      mobilePhone: json['mobilePhone'] != null
          ? MobilePhone.fromJson(json['mobilePhone'])
          : null,
      country:
          json['country'] != null ? Country.fromJson(json['country']) : null,
      imgMain: json['imgMain'] != null
          ? MobilePhone.fromJson(json['imgMain'])
          : null,
      images: json['images'] != null ? Country.fromJson(json['images']) : null,
      gender:
          json['gender'] != null ? MobilePhone.fromJson(json['gender']) : null,
      city: json['city'] != null ? Country.fromJson(json['city']) : null,
      webAddress: json['webAddress'] != null
          ? MobilePhone.fromJson(json['webAddress'])
          : null,
      work: json['work'] != null ? Country.fromJson(json['work']) : null,
      about: json['about'] != null ? MobilePhone.fromJson(json['about']) : null,
      state: json['state'] != null ? Country.fromJson(json['state']) : null,
      userSchool: json['userSchool'] != null
          ? Country.fromJson(json['userSchool'])
          : null,
      maritalStatus: json['maritalStatus'] != null
          ? Country.fromJson(json['maritalStatus'])
          : null,
      favorites: json['favorites'] != null
          ? Country.fromJson(json['favorites'])
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mobilePhone != null) {
      data['mobilePhone'] = mobilePhone!.toJson();
    }
    if (country != null) {
      data['country'] = country!.toJson();
    }
    if (imgMain != null) {
      data['imgMain'] = imgMain!.toJson();
    }
    if (images != null) {
      data['images'] = images!.toJson();
    }
    if (gender != null) {
      data['gender'] = gender!.toJson();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    if (webAddress != null) {
      data['webAddress'] = webAddress!.toJson();
    }
    if (work != null) {
      data['work'] = work!.toJson();
    }
    if (about != null) {
      data['about'] = about!.toJson();
    }
    if (state != null) {
      data['state'] = state!.toJson();
    }
    if (userSchool != null) {
      data['userSchool'] = userSchool!.toJson();
    }
    if (maritalStatus != null) {
      data['maritalStatus'] = maritalStatus!.toJson();
    }
    if (favorites != null) {
      data['favorites'] = favorites!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Data{'
        'mobilePhone: $mobilePhone, '
        'country: $country, '
        'imgMain: $imgMain, '
        'images: $images, '
        'gender: $gender, '
        'city: $city, '
        'webAddress: $webAddress, '
        'work: $work, '
        'about: $about, '
        'state: $state, '
        'userSchool: $userSchool, '
        'maritalStatus: $maritalStatus, '
        'favorites: $favorites'
        '}';
  }
}

class LastModifiedBy {
  String? userId;
  String? firstName;
  String? lastName;
  String? username;
  String? dob;
  bool? publicProfile;
  String? joinStatus;
  Data? data;

  LastModifiedBy(
      {this.userId,
      this.firstName,
      this.lastName,
      this.username,
      this.dob,
      this.publicProfile,
      this.joinStatus,
      this.data});

  factory LastModifiedBy.fromJson(Map<String, dynamic> json) {
    return LastModifiedBy(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      dob: json['dob'],
      publicProfile: json['publicProfile'],
      joinStatus: json['joinStatus'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['username'] = username;
    data['dob'] = dob;
    data['publicProfile'] = publicProfile;
    data['joinStatus'] = joinStatus;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'LastModifiedBy{'
        'userId: $userId, '
        'firstName: $firstName, '
        'lastName: $lastName, '
        'username: $username, '
        'dob: $dob, '
        'publicProfile: $publicProfile, '
        'joinStatus: $joinStatus, '
        'data: $data'
        '}';
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

class MobilePhone {
  bool? objectPublic;
  String? value;

  MobilePhone({this.objectPublic, this.value});

  MobilePhone.fromJson(Map<String, dynamic> json) {
    objectPublic = json['objectPublic'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectPublic'] = objectPublic;
    data['value'] = value;
    return data;
  }
}

class Pageable {
  Sort? sort;
  int? offset;
  int? pageNumber;
  int? pageSize;
  bool? unpaged;
  bool? paged;

  Pageable(
      {this.sort,
      this.offset,
      this.pageNumber,
      this.pageSize,
      this.unpaged,
      this.paged});

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    offset = json['offset'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    unpaged = json['unpaged'];
    paged = json['paged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['offset'] = offset;
    data['pageNumber'] = pageNumber;
    data['pageSize'] = pageSize;
    data['unpaged'] = unpaged;
    data['paged'] = paged;
    return data;
  }
}

class ProductTypeData {
  dynamic totalNumberOfTickets;
  double? ticketPrice;
  String? ticketType;
  int? ticketsSold;
  dynamic sale;
  int? minTicketBuy;
  int? maxTicketBuy;

  ProductTypeData(
      {this.totalNumberOfTickets,
      this.ticketPrice,
      this.ticketType,
      this.ticketsSold,
      this.sale,
      this.minTicketBuy,
      this.maxTicketBuy});

  ProductTypeData.fromJson(Map<String, dynamic> json) {
    totalNumberOfTickets = json['totalNumberOfTickets'];
    ticketPrice = json['ticketPrice'];
    ticketType = json['ticketType'];
    ticketsSold = json['ticketsSold'];
    sale = json['sale'];
    minTicketBuy = json['minTicketBuy'];
    maxTicketBuy = json['maxTicketBuy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalNumberOfTickets'] = totalNumberOfTickets;
    data['ticketPrice'] = ticketPrice;
    data['ticketType'] = ticketType;
    data['ticketsSold'] = ticketsSold;
    data['sale'] = sale;
    data['minTicketBuy'] = minTicketBuy;
    data['maxTicketBuy'] = maxTicketBuy;
    return data;
  }

  @override
  String toString() {
    return '{totalNumberOfTickets: $totalNumberOfTickets,ticketPrice: $ticketPrice, ticketType: $ticketType, ticketsSold: $ticketsSold, sale: $sale, minTicketBuy: $minTicketBuy, maxTicketBuy: $maxTicketBuy,}';
  }
}

class Sort {
  bool? sorted;
  bool? unsorted;
  bool? empty;

  Sort({this.sorted, this.unsorted, this.empty});

  Sort.fromJson(Map<String, dynamic> json) {
    sorted = json['sorted'];
    unsorted = json['unsorted'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sorted'] = sorted;
    data['unsorted'] = unsorted;
    data['empty'] = empty;
    return data;
  }
}
