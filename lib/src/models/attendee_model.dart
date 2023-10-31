import 'package:chases_scroll/src/models/event_model.dart';

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

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      mobilePhone: json['mobilePhone'] != null
          ? MobilePhone.fromJson(json['mobilePhone'])
          : null,
      country:
          json['country'] != null ? Country.fromJson(json['country']) : null,
      imgMain:
          json['imgMain'] != null ? Country.fromJson(json['imgMain']) : null,
      images: json['images'] != null ? Country.fromJson(json['images']) : null,
      gender: json['gender'] != null ? Country.fromJson(json['gender']) : null,
      city: json['city'] != null ? Country.fromJson(json['city']) : null,
      webAddress: json['webAddress'] != null
          ? Country.fromJson(json['webAddress'])
          : null,
      work: json['work'] != null ? Country.fromJson(json['work']) : null,
      about: json['about'] != null ? Country.fromJson(json['about']) : null,
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
    return 'Data(mobilePhone: $mobilePhone, country: $country, imgMain: $imgMain, images: $images, gender: $gender, city: $city, webAddress: $webAddress, work: $work, about: $about, state: $state, userSchool: $userSchool, maritalStatus: $maritalStatus, favorites: $favorites)';
  }
}

class EventAttendeesModel {
  String? id;
  int? createdDate;
  LastModifiedBy? lastModifiedBy;
  LastModifiedBy? createdBy;
  int? lastModifiedDate;
  bool? isDeleted;
  ContentUser? user;
  String? role;
  bool? active;
  String? rsvp;
  int? guests;

  EventAttendeesModel(
      {this.id,
      this.createdDate,
      this.lastModifiedBy,
      this.createdBy,
      this.lastModifiedDate,
      this.isDeleted,
      this.user,
      this.role,
      this.active,
      this.rsvp,
      this.guests});

  EventAttendeesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdDate = json['createdDate'];
    lastModifiedBy = json['lastModifiedBy'] != null
        ? LastModifiedBy.fromJson(json['lastModifiedBy'])
        : null;
    createdBy = json['createdBy'] != null
        ? LastModifiedBy.fromJson(json['createdBy'])
        : null;
    user = json['user'] != null ? ContentUser.fromJson(json['user']) : null;
    lastModifiedDate = json['lastModifiedDate'];
    isDeleted = json['isDeleted'];
    role = json['role'];
    active = json['active'];
    rsvp = json['rsvp'];
    guests = json['guests'];
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
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['lastModifiedDate'] = lastModifiedDate;
    data['role'] = role;
    data['active'] = active;
    data['rsvp'] = rsvp;
    data['guests'] = guests;
    return data;
  }

  @override
  String toString() {
    return 'EventAttendeesModel{id: $id, createdDate: $createdDate, lastModifiedBy: $lastModifiedBy, '
        'createdBy: $createdBy, lastModifiedDate: $lastModifiedDate, isDeleted: $isDeleted, user: $user, '
        'role: $role, active: $active, rsvp: $rsvp, guests: $guests}';
  }
}

class LastModifiedBy {
  String? userId;
  String? firstName;
  String? lastName;
  String? username;
  dynamic dob;
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

class User {
  String? userId;
  String? firstName;
  String? lastName;
  String? username;
  dynamic dob;
  bool? publicProfile;
  String? joinStatus;
  Data? data;

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.username,
    this.dob,
    this.publicProfile,
    this.joinStatus,
    this.data,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
    return 'User(userId: $userId, firstName: $firstName, lastName: $lastName, username: $username, dob: $dob, publicProfile: $publicProfile, joinStatus: $joinStatus, data: $data)';
  }
}
