import 'dart:convert';
/// success : 1
/// message : ""
/// portfolio : {"user_id":"2926","first_name":"Shahista","last_name":"Shakeel Ahmed Sayed","email":"shahistasayed03@gmail.com","pan_no":"FKUPS5059C","dob":"772050600"}
/// vault : {"user_id":"164","username":"Shahista","email":"shahistasayed03@gmail.com","phone":"8286128681","image":"","country_name":"","country_id":"","state_name":"","state_id":"","city_name":"","city_id":"","dob":"772050600"}
/// profile : {"user_id":"26","username":"Shahista","email":"shahistasayed03@gmail.com","phone":"8286128681","image":"","country_name":"","country_id":"","state_name":"","state_id":"","city_name":"","city_id":"","dob":"772050600"}

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));
String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());
class LoginResponseModel {
  LoginResponseModel({
      num? success, 
      String? message, 
      Portfolio? portfolio, 
      Vault? vault, 
      Profile? profile,}){
    _success = success;
    _message = message;
    _portfolio = portfolio;
    _vault = vault;
    _profile = profile;
}

  LoginResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _portfolio = json['portfolio'] != null ? Portfolio.fromJson(json['portfolio']) : null;
    _vault = json['vault'] != null ? Vault.fromJson(json['vault']) : null;
    _profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }
  num? _success;
  String? _message;
  Portfolio? _portfolio;
  Vault? _vault;
  Profile? _profile;
LoginResponseModel copyWith({  num? success,
  String? message,
  Portfolio? portfolio,
  Vault? vault,
  Profile? profile,
}) => LoginResponseModel(  success: success ?? _success,
  message: message ?? _message,
  portfolio: portfolio ?? _portfolio,
  vault: vault ?? _vault,
  profile: profile ?? _profile,
);
  num? get success => _success;
  String? get message => _message;
  Portfolio? get portfolio => _portfolio;
  Vault? get vault => _vault;
  Profile? get profile => _profile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_portfolio != null) {
      map['portfolio'] = _portfolio?.toJson();
    }
    if (_vault != null) {
      map['vault'] = _vault?.toJson();
    }
    if (_profile != null) {
      map['profile'] = _profile?.toJson();
    }
    return map;
  }

}

/// user_id : "26"
/// username : "Shahista"
/// email : "shahistasayed03@gmail.com"
/// phone : "8286128681"
/// image : ""
/// country_name : ""
/// country_id : ""
/// state_name : ""
/// state_id : ""
/// city_name : ""
/// city_id : ""
/// dob : "772050600"

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));
String profileToJson(Profile data) => json.encode(data.toJson());
class Profile {
  Profile({
      String? userId, 
      String? username, 
      String? email, 
      String? phone, 
      String? image, 
      String? countryName, 
      String? countryId, 
      String? stateName, 
      String? stateId, 
      String? cityName, 
      String? cityId, 
      String? dob,}){
    _userId = userId;
    _username = username;
    _email = email;
    _phone = phone;
    _image = image;
    _countryName = countryName;
    _countryId = countryId;
    _stateName = stateName;
    _stateId = stateId;
    _cityName = cityName;
    _cityId = cityId;
    _dob = dob;
}

  Profile.fromJson(dynamic json) {
    _userId = json['user_id'];
    _username = json['username'];
    _email = json['email'];
    _phone = json['phone'];
    _image = json['image'];
    _countryName = json['country_name'];
    _countryId = json['country_id'];
    _stateName = json['state_name'];
    _stateId = json['state_id'];
    _cityName = json['city_name'];
    _cityId = json['city_id'];
    _dob = json['dob'];
  }
  String? _userId;
  String? _username;
  String? _email;
  String? _phone;
  String? _image;
  String? _countryName;
  String? _countryId;
  String? _stateName;
  String? _stateId;
  String? _cityName;
  String? _cityId;
  String? _dob;
Profile copyWith({  String? userId,
  String? username,
  String? email,
  String? phone,
  String? image,
  String? countryName,
  String? countryId,
  String? stateName,
  String? stateId,
  String? cityName,
  String? cityId,
  String? dob,
}) => Profile(  userId: userId ?? _userId,
  username: username ?? _username,
  email: email ?? _email,
  phone: phone ?? _phone,
  image: image ?? _image,
  countryName: countryName ?? _countryName,
  countryId: countryId ?? _countryId,
  stateName: stateName ?? _stateName,
  stateId: stateId ?? _stateId,
  cityName: cityName ?? _cityName,
  cityId: cityId ?? _cityId,
  dob: dob ?? _dob,
);
  String? get userId => _userId;
  String? get username => _username;
  String? get email => _email;
  String? get phone => _phone;
  String? get image => _image;
  String? get countryName => _countryName;
  String? get countryId => _countryId;
  String? get stateName => _stateName;
  String? get stateId => _stateId;
  String? get cityName => _cityName;
  String? get cityId => _cityId;
  String? get dob => _dob;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['username'] = _username;
    map['email'] = _email;
    map['phone'] = _phone;
    map['image'] = _image;
    map['country_name'] = _countryName;
    map['country_id'] = _countryId;
    map['state_name'] = _stateName;
    map['state_id'] = _stateId;
    map['city_name'] = _cityName;
    map['city_id'] = _cityId;
    map['dob'] = _dob;
    return map;
  }

}

/// user_id : "164"
/// username : "Shahista"
/// email : "shahistasayed03@gmail.com"
/// phone : "8286128681"
/// image : ""
/// country_name : ""
/// country_id : ""
/// state_name : ""
/// state_id : ""
/// city_name : ""
/// city_id : ""
/// dob : "772050600"

Vault vaultFromJson(String str) => Vault.fromJson(json.decode(str));
String vaultToJson(Vault data) => json.encode(data.toJson());
class Vault {
  Vault({
      String? userId, 
      String? username, 
      String? email, 
      String? phone, 
      String? image, 
      String? countryName, 
      String? countryId, 
      String? stateName, 
      String? stateId, 
      String? cityName, 
      String? cityId, 
      String? dob,}){
    _userId = userId;
    _username = username;
    _email = email;
    _phone = phone;
    _image = image;
    _countryName = countryName;
    _countryId = countryId;
    _stateName = stateName;
    _stateId = stateId;
    _cityName = cityName;
    _cityId = cityId;
    _dob = dob;
}

  Vault.fromJson(dynamic json) {
    _userId = json['user_id'];
    _username = json['username'];
    _email = json['email'];
    _phone = json['phone'];
    _image = json['image'];
    _countryName = json['country_name'];
    _countryId = json['country_id'];
    _stateName = json['state_name'];
    _stateId = json['state_id'];
    _cityName = json['city_name'];
    _cityId = json['city_id'];
    _dob = json['dob'];
  }
  String? _userId;
  String? _username;
  String? _email;
  String? _phone;
  String? _image;
  String? _countryName;
  String? _countryId;
  String? _stateName;
  String? _stateId;
  String? _cityName;
  String? _cityId;
  String? _dob;
Vault copyWith({  String? userId,
  String? username,
  String? email,
  String? phone,
  String? image,
  String? countryName,
  String? countryId,
  String? stateName,
  String? stateId,
  String? cityName,
  String? cityId,
  String? dob,
}) => Vault(  userId: userId ?? _userId,
  username: username ?? _username,
  email: email ?? _email,
  phone: phone ?? _phone,
  image: image ?? _image,
  countryName: countryName ?? _countryName,
  countryId: countryId ?? _countryId,
  stateName: stateName ?? _stateName,
  stateId: stateId ?? _stateId,
  cityName: cityName ?? _cityName,
  cityId: cityId ?? _cityId,
  dob: dob ?? _dob,
);
  String? get userId => _userId;
  String? get username => _username;
  String? get email => _email;
  String? get phone => _phone;
  String? get image => _image;
  String? get countryName => _countryName;
  String? get countryId => _countryId;
  String? get stateName => _stateName;
  String? get stateId => _stateId;
  String? get cityName => _cityName;
  String? get cityId => _cityId;
  String? get dob => _dob;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['username'] = _username;
    map['email'] = _email;
    map['phone'] = _phone;
    map['image'] = _image;
    map['country_name'] = _countryName;
    map['country_id'] = _countryId;
    map['state_name'] = _stateName;
    map['state_id'] = _stateId;
    map['city_name'] = _cityName;
    map['city_id'] = _cityId;
    map['dob'] = _dob;
    return map;
  }

}

/// user_id : "2926"
/// first_name : "Shahista"
/// last_name : "Shakeel Ahmed Sayed"
/// email : "shahistasayed03@gmail.com"
/// pan_no : "FKUPS5059C"
/// dob : "772050600"

Portfolio portfolioFromJson(String str) => Portfolio.fromJson(json.decode(str));
String portfolioToJson(Portfolio data) => json.encode(data.toJson());
class Portfolio {
  Portfolio({
      String? userId, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? panNo, 
      String? dob,}){
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _panNo = panNo;
    _dob = dob;
}

  Portfolio.fromJson(dynamic json) {
    _userId = json['user_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _panNo = json['pan_no'];
    _dob = json['dob'];
  }
  String? _userId;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _panNo;
  String? _dob;
Portfolio copyWith({  String? userId,
  String? firstName,
  String? lastName,
  String? email,
  String? panNo,
  String? dob,
}) => Portfolio(  userId: userId ?? _userId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  panNo: panNo ?? _panNo,
  dob: dob ?? _dob,
);
  String? get userId => _userId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get panNo => _panNo;
  String? get dob => _dob;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['pan_no'] = _panNo;
    map['dob'] = _dob;
    return map;
  }

}