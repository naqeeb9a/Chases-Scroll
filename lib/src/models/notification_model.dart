class Content {
  String? id;
  int? createdDate;
  LastModifiedBy? lastModifiedBy;
  LastModifiedBy? createdBy;
  int? lastModifiedDate;
  bool? isDeleted;
  String? title;
  String? message;
  LastModifiedBy? receiverID;
  String? typeID;
  String? type;
  String? status;

  Content(
      {this.id,
      this.createdDate,
      this.lastModifiedBy,
      this.createdBy,
      this.lastModifiedDate,
      this.isDeleted,
      this.title,
      this.message,
      this.receiverID,
      this.typeID,
      this.type,
      this.status});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['createdDate'];
    lastModifiedBy = json['lastModifiedBy'] != null
        ? LastModifiedBy.fromJson(json['lastModifiedBy'])
        : null;
    createdBy = json['createdBy'] != null
        ? LastModifiedBy.fromJson(json['createdBy'])
        : null;
    lastModifiedDate = json['lastModifiedDate'];
    isDeleted = json['isDeleted'];
    title = json['title'];
    message = json['message'];
    receiverID = json['receiverID'] != null
        ? LastModifiedBy.fromJson(json['receiverID'])
        : null;
    typeID = json['typeID'];
    type = json['type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdDate'] = createdDate;
    if (lastModifiedBy != null) {
      data['lastModifiedBy'] = lastModifiedBy!.toJson();
    }
    if (createdBy != null) {
      data['createdBy'] = createdBy!.toJson();
    }
    data['lastModifiedDate'] = lastModifiedDate;
    data['isDeleted'] = isDeleted;
    data['title'] = title;
    data['message'] = message;
    if (receiverID != null) {
      data['receiverID'] = receiverID!.toJson();
    }
    data['typeID'] = typeID;
    data['type'] = type;
    data['status'] = status;
    return data;
  }
}

class Country {
  bool? objectPublic;
  dynamic value;

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
  Country? imgMain;
  Country? images;
  Country? gender;
  Country? city;
  Country? webAddress;
  Country? work;
  Country? about;
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

  Data.fromJson(Map<String, dynamic> json) {
    mobilePhone = json['mobilePhone'] != null
        ? MobilePhone.fromJson(json['mobilePhone'])
        : null;
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    imgMain =
        json['imgMain'] != null ? Country.fromJson(json['imgMain']) : null;
    images = json['images'] != null ? Country.fromJson(json['images']) : null;
    gender = json['gender'] != null ? Country.fromJson(json['gender']) : null;
    city = json['city'] != null ? Country.fromJson(json['city']) : null;
    webAddress = json['webAddress'] != null
        ? Country.fromJson(json['webAddress'])
        : null;
    work = json['work'] != null ? Country.fromJson(json['work']) : null;
    about = json['about'] != null ? Country.fromJson(json['about']) : null;
    state = json['state'] != null ? Country.fromJson(json['state']) : null;
    userSchool = json['userSchool'] != null
        ? Country.fromJson(json['userSchool'])
        : null;
    maritalStatus = json['maritalStatus'] != null
        ? Country.fromJson(json['maritalStatus'])
        : null;
    favorites =
        json['favorites'] != null ? Country.fromJson(json['favorites']) : null;
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

  LastModifiedBy.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    dob = json['dob'];
    publicProfile = json['publicProfile'];
    joinStatus = json['joinStatus'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class NotificationModel {
  List<Content>? content;
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

  NotificationModel(
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

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(Content.fromJson(v));
      });
    }
    pageable =
        json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null;
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    last = json['last'];
    size = json['size'];
    number = json['number'];
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
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
