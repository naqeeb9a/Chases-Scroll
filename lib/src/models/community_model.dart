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
        content!.add(new CommContent.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    totalElements = json['totalElements'];
    last = json['last'];
    totalPages = json['totalPages'];
    size = json['size'];
    number = json['number'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    data['totalElements'] = this.totalElements;
    data['last'] = this.last;
    data['totalPages'] = this.totalPages;
    data['size'] = this.size;
    data['number'] = this.number;
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['first'] = this.first;
    data['numberOfElements'] = this.numberOfElements;
    data['empty'] = this.empty;
    return data;
  }
}

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
        data: json['data'] != null ? new Datas.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdOn'] = this.createdOn;
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    data['active'] = this.active;
    data['joinStatus'] = this.joinStatus;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
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
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['dob'] = this.dob;
    data['publicProfile'] = this.publicProfile;
    data['joinStatus'] = this.joinStatus;
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
        ? new MobilePhone.fromJson(json['mobilePhone'])
        : null;
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    imgMain =
        json['imgMain'] != null ? new Country.fromJson(json['imgMain']) : null;
    images =
        json['images'] != null ? new Country.fromJson(json['images']) : null;
    gender =
        json['gender'] != null ? new Country.fromJson(json['gender']) : null;
    city = json['city'] != null ? new Country.fromJson(json['city']) : null;
    webAddress = json['webAddress'] != null
        ? new Country.fromJson(json['webAddress'])
        : null;
    work = json['work'] != null ? new Country.fromJson(json['work']) : null;
    about = json['about'] != null ? new Country.fromJson(json['about']) : null;
    state = json['state'] != null ? new Country.fromJson(json['state']) : null;
    userSchool = json['userSchool'] != null
        ? new Country.fromJson(json['userSchool'])
        : null;
    maritalStatus = json['maritalStatus'] != null
        ? new Country.fromJson(json['maritalStatus'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mobilePhone != null) {
      data['mobilePhone'] = this.mobilePhone!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.imgMain != null) {
      data['imgMain'] = this.imgMain!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    if (this.gender != null) {
      data['gender'] = this.gender!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.webAddress != null) {
      data['webAddress'] = this.webAddress!.toJson();
    }
    if (this.work != null) {
      data['work'] = this.work!.toJson();
    }
    if (this.about != null) {
      data['about'] = this.about!.toJson();
    }
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    if (this.userSchool != null) {
      data['userSchool'] = this.userSchool!.toJson();
    }
    if (this.maritalStatus != null) {
      data['maritalStatus'] = this.maritalStatus!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectPublic'] = this.objectPublic;
    data['value'] = this.value;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectPublic'] = this.objectPublic;
    data['value'] = this.value;
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
  List<String>? picUrls;
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
      this.picUrls,
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
        picUrls: json['picUrls'].cast<String>(),
        imgSrc: json['imgSrc'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['contactNumber'] = this.contactNumber;
    data['email'] = this.email;
    data['name'] = this.name;
    data['password'] = this.password;
    data['join_setting'] = this.joinSetting;
    data['isPublic'] = this.isPublic;
    data['memberCount'] = this.memberCount;
    data['picUrls'] = this.picUrls;
    data['imgSrc'] = this.imgSrc;
    data['description'] = this.description;
    return data;
  }

  @override
  String toString() {
    return '{address: $address, contactNumber: $contactNumber, email: $email, name: $name, password: $password, joinSetting: $joinSetting, isPublic: $isPublic, memberCount: $memberCount, picUrls: $picUrls, imgSrc: $imgSrc, description: $description}';
  }
}

// class Favorites {
//   String? typeID;
//   String? type;

//   Favorites({this.typeID, this.type});

//   Favorites.fromJson(Map<String, dynamic> json) {
//     typeID = json['typeID'];
//     type = json['type'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['typeID'] = this.typeID;
//     data['type'] = this.type;
//     return data;
//   }
// }

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
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    offset = json['offset'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['offset'] = this.offset;
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    data['paged'] = this.paged;
    data['unpaged'] = this.unpaged;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sorted'] = this.sorted;
    data['unsorted'] = this.unsorted;
    data['empty'] = this.empty;
    return data;
  }
}
