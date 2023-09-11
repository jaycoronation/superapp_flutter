import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:superapp_flutter/utils/app_utils.dart';
/// notifications : [{"notification_id":"36","user_id":"164","holder_id":"97","name":"Ravi","holder_name":"","phone":"8469940500","email":"ravi@coronation.in","address":"506","holder":"A","timestamp":"1678443307"}]
/// total_count : "1"
/// success : 1
/// message : " Notifications found."

DeathNotificationResponse deathNotificationResponseFromJson(String str) => DeathNotificationResponse.fromJson(json.decode(str));
String deathNotificationResponseToJson(DeathNotificationResponse data) => json.encode(data.toJson());
class DeathNotificationResponse {
  DeathNotificationResponse({
      List<Notifications>? notifications, 
      num? success,
      String? message,}){
    _notifications = notifications;
    _success = success;
    _message = message;
}

  DeathNotificationResponse.fromJson(dynamic json) {
    if (json['notifications'] != null) {
      _notifications = [];
      json['notifications'].forEach((v) {
        _notifications?.add(Notifications.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<Notifications>? _notifications;
  num? _success;
  String? _message;
DeathNotificationResponse copyWith({  List<Notifications>? notifications,
  num? success,
  String? message,
}) => DeathNotificationResponse(  notifications: notifications ?? _notifications,
  success: success ?? _success,
  message: message ?? _message,
);
  List<Notifications>? get notifications => _notifications;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_notifications != null) {
      map['notifications'] = _notifications?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// notification_id : "36"
/// user_id : "164"
/// holder_id : "97"
/// name : "Ravi"
/// holder_name : ""
/// phone : "8469940500"
/// email : "ravi@coronation.in"
/// address : "506"
/// holder : "A"
/// timestamp : "1678443307"

Notifications notificationsFromJson(String str) => Notifications.fromJson(json.decode(str));
String notificationsToJson(Notifications data) => json.encode(data.toJson());
class Notifications {
  Notifications({
      String? notificationId, 
      String? userId, 
      String? holderId, 
      String? name, 
      String? holderName, 
      String? phone, 
      String? email, 
      String? address, 
      String? holder, 
      String? timestamp,}){
    _notificationId = notificationId;
    _userId = userId;
    _holderId = holderId;
    _name = name;
    _holderName = holderName;
    _phone = phone;
    _email = email;
    _address = address;
    _holder = holder;
    _timestamp = timestamp;
}

  Notifications.fromJson(dynamic json) {
    _notificationId = json['notification_id'];
    _userId = json['user_id'];
    _holderId = json['holder_id'];
    _name = json['name'];
    _holderName = json['holder_name'];
    _phone = json['phone'];
    _email = json['email'];
    _address = json['address'];
    _holder = json['holder'];
    _timestamp = json['timestamp'];
  }
  String? _notificationId;
  String? _userId;
  String? _holderId;
  String? _name;
  String? _holderName;
  String? _phone;
  String? _email;
  String? _address;
  String? _holder;
  String? _timestamp;
Notifications copyWith({  String? notificationId,
  String? userId,
  String? holderId,
  String? name,
  String? holderName,
  String? phone,
  String? email,
  String? address,
  String? holder,
  String? timestamp,
}) => Notifications(  notificationId: notificationId ?? _notificationId,
  userId: userId ?? _userId,
  holderId: holderId ?? _holderId,
  name: name ?? _name,
  holderName: holderName ?? _holderName,
  phone: phone ?? _phone,
  email: email ?? _email,
  address: address ?? _address,
  holder: holder ?? _holder,
  timestamp: timestamp ?? _timestamp,
);
  String? get notificationId => _notificationId;
  String? get userId => _userId;
  String? get holderId => _holderId;
  String? get name => _name;
  String? get holderName => _holderName;
  String? get phone => _phone;
  String? get email => _email;
  String? get address => _address;
  String? get holder => _holder;
  String? get timestamp => _timestamp;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  set setName(String value)
  {
    _name = value;
  }

  set setPhone(String value)
  {
    _phone = value;
  }

  set setEmail(String value)
  {
    _email = value;
  }

  set setAddress(String value)
  {
    _address = value;
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = checkValidString(_name);
    map['phone'] = checkValidString(_phone);
    map['email'] = checkValidString(_email);
    map['address'] = checkValidString(_address);
    map['holder'] = checkValidString(_holder);
    map['notification_id'] = checkValidString(_notificationId);
    return map;
  }

}