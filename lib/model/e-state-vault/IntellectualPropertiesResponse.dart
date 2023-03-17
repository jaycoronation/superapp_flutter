import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../utils/app_utils.dart';
/// intellectual_properties : [{"intellectual_property_id":"8","user_id":"164","holder_id":"97","holder_name":"","description":"gdg","lawyer_name":"dbhhr","firm":"rhh","phone":"2147483647","address":"egrg","branch":"","holder":"A","created_on":"17/03/2023","location_of_document":"dbh","notes":"ehh","nominee_name":"dhdh","upload_doc":"https://vault.alphacapital.in/api/assets/uploads/softcopy/1679034190_IMG_20230317_115302418.jpg","timestamp":"1679034190"}]
/// success : 1
/// message : "Intellectual properties found."

IntellectualPropertiesResponse intellectualPropertiesResponseFromJson(String str) => IntellectualPropertiesResponse.fromJson(json.decode(str));
String intellectualPropertiesResponseToJson(IntellectualPropertiesResponse data) => json.encode(data.toJson());
class IntellectualPropertiesResponse {
  IntellectualPropertiesResponse({
      List<IntellectualProperties>? intellectualProperties, 
      num? success, 
      String? message,}){
    _intellectualProperties = intellectualProperties;
    _success = success;
    _message = message;
}

  IntellectualPropertiesResponse.fromJson(dynamic json) {
    if (json['intellectual_properties'] != null) {
      _intellectualProperties = [];
      json['intellectual_properties'].forEach((v) {
        _intellectualProperties?.add(IntellectualProperties.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<IntellectualProperties>? _intellectualProperties;
  num? _success;
  String? _message;
IntellectualPropertiesResponse copyWith({  List<IntellectualProperties>? intellectualProperties,
  num? success,
  String? message,
}) => IntellectualPropertiesResponse(  intellectualProperties: intellectualProperties ?? _intellectualProperties,
  success: success ?? _success,
  message: message ?? _message,
);
  List<IntellectualProperties>? get intellectualProperties => _intellectualProperties;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_intellectualProperties != null) {
      map['intellectual_properties'] = _intellectualProperties?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// intellectual_property_id : "8"
/// user_id : "164"
/// holder_id : "97"
/// holder_name : ""
/// description : "gdg"
/// lawyer_name : "dbhhr"
/// firm : "rhh"
/// phone : "2147483647"
/// address : "egrg"
/// branch : ""
/// holder : "A"
/// created_on : "17/03/2023"
/// location_of_document : "dbh"
/// notes : "ehh"
/// nominee_name : "dhdh"
/// upload_doc : "https://vault.alphacapital.in/api/assets/uploads/softcopy/1679034190_IMG_20230317_115302418.jpg"
/// timestamp : "1679034190"

IntellectualProperties intellectualPropertiesFromJson(String str) => IntellectualProperties.fromJson(json.decode(str));
String intellectualPropertiesToJson(IntellectualProperties data) => json.encode(data.toJson());
class IntellectualProperties {
  IntellectualProperties({
      String? intellectualPropertyId, 
      String? userId, 
      String? holderId, 
      String? holderName, 
      String? description, 
      String? lawyerName, 
      String? firm, 
      String? phone, 
      String? address, 
      String? branch, 
      String? holder, 
      String? createdOn, 
      String? locationOfDocument, 
      String? notes, 
      String? nomineeName, 
      String? uploadDoc, 
      String? timestamp,}){
    _intellectualPropertyId = intellectualPropertyId;
    _userId = userId;
    _holderId = holderId;
    _holderName = holderName;
    _description = description;
    _lawyerName = lawyerName;
    _firm = firm;
    _phone = phone;
    _address = address;
    _branch = branch;
    _holder = holder;
    _createdOn = createdOn;
    _locationOfDocument = locationOfDocument;
    _notes = notes;
    _nomineeName = nomineeName;
    _uploadDoc = uploadDoc;
    _timestamp = timestamp;
}

  IntellectualProperties.fromJson(dynamic json) {
    _intellectualPropertyId = json['intellectual_property_id'];
    _userId = json['user_id'];
    _holderId = json['holder_id'];
    _holderName = json['holder_name'];
    _description = json['description'];
    _lawyerName = json['lawyer_name'];
    _firm = json['firm'];
    _phone = json['phone'];
    _address = json['address'];
    _branch = json['branch'];
    _holder = json['holder'];
    _createdOn = json['created_on'];
    _locationOfDocument = json['location_of_document'];
    _notes = json['notes'];
    _nomineeName = json['nominee_name'];
    _uploadDoc = json['upload_doc'];
    _timestamp = json['timestamp'];
  }
  String? _intellectualPropertyId;
  String? _userId;
  String? _holderId;
  String? _holderName;
  String? _description;
  String? _lawyerName;
  String? _firm;
  String? _phone;
  String? _address;
  String? _branch;
  String? _holder;
  String? _createdOn;
  String? _locationOfDocument;
  String? _notes;
  String? _nomineeName;
  String? _uploadDoc;
  String? _timestamp;
IntellectualProperties copyWith({  String? intellectualPropertyId,
  String? userId,
  String? holderId,
  String? holderName,
  String? description,
  String? lawyerName,
  String? firm,
  String? phone,
  String? address,
  String? branch,
  String? holder,
  String? createdOn,
  String? locationOfDocument,
  String? notes,
  String? nomineeName,
  String? uploadDoc,
  String? timestamp,
}) => IntellectualProperties(  intellectualPropertyId: intellectualPropertyId ?? _intellectualPropertyId,
  userId: userId ?? _userId,
  holderId: holderId ?? _holderId,
  holderName: holderName ?? _holderName,
  description: description ?? _description,
  lawyerName: lawyerName ?? _lawyerName,
  firm: firm ?? _firm,
  phone: phone ?? _phone,
  address: address ?? _address,
  branch: branch ?? _branch,
  holder: holder ?? _holder,
  createdOn: createdOn ?? _createdOn,
  locationOfDocument: locationOfDocument ?? _locationOfDocument,
  notes: notes ?? _notes,
  nomineeName: nomineeName ?? _nomineeName,
  uploadDoc: uploadDoc ?? _uploadDoc,
  timestamp: timestamp ?? _timestamp,
);
  String? get intellectualPropertyId => _intellectualPropertyId;
  String? get userId => _userId;
  String? get holderId => _holderId;
  String? get holderName => _holderName;
  String? get description => _description;
  String? get lawyerName => _lawyerName;
  String? get firm => _firm;
  String? get phone => _phone;
  String? get address => _address;
  String? get branch => _branch;
  String? get holder => _holder;
  String? get createdOn => _createdOn;
  String? get locationOfDocument => _locationOfDocument;
  String? get notes => _notes;
  String? get nomineeName => _nomineeName;
  String? get uploadDoc => _uploadDoc;
  String? get timestamp => _timestamp;

  TextEditingController descriptionController = TextEditingController();
  TextEditingController lawyerNameController = TextEditingController();
  TextEditingController firmController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController createdOnController = TextEditingController();
  TextEditingController locationOfDocumentController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController uploadDocController = TextEditingController();
  TextEditingController nomineeNameController = TextEditingController();

  set setDescription(String value)
  {
    _description = value;
  }

  set setLawyerName(String value)
  {
    _lawyerName = value;
  }

  set setFirm(String value)
  {
    _firm = value;
  }

  set setPhone(String value)
  {
    _phone = value;
  }

  set setAddress(String value)
  {
    _address = value;
  }

  set setCreatedOn(String value)
  {
    _createdOn = value;
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
    map['description'] = checkValidString(_description);
    map['lawyer_name'] = checkValidString(_lawyerName);
    map['firm'] = checkValidString(_firm);
    map['phone'] = checkValidString(_phone);
    map['address'] = checkValidString(_address);
    map['nominee_name'] = checkValidString(_nomineeName);
    map['created_on'] = checkValidString(_createdOn);
    map['location_of_document'] = checkValidString(_locationOfDocument);
    map['notes'] = checkValidString(_notes);
    map['nominee_name'] = checkValidString(_nomineeName);
    map['upload_doc'] = checkValidString(_uploadDoc);
    if(checkValidString(_intellectualPropertyId).toString().isNotEmpty)
    {
      map['intellectual_property_id'] = checkValidString(_intellectualPropertyId);
    }
    return map;
  }

}