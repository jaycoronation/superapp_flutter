import 'dart:convert';
/// business : {"businesses_id":"19","user_id":"164","own_or_jointly_business":"Yes","document_stating_your_wishes":"Yes","document_instructions":"test 2","timestamp":"1678878235","businesses_details":[{"business_detail_id":"68","user_id":"164","holder_id":"97","holder_name":"","name":"Ravi","area_of_business":"Prahaladnagar","type_of_organization":"it","holder":"A","timestamp":"1678878235"}]}
/// message : ""
/// success : 1

BusinessDataResponse businessDataResponseFromJson(String str) => BusinessDataResponse.fromJson(json.decode(str));
String businessDataResponseToJson(BusinessDataResponse data) => json.encode(data.toJson());
class BusinessDataResponse {
  BusinessDataResponse({
      Business? business, 
      String? message, 
      num? success,}){
    _business = business;
    _message = message;
    _success = success;
}

  BusinessDataResponse.fromJson(dynamic json) {
    _business = json['business'] != null ? Business.fromJson(json['business']) : null;
    _message = json['message'];
    _success = json['success'];
  }
  Business? _business;
  String? _message;
  num? _success;
BusinessDataResponse copyWith({  Business? business,
  String? message,
  num? success,
}) => BusinessDataResponse(  business: business ?? _business,
  message: message ?? _message,
  success: success ?? _success,
);
  Business? get business => _business;
  String? get message => _message;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_business != null) {
      map['business'] = _business?.toJson();
    }
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// businesses_id : "19"
/// user_id : "164"
/// own_or_jointly_business : "Yes"
/// document_stating_your_wishes : "Yes"
/// document_instructions : "test 2"
/// timestamp : "1678878235"
/// businesses_details : [{"business_detail_id":"68","user_id":"164","holder_id":"97","holder_name":"","name":"Ravi","area_of_business":"Prahaladnagar","type_of_organization":"it","holder":"A","timestamp":"1678878235"}]

Business businessFromJson(String str) => Business.fromJson(json.decode(str));
String businessToJson(Business data) => json.encode(data.toJson());
class Business {
  Business({
      String? businessesId, 
      String? userId, 
      String? ownOrJointlyBusiness, 
      String? documentStatingYourWishes, 
      String? documentInstructions, 
      String? timestamp, 
      List<BusinessesDetails>? businessesDetails,}){
    _businessesId = businessesId;
    _userId = userId;
    _ownOrJointlyBusiness = ownOrJointlyBusiness;
    _documentStatingYourWishes = documentStatingYourWishes;
    _documentInstructions = documentInstructions;
    _timestamp = timestamp;
    _businessesDetails = businessesDetails;
}

  Business.fromJson(dynamic json) {
    _businessesId = json['businesses_id'];
    _userId = json['user_id'];
    _ownOrJointlyBusiness = json['own_or_jointly_business'];
    _documentStatingYourWishes = json['document_stating_your_wishes'];
    _documentInstructions = json['document_instructions'];
    _timestamp = json['timestamp'];
    if (json['businesses_details'] != null) {
      _businessesDetails = [];
      json['businesses_details'].forEach((v) {
        _businessesDetails?.add(BusinessesDetails.fromJson(v));
      });
    }
  }
  String? _businessesId;
  String? _userId;
  String? _ownOrJointlyBusiness;
  String? _documentStatingYourWishes;
  String? _documentInstructions;
  String? _timestamp;
  List<BusinessesDetails>? _businessesDetails;
Business copyWith({  String? businessesId,
  String? userId,
  String? ownOrJointlyBusiness,
  String? documentStatingYourWishes,
  String? documentInstructions,
  String? timestamp,
  List<BusinessesDetails>? businessesDetails,
}) => Business(  businessesId: businessesId ?? _businessesId,
  userId: userId ?? _userId,
  ownOrJointlyBusiness: ownOrJointlyBusiness ?? _ownOrJointlyBusiness,
  documentStatingYourWishes: documentStatingYourWishes ?? _documentStatingYourWishes,
  documentInstructions: documentInstructions ?? _documentInstructions,
  timestamp: timestamp ?? _timestamp,
  businessesDetails: businessesDetails ?? _businessesDetails,
);
  String? get businessesId => _businessesId;
  String? get userId => _userId;
  String? get ownOrJointlyBusiness => _ownOrJointlyBusiness;
  String? get documentStatingYourWishes => _documentStatingYourWishes;
  String? get documentInstructions => _documentInstructions;
  String? get timestamp => _timestamp;
  List<BusinessesDetails>? get businessesDetails => _businessesDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['businesses_id'] = _businessesId;
    map['user_id'] = _userId;
    map['own_or_jointly_business'] = _ownOrJointlyBusiness;
    map['document_stating_your_wishes'] = _documentStatingYourWishes;
    map['document_instructions'] = _documentInstructions;
    map['timestamp'] = _timestamp;
    if (_businessesDetails != null) {
      map['businesses_details'] = _businessesDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// business_detail_id : "68"
/// user_id : "164"
/// holder_id : "97"
/// holder_name : ""
/// name : "Ravi"
/// area_of_business : "Prahaladnagar"
/// type_of_organization : "it"
/// holder : "A"
/// timestamp : "1678878235"

BusinessesDetails businessesDetailsFromJson(String str) => BusinessesDetails.fromJson(json.decode(str));
String businessesDetailsToJson(BusinessesDetails data) => json.encode(data.toJson());
class BusinessesDetails {
  BusinessesDetails({
      String? businessDetailId, 
      String? userId, 
      String? holderId, 
      String? holderName, 
      String? name, 
      String? areaOfBusiness, 
      String? typeOfOrganization, 
      String? holder, 
      String? timestamp,}){
    _businessDetailId = businessDetailId;
    _userId = userId;
    _holderId = holderId;
    _holderName = holderName;
    _name = name;
    _areaOfBusiness = areaOfBusiness;
    _typeOfOrganization = typeOfOrganization;
    _holder = holder;
    _timestamp = timestamp;
}

  BusinessesDetails.fromJson(dynamic json) {
    _businessDetailId = json['business_detail_id'];
    _userId = json['user_id'];
    _holderId = json['holder_id'];
    _holderName = json['holder_name'];
    _name = json['name'];
    _areaOfBusiness = json['area_of_business'];
    _typeOfOrganization = json['type_of_organization'];
    _holder = json['holder'];
    _timestamp = json['timestamp'];
  }
  String? _businessDetailId;
  String? _userId;
  String? _holderId;
  String? _holderName;
  String? _name;
  String? _areaOfBusiness;
  String? _typeOfOrganization;
  String? _holder;
  String? _timestamp;
BusinessesDetails copyWith({  String? businessDetailId,
  String? userId,
  String? holderId,
  String? holderName,
  String? name,
  String? areaOfBusiness,
  String? typeOfOrganization,
  String? holder,
  String? timestamp,
}) => BusinessesDetails(  businessDetailId: businessDetailId ?? _businessDetailId,
  userId: userId ?? _userId,
  holderId: holderId ?? _holderId,
  holderName: holderName ?? _holderName,
  name: name ?? _name,
  areaOfBusiness: areaOfBusiness ?? _areaOfBusiness,
  typeOfOrganization: typeOfOrganization ?? _typeOfOrganization,
  holder: holder ?? _holder,
  timestamp: timestamp ?? _timestamp,
);
  String? get businessDetailId => _businessDetailId;
  String? get userId => _userId;
  String? get holderId => _holderId;
  String? get holderName => _holderName;
  String? get name => _name;
  String? get areaOfBusiness => _areaOfBusiness;
  String? get typeOfOrganization => _typeOfOrganization;
  String? get holder => _holder;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['business_detail_id'] = _businessDetailId;
    map['user_id'] = _userId;
    map['holder_id'] = _holderId;
    map['holder_name'] = _holderName;
    map['name'] = _name;
    map['area_of_business'] = _areaOfBusiness;
    map['type_of_organization'] = _typeOfOrganization;
    map['holder'] = _holder;
    map['timestamp'] = _timestamp;
    return map;
  }

}