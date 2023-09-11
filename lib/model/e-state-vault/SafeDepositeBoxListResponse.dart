import 'package:flutter/cupertino.dart';
import 'package:superapp_flutter/utils/app_utils.dart';

/// safe_deposit_boxes : [{"safe_deposit_box_id":"13","user_id":"164","holder_id":"97","box_number":"1234","person_authorized_to_sign":"Ravi","person_with_keys":"Raj","general_inventory":"Test notess","holder":"A","holder_name":"","location":"At Home","timestamp":"1678779411"}]
/// success : 1
/// message : "safe deposit box(es) found."

class SafeDepositeBoxListResponse {
  SafeDepositeBoxListResponse({
      List<SafeDepositBoxes>? safeDepositBoxes, 
      num? success, 
      String? message,}){
    _safeDepositBoxes = safeDepositBoxes;
    _success = success;
    _message = message;
}

  SafeDepositeBoxListResponse.fromJson(dynamic json) {
    if (json['safe_deposit_boxes'] != null) {
      _safeDepositBoxes = [];
      json['safe_deposit_boxes'].forEach((v) {
        _safeDepositBoxes?.add(SafeDepositBoxes.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<SafeDepositBoxes>? _safeDepositBoxes;
  num? _success;
  String? _message;
SafeDepositeBoxListResponse copyWith({  List<SafeDepositBoxes>? safeDepositBoxes,
  num? success,
  String? message,
}) => SafeDepositeBoxListResponse(  safeDepositBoxes: safeDepositBoxes ?? _safeDepositBoxes,
  success: success ?? _success,
  message: message ?? _message,
);
  List<SafeDepositBoxes>? get safeDepositBoxes => _safeDepositBoxes;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_safeDepositBoxes != null) {
      map['safe_deposit_boxes'] = _safeDepositBoxes?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// safe_deposit_box_id : "13"
/// user_id : "164"
/// holder_id : "97"
/// box_number : "1234"
/// person_authorized_to_sign : "Ravi"
/// person_with_keys : "Raj"
/// general_inventory : "Test notess"
/// holder : "A"
/// holder_name : ""
/// location : "At Home"
/// timestamp : "1678779411"

class SafeDepositBoxes {
  SafeDepositBoxes({
      String? safeDepositBoxId, 
      String? userId, 
      String? holderId, 
      String? boxNumber, 
      String? personAuthorizedToSign, 
      String? personWithKeys, 
      String? generalInventory, 
      String? holder, 
      String? holderName, 
      String? location, 
      String? timestamp,}){
    _safeDepositBoxId = safeDepositBoxId;
    _userId = userId;
    _holderId = holderId;
    _boxNumber = boxNumber;
    _personAuthorizedToSign = personAuthorizedToSign;
    _personWithKeys = personWithKeys;
    _generalInventory = generalInventory;
    _holder = holder;
    _holderName = holderName;
    _location = location;
    _timestamp = timestamp;
}

  SafeDepositBoxes.fromJson(dynamic json) {
    _safeDepositBoxId = json['safe_deposit_box_id'];
    _userId = json['user_id'];
    _holderId = json['holder_id'];
    _boxNumber = json['box_number'];
    _personAuthorizedToSign = json['person_authorized_to_sign'];
    _personWithKeys = json['person_with_keys'];
    _generalInventory = json['general_inventory'];
    _holder = json['holder'];
    _holderName = json['holder_name'];
    _location = json['location'];
    _timestamp = json['timestamp'];
  }
  String? _safeDepositBoxId;
  String? _userId;
  String? _holderId;
  String? _boxNumber;
  String? _personAuthorizedToSign;
  String? _personWithKeys;
  String? _generalInventory;
  String? _holder;
  String? _holderName;
  String? _location;
  String? _timestamp;
SafeDepositBoxes copyWith({  String? safeDepositBoxId,
  String? userId,
  String? holderId,
  String? boxNumber,
  String? personAuthorizedToSign,
  String? personWithKeys,
  String? generalInventory,
  String? holder,
  String? holderName,
  String? location,
  String? timestamp,
}) => SafeDepositBoxes(  safeDepositBoxId: safeDepositBoxId ?? _safeDepositBoxId,
  userId: userId ?? _userId,
  holderId: holderId ?? _holderId,
  boxNumber: boxNumber ?? _boxNumber,
  personAuthorizedToSign: personAuthorizedToSign ?? _personAuthorizedToSign,
  personWithKeys: personWithKeys ?? _personWithKeys,
  generalInventory: generalInventory ?? _generalInventory,
  holder: holder ?? _holder,
  holderName: holderName ?? _holderName,
  location: location ?? _location,
  timestamp: timestamp ?? _timestamp,
);
  String? get safeDepositBoxId => _safeDepositBoxId;
  String? get userId => _userId;
  String? get holderId => _holderId;
  String? get boxNumber => _boxNumber;
  String? get personAuthorizedToSign => _personAuthorizedToSign;
  String? get personWithKeys => _personWithKeys;
  String? get generalInventory => _generalInventory;
  String? get holder => _holder;
  String? get holderName => _holderName;
  String? get location => _location;
  String? get timestamp => _timestamp;

  TextEditingController locationController = TextEditingController();
  TextEditingController boxNumberController = TextEditingController();
  TextEditingController signController = TextEditingController();
  TextEditingController personKeyController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  set setLocation(String value)
  {
    _location = value;
  }

  set setBoxNumber(String value)
  {
    _boxNumber = value;
  }

  set setSign(String value)
  {
    _personAuthorizedToSign = value;
  }

  set setPersonKey(String value)
  {
    _personWithKeys = value;
  }

  set setNotes(String value)
  {
    _generalInventory = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['location'] = checkValidString(_location);
    map['box_number'] = checkValidString(_boxNumber);
    map['person_authorized_to_sign'] = checkValidString(_personAuthorizedToSign);
    map['person_with_keys'] = checkValidString(_personWithKeys);
    map['general_inventory'] = checkValidString(_generalInventory);
    if(checkValidString(_safeDepositBoxId).toString().isNotEmpty)
    {
      map['safe_deposit_box_id'] = _safeDepositBoxId;
    }
    map['holder'] = _holder;
    return map;
  }

}