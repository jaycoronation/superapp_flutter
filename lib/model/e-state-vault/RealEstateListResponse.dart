import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../utils/app_utils.dart';
/// real_properties : [{"real_property_id":"12","user_id":"164","holder_id":"97","holder_name":"","description":"","location":"Gota","encumbrances":"test","approximate_value":"3400000","title":"","name":"Ravi","holder":"A","timestamp":"1679037442","upload_doc":"https://vault.alphacapital.in/api/assets/uploads/softcopy/1679037442_IMG_20230314_143128875.jpg","type_of_property":"Home","loan":"23000","rent":"13000","purchased_on":"01/03/2023","location_of_document":"At homr","notes":"test note","nominee_name":"Ravi Patel"}]
/// success : 1
/// message : "Real properties found."

RealEstateListResponse realEstateListResponseFromJson(String str) => RealEstateListResponse.fromJson(json.decode(str));
String realEstateListResponseToJson(RealEstateListResponse data) => json.encode(data.toJson());
class RealEstateListResponse {
  RealEstateListResponse({
      List<RealProperties>? realProperties, 
      num? success, 
      String? message,}){
    _realProperties = realProperties;
    _success = success;
    _message = message;
}

  RealEstateListResponse.fromJson(dynamic json) {
    if (json['real_properties'] != null) {
      _realProperties = [];
      json['real_properties'].forEach((v) {
        _realProperties?.add(RealProperties.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<RealProperties>? _realProperties;
  num? _success;
  String? _message;
RealEstateListResponse copyWith({  List<RealProperties>? realProperties,
  num? success,
  String? message,
}) => RealEstateListResponse(  realProperties: realProperties ?? _realProperties,
  success: success ?? _success,
  message: message ?? _message,
);
  List<RealProperties>? get realProperties => _realProperties;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_realProperties != null) {
      map['real_properties'] = _realProperties?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// real_property_id : "12"
/// user_id : "164"
/// holder_id : "97"
/// holder_name : ""
/// description : ""
/// location : "Gota"
/// encumbrances : "test"
/// approximate_value : "3400000"
/// title : ""
/// name : "Ravi"
/// holder : "A"
/// timestamp : "1679037442"
/// upload_doc : "https://vault.alphacapital.in/api/assets/uploads/softcopy/1679037442_IMG_20230314_143128875.jpg"
/// type_of_property : "Home"
/// loan : "23000"
/// rent : "13000"
/// purchased_on : "01/03/2023"
/// location_of_document : "At homr"
/// notes : "test note"
/// nominee_name : "Ravi Patel"

RealProperties realPropertiesFromJson(String str) => RealProperties.fromJson(json.decode(str));
String realPropertiesToJson(RealProperties data) => json.encode(data.toJson());
class RealProperties {
  RealProperties({
      String? realPropertyId, 
      String? userId, 
      String? holderId, 
      String? holderName, 
      String? description, 
      String? location, 
      String? encumbrances, 
      String? approximateValue, 
      String? title, 
      String? name, 
      String? holder, 
      String? timestamp, 
      String? uploadDoc, 
      String? typeOfProperty, 
      String? loan, 
      String? rent, 
      String? purchasedOn, 
      String? locationOfDocument, 
      String? notes, 
      String? nomineeName,}){
    _realPropertyId = realPropertyId;
    _userId = userId;
    _holderId = holderId;
    _holderName = holderName;
    _description = description;
    _location = location;
    _encumbrances = encumbrances;
    _approximateValue = approximateValue;
    _title = title;
    _name = name;
    _holder = holder;
    _timestamp = timestamp;
    _uploadDoc = uploadDoc;
    _typeOfProperty = typeOfProperty;
    _loan = loan;
    _rent = rent;
    _purchasedOn = purchasedOn;
    _locationOfDocument = locationOfDocument;
    _notes = notes;
    _nomineeName = nomineeName;
}

  RealProperties.fromJson(dynamic json) {
    _realPropertyId = json['real_property_id'];
    _userId = json['user_id'];
    _holderId = json['holder_id'];
    _holderName = json['holder_name'];
    _description = json['description'];
    _location = json['location'];
    _encumbrances = json['encumbrances'];
    _approximateValue = json['approximate_value'];
    _title = json['title'];
    _name = json['name'];
    _holder = json['holder'];
    _timestamp = json['timestamp'];
    _uploadDoc = json['upload_doc'];
    _typeOfProperty = json['type_of_property'];
    _loan = json['loan'];
    _rent = json['rent'];
    _purchasedOn = json['purchased_on'];
    _locationOfDocument = json['location_of_document'];
    _notes = json['notes'];
    _nomineeName = json['nominee_name'];
  }
  String? _realPropertyId;
  String? _userId;
  String? _holderId;
  String? _holderName;
  String? _description;
  String? _location;
  String? _encumbrances;
  String? _approximateValue;
  String? _title;
  String? _name;
  String? _holder;
  String? _timestamp;
  String? _uploadDoc;
  String? _typeOfProperty;
  String? _loan;
  String? _rent;
  String? _purchasedOn;
  String? _locationOfDocument;
  String? _notes;
  String? _nomineeName;
RealProperties copyWith({  String? realPropertyId,
  String? userId,
  String? holderId,
  String? holderName,
  String? description,
  String? location,
  String? encumbrances,
  String? approximateValue,
  String? title,
  String? name,
  String? holder,
  String? timestamp,
  String? uploadDoc,
  String? typeOfProperty,
  String? loan,
  String? rent,
  String? purchasedOn,
  String? locationOfDocument,
  String? notes,
  String? nomineeName,
}) => RealProperties(  realPropertyId: realPropertyId ?? _realPropertyId,
  userId: userId ?? _userId,
  holderId: holderId ?? _holderId,
  holderName: holderName ?? _holderName,
  description: description ?? _description,
  location: location ?? _location,
  encumbrances: encumbrances ?? _encumbrances,
  approximateValue: approximateValue ?? _approximateValue,
  title: title ?? _title,
  name: name ?? _name,
  holder: holder ?? _holder,
  timestamp: timestamp ?? _timestamp,
  uploadDoc: uploadDoc ?? _uploadDoc,
  typeOfProperty: typeOfProperty ?? _typeOfProperty,
  loan: loan ?? _loan,
  rent: rent ?? _rent,
  purchasedOn: purchasedOn ?? _purchasedOn,
  locationOfDocument: locationOfDocument ?? _locationOfDocument,
  notes: notes ?? _notes,
  nomineeName: nomineeName ?? _nomineeName,
);
  String? get realPropertyId => _realPropertyId;
  String? get userId => _userId;
  String? get holderId => _holderId;
  String? get holderName => _holderName;
  String? get description => _description;
  String? get location => _location;
  String? get encumbrances => _encumbrances;
  String? get approximateValue => _approximateValue;
  String? get title => _title;
  String? get name => _name;
  String? get holder => _holder;
  String? get timestamp => _timestamp;
  String? get uploadDoc => _uploadDoc;
  String? get typeOfProperty => _typeOfProperty;
  String? get loan => _loan;
  String? get rent => _rent;
  String? get purchasedOn => _purchasedOn;
  String? get locationOfDocument => _locationOfDocument;
  String? get notes => _notes;
  String? get nomineeName => _nomineeName;

  TextEditingController typeOfPropertyController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController encumbrancesController = TextEditingController();
  TextEditingController approximateValueController = TextEditingController();
  TextEditingController loanController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController purchasedOnController = TextEditingController();
  TextEditingController locationOfDocumentController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController uploadDocController = TextEditingController();
  TextEditingController nomineeNameController = TextEditingController();

  set setTypeOfProperty(String value)
  {
    _typeOfProperty = value;
  }

  set setName(String value)
  {
    _name = value;
  }

  set setLocation(String value)
  {
    _location = value;
  }

  set setEncumbrances(String value)
  {
    _encumbrances = value;
  }

  set setApproximateValue(String value)
  {
    _approximateValue = value;
  }

  set setLoan(String value)
  {
    _loan = value;
  }

  set setRent(String value)
  {
    _rent = value;
  }

  set setPurchasedOn(String value)
  {
    _purchasedOn = value;
  }


  set setLocationOfDocument(String value)
  {
    _locationOfDocument = value;
  }

  set setNotes(String value)
  {
    _notes = value;
  }

  set setUploadDoc(String value)
  {
    _uploadDoc = value;
  }

  set setNomineeName(String value)
  {
    _nomineeName = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['holder'] = checkValidString(_holder);
    map['type_of_property'] = checkValidString(_typeOfProperty);
    map['name'] = checkValidString(_name);
    map['location'] = checkValidString(_location);
    map['encumbrances'] = checkValidString(_encumbrances);
    map['approximate_value'] = checkValidString(_approximateValue);
    map['loan'] = checkValidString(_loan);
    map['rent'] = checkValidString(_rent);
    map['location_of_document'] = checkValidString(_locationOfDocument);
    map['notes'] = checkValidString(_notes);
    map['nominee_name'] = checkValidString(_nomineeName);
    map['upload_doc'] = checkValidString(_uploadDoc);
    if(checkValidString(_realPropertyId).toString().isNotEmpty)
    {
      map['real_property_id'] = checkValidString(_realPropertyId);
    }
    return map;
  }

}