class LoginModel {
  String? accessToken;
  String? tokenType;
  String? refreshToken;
  int? expiresIn;
  String? scope;
  String? firstName;
  String? lastName;
  String? userId;
  String? userName;
  int? createdAt;
  String? jti;

  LoginModel(
      {this.accessToken,
      this.tokenType,
      this.refreshToken,
      this.expiresIn,
      this.scope,
      this.firstName,
      this.lastName,
      this.userId,
      this.userName,
      this.createdAt,
      this.jti});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    refreshToken = json['refresh_token'];
    expiresIn = json['expires_in'];
    scope = json['scope'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userId = json['user_id'];
    userName = json['user_name'];
    createdAt = json['created_at'];
    jti = json['jti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['refresh_token'] = refreshToken;
    data['expires_in'] = expiresIn;
    data['scope'] = scope;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['created_at'] = createdAt;
    data['jti'] = jti;
    return data;
  }
}
