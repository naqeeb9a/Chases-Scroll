class BlockedModel {
  String? id;
  int? createdDate;
  int? lastModifiedDate;
  String? blockType;
  String? typeID;
  BlockObject? blockObject;

  BlockedModel(
      {this.id,
      this.createdDate,
      this.lastModifiedDate,
      this.blockType,
      this.typeID,
      this.blockObject});

  factory BlockedModel.fromJson(Map<String, dynamic> json) {
    return BlockedModel(
      id: json['id'],
      createdDate: json['createdDate'],
      lastModifiedDate: json['lastModifiedDate'],
      blockType: json['blockType'],
      typeID: json['typeID'],
      blockObject: json['blockObject'] != null
          ? BlockObject.fromJson(json['blockObject'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdDate'] = createdDate;
    data['lastModifiedDate'] = lastModifiedDate;
    data['blockType'] = blockType;
    data['typeID'] = typeID;
    if (blockObject != null) {
      data['blockObject'] = blockObject!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'BlockedModel{id: $id, createdDate: $createdDate, lastModifiedDate: $lastModifiedDate, blockType: $blockType, typeID: $typeID, blockObject: $blockObject}';
  }
}

class BlockObject {
  String? userId;
  String? firstName;
  String? lastName;
  String? showEmail;
  String? username;
  String? email;
  bool? active;
  String? dob;
  bool? publicProfile;
  String? joinStatus;
  Data? data;

  BlockObject(
      {this.userId,
      this.firstName,
      this.lastName,
      this.showEmail,
      this.username,
      this.email,
      this.active,
      this.dob,
      this.publicProfile,
      this.joinStatus,
      this.data});

  factory BlockObject.fromJson(Map<String, dynamic> json) {
    return BlockObject(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      showEmail: json['showEmail'],
      username: json['username'],
      email: json['email'],
      active: json['active'],
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
    data['showEmail'] = showEmail;
    data['username'] = username;
    data['email'] = email;
    data['active'] = active;
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
    return 'BlockObject{userId: $userId, firstName: $firstName, lastName: $lastName, showEmail: $showEmail, username: $username, email: $email, active: $active, dob: $dob, publicProfile: $publicProfile, joinStatus: $joinStatus, data: $data}';
  }
}

class Data {
  MobilePhone? mobilePhone;
  MobilePhone? country;
  MobilePhone? imgMain;
  MobilePhone? gender;
  MobilePhone? city;
  MobilePhone? webAddress;
  MobilePhone? work;
  MobilePhone? about;

  Data(
      {this.mobilePhone,
      this.country,
      this.imgMain,
      this.gender,
      this.city,
      this.webAddress,
      this.work,
      this.about});

  Data.fromJson(Map<String, dynamic> json) {
    mobilePhone = json['mobilePhone'] != null
        ? MobilePhone.fromJson(json['mobilePhone'])
        : null;
    country =
        json['country'] != null ? MobilePhone.fromJson(json['country']) : null;
    imgMain =
        json['imgMain'] != null ? MobilePhone.fromJson(json['imgMain']) : null;
    gender =
        json['gender'] != null ? MobilePhone.fromJson(json['gender']) : null;
    city = json['city'] != null ? MobilePhone.fromJson(json['city']) : null;
    webAddress = json['webAddress'] != null
        ? MobilePhone.fromJson(json['webAddress'])
        : null;
    work = json['work'] != null ? MobilePhone.fromJson(json['work']) : null;
    about = json['about'] != null ? MobilePhone.fromJson(json['about']) : null;
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
