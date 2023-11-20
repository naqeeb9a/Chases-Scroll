class Chronology {
  Zone? zone;

  Chronology({this.zone});

  Chronology.fromJson(Map<String, dynamic> json) {
    zone = json['zone'] != null ? Zone.fromJson(json['zone']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (zone != null) {
      data['zone'] = zone!.toJson();
    }
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

class CreatedOn {
  int? year;
  int? dayOfMonth;
  int? dayOfWeek;
  int? dayOfYear;
  int? era;
  int? centuryOfEra;
  int? yearOfEra;
  int? yearOfCentury;
  int? weekyear;
  int? monthOfYear;
  int? weekOfWeekyear;
  int? hourOfDay;
  int? minuteOfHour;
  int? secondOfMinute;
  int? millisOfSecond;
  int? millisOfDay;
  int? secondOfDay;
  int? minuteOfDay;
  Chronology? chronology;
  Zone? zone;
  int? millis;
  bool? afterNow;
  bool? beforeNow;
  bool? equalNow;

  CreatedOn(
      {this.year,
      this.dayOfMonth,
      this.dayOfWeek,
      this.dayOfYear,
      this.era,
      this.centuryOfEra,
      this.yearOfEra,
      this.yearOfCentury,
      this.weekyear,
      this.monthOfYear,
      this.weekOfWeekyear,
      this.hourOfDay,
      this.minuteOfHour,
      this.secondOfMinute,
      this.millisOfSecond,
      this.millisOfDay,
      this.secondOfDay,
      this.minuteOfDay,
      this.chronology,
      this.zone,
      this.millis,
      this.afterNow,
      this.beforeNow,
      this.equalNow});

  CreatedOn.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    dayOfMonth = json['dayOfMonth'];
    dayOfWeek = json['dayOfWeek'];
    dayOfYear = json['dayOfYear'];
    era = json['era'];
    centuryOfEra = json['centuryOfEra'];
    yearOfEra = json['yearOfEra'];
    yearOfCentury = json['yearOfCentury'];
    weekyear = json['weekyear'];
    monthOfYear = json['monthOfYear'];
    weekOfWeekyear = json['weekOfWeekyear'];
    hourOfDay = json['hourOfDay'];
    minuteOfHour = json['minuteOfHour'];
    secondOfMinute = json['secondOfMinute'];
    millisOfSecond = json['millisOfSecond'];
    millisOfDay = json['millisOfDay'];
    secondOfDay = json['secondOfDay'];
    minuteOfDay = json['minuteOfDay'];
    chronology = json['chronology'] != null
        ? Chronology.fromJson(json['chronology'])
        : null;
    zone = json['zone'] != null ? Zone.fromJson(json['zone']) : null;
    millis = json['millis'];
    afterNow = json['afterNow'];
    beforeNow = json['beforeNow'];
    equalNow = json['equalNow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['dayOfMonth'] = dayOfMonth;
    data['dayOfWeek'] = dayOfWeek;
    data['dayOfYear'] = dayOfYear;
    data['era'] = era;
    data['centuryOfEra'] = centuryOfEra;
    data['yearOfEra'] = yearOfEra;
    data['yearOfCentury'] = yearOfCentury;
    data['weekyear'] = weekyear;
    data['monthOfYear'] = monthOfYear;
    data['weekOfWeekyear'] = weekOfWeekyear;
    data['hourOfDay'] = hourOfDay;
    data['minuteOfHour'] = minuteOfHour;
    data['secondOfMinute'] = secondOfMinute;
    data['millisOfSecond'] = millisOfSecond;
    data['millisOfDay'] = millisOfDay;
    data['secondOfDay'] = secondOfDay;
    data['minuteOfDay'] = minuteOfDay;
    if (chronology != null) {
      data['chronology'] = chronology!.toJson();
    }
    if (zone != null) {
      data['zone'] = zone!.toJson();
    }
    data['millis'] = millis;
    data['afterNow'] = afterNow;
    data['beforeNow'] = beforeNow;
    data['equalNow'] = equalNow;
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

class UserModel {
  String? id;
  CreatedOn? createdOn;
  String? userId;
  String? email;
  bool? showEmail;
  String? firstName;
  bool? active;
  String? lastName;
  bool? publicProfile;
  String? username;
  String? joinStatus;
  String? dob;
  Data? data;

  UserModel(
      {this.id,
      this.createdOn,
      this.userId,
      this.email,
      this.showEmail,
      this.firstName,
      this.active,
      this.lastName,
      this.publicProfile,
      this.username,
      this.joinStatus,
      this.dob,
      this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      createdOn: json['createdOn'] != null
          ? CreatedOn.fromJson(json['createdOn'])
          : null,
      userId: json['userId'],
      email: json['email'],
      showEmail: json['showEmail'],
      firstName: json['firstName'],
      active: json['active'],
      lastName: json['lastName'],
      joinStatus: json['joinStatus'],
      publicProfile: json['publicProfile'],
      username: json['username'],
      dob: json['dob'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (createdOn != null) {
      data['createdOn'] = createdOn!.toJson();
    }
    data['userId'] = userId;
    data['email'] = email;
    data['showEmail'] = showEmail;
    data['firstName'] = firstName;
    data['active'] = active;
    data['lastName'] = lastName;
    data['publicProfile'] = publicProfile;
    data['username'] = username;
    data['dob'] = dob;
    data['joinStatus'] = joinStatus;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'UserModel(id: $id, createdOn: $createdOn, userId: $userId, email: $email, joinStatus: $joinStatus,  showEmail: $showEmail, firstName: $firstName, active: $active, lastName: $lastName, publicProfile: $publicProfile, username: $username, dob: $dob, data: $data)';
  }
}

class Zone {
  bool? fixed;
  String? id;

  Zone({this.fixed, this.id});

  Zone.fromJson(Map<String, dynamic> json) {
    fixed = json['fixed'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fixed'] = fixed;
    data['id'] = id;
    return data;
  }
}
