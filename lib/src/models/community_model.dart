class CommContent {
  String? id;
  int? createdOn;
  Creator? creator;
  bool? active;
  String? joinStatus;
  Datas? data;

  CommContent(
      {this.id,
      this.createdOn,
      this.creator,
      this.active,
      this.joinStatus,
      this.data});

  // CommContent.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   createdOn = json['createdOn'];
  //   creator =
  //       json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
  //   active = json['active'];
  //   joinStatus = json['joinStatus'];
  //   data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  // }

  factory CommContent.fromJson(Map<String, dynamic> json) => CommContent(
        id: json["id"] ?? "",
        createdOn: json['createdOn'] ?? 0,
        active: json['active'] ?? false,
        creator:
            json['creator'] != null ? Creator.fromJson(json['creator']) : null,
        joinStatus: json['joinStatus'] ?? "",
        data: json['data'] != null ? Datas.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdOn'] = createdOn;
    if (creator != null) {
      data['creator'] = creator!.toJson();
    }
    data['active'] = active;
    data['joinStatus'] = joinStatus;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CommunityModel {
  List<CommContent>? content;
  Pageable? pageable;
  int? totalElements;
  bool? last;
  int? totalPages;
  int? size;
  int? number;
  Sort? sort;
  bool? first;
  int? numberOfElements;
  bool? empty;

  CommunityModel(
      {this.content,
      this.pageable,
      this.totalElements,
      this.last,
      this.totalPages,
      this.size,
      this.number,
      this.sort,
      this.first,
      this.numberOfElements,
      this.empty});

  CommunityModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <CommContent>[];
      json['content'].forEach((v) {
        content!.add(CommContent.fromJson(v));
      });
    }
    pageable =
        json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null;
    totalElements = json['totalElements'];
    last = json['last'];
    totalPages = json['totalPages'];
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
    data['totalElements'] = totalElements;
    data['last'] = last;
    data['totalPages'] = totalPages;
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

class Creator {
  String? userId;
  String? firstName;
  String? lastName;
  String? username;
  String? dob;
  bool? publicProfile;
  String? joinStatus;
  Data? data;

  Creator(
      {this.userId,
      this.firstName,
      this.lastName,
      this.username,
      this.dob,
      this.publicProfile,
      this.joinStatus,
      this.data});

  Creator.fromJson(Map<String, dynamic> json) {
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

  Data({
    this.mobilePhone,
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
  });

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

    return data;
  }
}

class Datas {
  String? address;
  String? contactNumber;
  String? email;
  String? name;
  String? password;
  String? joinSetting;
  bool? isPublic;
  int? memberCount;
  String? imgSrc;
  String? description;

  Datas(
      {this.address,
      this.contactNumber,
      this.email,
      this.name,
      this.password,
      this.joinSetting,
      this.isPublic,
      this.memberCount,
      this.imgSrc,
      this.description});

  factory Datas.fromJson(Map<String, dynamic> json) => Datas(
        address: json['address'] ?? "",
        contactNumber: json['contactNumber'],
        email: json['email'],
        name: json['name'],
        password: json['password'],
        joinSetting: json['join_setting'],
        isPublic: json['isPublic'],
        memberCount: json['memberCount'],
        imgSrc: json['imgSrc'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['contactNumber'] = contactNumber;
    data['email'] = email;
    data['name'] = name;
    data['password'] = password;
    data['join_setting'] = joinSetting;
    data['isPublic'] = isPublic;
    data['memberCount'] = memberCount;
    data['imgSrc'] = imgSrc;
    data['description'] = description;
    return data;
  }

  @override
  String toString() {
    return '{address: $address, contactNumber: $contactNumber, email: $email, name: $name, password: $password, joinSetting: $joinSetting, isPublic: $isPublic, memberCount: $memberCount, imgSrc: $imgSrc, description: $description}';
  }
}

class EventCommunityFunnel {
  String? commName;
  String? commDesc;
  String? commImage;
  String? id;

  EventCommunityFunnel({
    this.commName,
    this.commDesc,
    this.commImage,
    this.id,
  });

  factory EventCommunityFunnel.fromJson(Map<String, dynamic> json) {
    return EventCommunityFunnel(
      commName: json['commName'],
      commDesc: json['commDesc'],
      commImage: json['commImage'],
      id: json['id'],
    );
  }

  EventCommunityFunnel copyWith({
    String? commName,
    String? commDesc,
    String? commImage,
    String? id,
  }) {
    return EventCommunityFunnel(
      commName: commName,
      commDesc: commDesc,
      commImage: commImage,
      id: id,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commName'] = commName;
    data['commDesc'] = commDesc;
    data['commImage'] = commImage;
    data['id'] = id;
    return data;
  }

  @override
  String toString() {
    return 'EventCommunityFunnel{'
        'id: $id, '
        'commName: $commName, '
        'commDesc: $commDesc, '
        'commImage: $commImage}';
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
  bool? paged;
  bool? unpaged;

  Pageable(
      {this.sort,
      this.offset,
      this.pageNumber,
      this.pageSize,
      this.paged,
      this.unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    offset = json['offset'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['offset'] = offset;
    data['pageNumber'] = pageNumber;
    data['pageSize'] = pageSize;
    data['paged'] = paged;
    data['unpaged'] = unpaged;
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
