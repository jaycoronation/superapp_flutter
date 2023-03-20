import 'dart:convert';
/// holders : [{"holder_id":"97","user_id":"164","name":"","phone":"","email":"","address":"","holder":"A","timestamp":"1667190183"}]
/// total_count : "1"
/// success : 1
/// message : " Holders found."

AccountHolderListResponse accountHolderListResponseFromJson(String str) => AccountHolderListResponse.fromJson(json.decode(str));
String accountHolderListResponseToJson(AccountHolderListResponse data) => json.encode(data.toJson());
class AccountHolderListResponse {
  AccountHolderListResponse({
      List<Holders>? holders, 
      num? success,
      String? message,}){
    _holders = holders;
    _success = success;
    _message = message;
}

  AccountHolderListResponse.fromJson(dynamic json) {
    if (json['holders'] != null) {
      _holders = [];
      json['holders'].forEach((v) {
        _holders?.add(Holders.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<Holders>? _holders;
  num? _success;
  String? _message;
AccountHolderListResponse copyWith({  List<Holders>? holders,
  num? success,
  String? message,
}) => AccountHolderListResponse(  holders: holders ?? _holders,
  success: success ?? _success,
  message: message ?? _message,
);
  List<Holders>? get holders => _holders;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_holders != null) {
      map['holders'] = _holders?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// holder_id : "97"
/// user_id : "164"
/// name : ""
/// phone : ""
/// email : ""
/// address : ""
/// holder : "A"
/// timestamp : "1667190183"

Holders holdersFromJson(String str) => Holders.fromJson(json.decode(str));
String holdersToJson(Holders data) => json.encode(data.toJson());
class Holders {
  Holders({
      String? holderId, 
      String? userId, 
      String? name, 
      String? phone, 
      String? email, 
      String? address, 
      String? holder, 
      String? timestamp,}){
    _holderId = holderId;
    _userId = userId;
    _name = name;
    _phone = phone;
    _email = email;
    _address = address;
    _holder = holder;
    _timestamp = timestamp;
}

  Holders.fromJson(dynamic json) {
    _holderId = json['holder_id'];
    _userId = json['user_id'];
    _name = json['name'];
    _phone = json['phone'];
    _email = json['email'];
    _address = json['address'];
    _holder = json['holder'];
    _timestamp = json['timestamp'];
  }
  String? _holderId;
  String? _userId;
  String? _name;
  String? _phone;
  String? _email;
  String? _address;
  String? _holder;
  String? _timestamp;
Holders copyWith({  String? holderId,
  String? userId,
  String? name,
  String? phone,
  String? email,
  String? address,
  String? holder,
  String? timestamp,
}) => Holders(  holderId: holderId ?? _holderId,
  userId: userId ?? _userId,
  name: name ?? _name,
  phone: phone ?? _phone,
  email: email ?? _email,
  address: address ?? _address,
  holder: holder ?? _holder,
  timestamp: timestamp ?? _timestamp,
);
  String? get holderId => _holderId;
  String? get userId => _userId;
  String? get name => _name;
  String? get phone => _phone;
  String? get email => _email;
  String? get address => _address;
  String? get holder => _holder;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['holder_id'] = _holderId;
    map['user_id'] = _userId;
    map['name'] = _name;
    map['phone'] = _phone;
    map['email'] = _email;
    map['address'] = _address;
    map['holder'] = _holder;
    map['timestamp'] = _timestamp;
    return map;
  }

}