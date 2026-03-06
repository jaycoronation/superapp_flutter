import 'dart:convert';
/// profile : {"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Conservative","time_horizon":"","amount_invested":"","is_active":"1","timestamp":""}
/// success : 1
/// message : ""

UserProfileResponseModel userProfileResponseModelFromJson(String str) => UserProfileResponseModel.fromJson(json.decode(str));
String userProfileResponseModelToJson(UserProfileResponseModel data) => json.encode(data.toJson());
class UserProfileResponseModel {
  UserProfileResponseModel({
      Profile? profile, 
      num? success, 
      String? message,}){
    _profile = profile;
    _success = success;
    _message = message;
}

  UserProfileResponseModel.fromJson(dynamic json) {
    _profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    _success = json['success'];
    _message = json['message'];
  }
  Profile? _profile;
  num? _success;
  String? _message;
UserProfileResponseModel copyWith({  Profile? profile,
  num? success,
  String? message,
}) => UserProfileResponseModel(  profile: profile ?? _profile,
  success: success ?? _success,
  message: message ?? _message,
);
  Profile? get profile => _profile;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_profile != null) {
      map['profile'] = _profile?.toJson();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// user_id : "1218"
/// first_name : "MUKESH JINDAL"
/// last_name : ""
/// email : "jindalmukesh@gmail.com"
/// mobile : ""
/// dob : ""
/// age : ""
/// retirement_age : ""
/// life_expectancy : ""
/// tax_slab : ""
/// risk_profile : "Conservative"
/// time_horizon : ""
/// amount_invested : ""
/// is_active : "1"
/// timestamp : ""

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));
String profileToJson(Profile data) => json.encode(data.toJson());
class Profile {
  Profile({
      String? userId, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? mobile, 
      String? dob, 
      String? age, 
      String? retirementAge, 
      String? lifeExpectancy, 
      String? taxSlab, 
      String? riskProfile, 
      String? timeHorizon, 
      String? amountInvested, 
      String? isActive, 
      String? timestamp,}){
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _mobile = mobile;
    _dob = dob;
    _age = age;
    _retirementAge = retirementAge;
    _lifeExpectancy = lifeExpectancy;
    _taxSlab = taxSlab;
    _riskProfile = riskProfile;
    _timeHorizon = timeHorizon;
    _amountInvested = amountInvested;
    _isActive = isActive;
    _timestamp = timestamp;
}

  Profile.fromJson(dynamic json) {
    _userId = json['user_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _dob = json['dob'];
    _age = json['age'];
    _retirementAge = json['retirement_age'];
    _lifeExpectancy = json['life_expectancy'];
    _taxSlab = json['tax_slab'];
    _riskProfile = json['risk_profile'];
    _timeHorizon = json['time_horizon'];
    _amountInvested = json['amount_invested'];
    _isActive = json['is_active'];
    _timestamp = json['timestamp'];
  }
  String? _userId;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _mobile;
  String? _dob;
  String? _age;
  String? _retirementAge;
  String? _lifeExpectancy;
  String? _taxSlab;
  String? _riskProfile;
  String? _timeHorizon;
  String? _amountInvested;
  String? _isActive;
  String? _timestamp;
Profile copyWith({  String? userId,
  String? firstName,
  String? lastName,
  String? email,
  String? mobile,
  String? dob,
  String? age,
  String? retirementAge,
  String? lifeExpectancy,
  String? taxSlab,
  String? riskProfile,
  String? timeHorizon,
  String? amountInvested,
  String? isActive,
  String? timestamp,
}) => Profile(  userId: userId ?? _userId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  dob: dob ?? _dob,
  age: age ?? _age,
  retirementAge: retirementAge ?? _retirementAge,
  lifeExpectancy: lifeExpectancy ?? _lifeExpectancy,
  taxSlab: taxSlab ?? _taxSlab,
  riskProfile: riskProfile ?? _riskProfile,
  timeHorizon: timeHorizon ?? _timeHorizon,
  amountInvested: amountInvested ?? _amountInvested,
  isActive: isActive ?? _isActive,
  timestamp: timestamp ?? _timestamp,
);
  String? get userId => _userId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get dob => _dob;
  String? get age => _age;
  String? get retirementAge => _retirementAge;
  String? get lifeExpectancy => _lifeExpectancy;
  String? get taxSlab => _taxSlab;
  String? get riskProfile => _riskProfile;
  String? get timeHorizon => _timeHorizon;
  String? get amountInvested => _amountInvested;
  String? get isActive => _isActive;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['dob'] = _dob;
    map['age'] = _age;
    map['retirement_age'] = _retirementAge;
    map['life_expectancy'] = _lifeExpectancy;
    map['tax_slab'] = _taxSlab;
    map['risk_profile'] = _riskProfile;
    map['time_horizon'] = _timeHorizon;
    map['amount_invested'] = _amountInvested;
    map['is_active'] = _isActive;
    map['timestamp'] = _timestamp;
    return map;
  }

}