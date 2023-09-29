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

class CommentModel {
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

  CommentModel(
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

  CommentModel.fromJson(Map<String, dynamic> json) {
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

class Content {
  String? id;
  Time? time;
  String? postID;
  String? comment;
  User? user;
  int? likeCount;
  dynamic data;
  String? likeStatus;
  SubComments? subComments;
  int? timeInMilliseconds;

  Content(
      {this.id,
      this.time,
      this.postID,
      this.comment,
      this.user,
      this.likeCount,
      this.data,
      this.likeStatus,
      this.subComments,
      this.timeInMilliseconds});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'] != null ? Time.fromJson(json['time']) : null;
    postID = json['postID'];
    comment = json['comment'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    likeCount = json['likeCount'];
    data = json['data'];
    likeStatus = json['likeStatus'];
    subComments = json['subComments'] != null
        ? SubComments.fromJson(json['subComments'])
        : null;
    timeInMilliseconds = json['timeInMilliseconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (time != null) {
      data['time'] = time!.toJson();
    }
    data['postID'] = postID;
    data['comment'] = comment;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['likeCount'] = likeCount;
    data['data'] = this.data;
    data['likeStatus'] = likeStatus;
    if (subComments != null) {
      data['subComments'] = subComments!.toJson();
    }
    data['timeInMilliseconds'] = timeInMilliseconds;
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

class SubComments {
  List<dynamic>? content;
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

  SubComments(
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

  SubComments.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Null>[];
      json['content'].forEach((v) {
        content!.add(v);
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

class Time {
  int? year;
  int? dayOfMonth;
  int? dayOfWeek;
  int? dayOfYear;
  int? era;
  int? millisOfDay;
  int? secondOfDay;
  int? minuteOfDay;
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
  Chronology? chronology;
  Zone? zone;
  int? millis;
  bool? afterNow;
  bool? beforeNow;
  bool? equalNow;

  Time(
      {this.year,
      this.dayOfMonth,
      this.dayOfWeek,
      this.dayOfYear,
      this.era,
      this.millisOfDay,
      this.secondOfDay,
      this.minuteOfDay,
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
      this.chronology,
      this.zone,
      this.millis,
      this.afterNow,
      this.beforeNow,
      this.equalNow});

  Time.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    dayOfMonth = json['dayOfMonth'];
    dayOfWeek = json['dayOfWeek'];
    dayOfYear = json['dayOfYear'];
    era = json['era'];
    millisOfDay = json['millisOfDay'];
    secondOfDay = json['secondOfDay'];
    minuteOfDay = json['minuteOfDay'];
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
    data['millisOfDay'] = millisOfDay;
    data['secondOfDay'] = secondOfDay;
    data['minuteOfDay'] = minuteOfDay;
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

class User {
  String? userId;
  String? firstName;
  String? lastName;
  String? username;
  String? dob;
  bool? publicProfile;
  String? joinStatus;
  Data? data;

  User(
      {this.userId,
      this.firstName,
      this.lastName,
      this.username,
      this.dob,
      this.publicProfile,
      this.joinStatus,
      this.data});

  User.fromJson(Map<String, dynamic> json) {
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
