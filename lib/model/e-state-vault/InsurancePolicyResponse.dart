import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../utils/app_utils.dart';
/// insurance_policies_details : [{"insurance_policies_id":"36","user_id":"164","holder_id":"97","insurance_company":"LIC","type_of_policy":"Policy Type","policy_number":"#12345","person_thing_insured":"Ravi Patel","agent_name":"Maharshi Saparia","agent_phone":"1234567890","agent_address":"506 Coronation","holder":"A","holder_name":"","sum_assured":"40000","current_value":"42000","purchased_on":"16/03/2019","location_of_document":"At home","notes":"test note","nominee_name":"Pratik Kalariya","timestamp":"1678957838","upload_doc":"https://vault.alphacapital.in/api/assets/uploads/softcopy/1678957838_IMG_20230314_143128875.jpg"}]
/// total_count : "1"
/// success : 1
/// message : "Insurance policies details found."

InsurancePolicyResponse insurancePolicyResponseFromJson(String str) => InsurancePolicyResponse.fromJson(json.decode(str));
String insurancePolicyResponseToJson(InsurancePolicyResponse data) => json.encode(data.toJson());
class InsurancePolicyResponse {
  InsurancePolicyResponse({
      List<InsurancePoliciesDetails>? insurancePoliciesDetails, 
      num? success,
      String? message,}){
    _insurancePoliciesDetails = insurancePoliciesDetails;
    _success = success;
    _message = message;
}

  InsurancePolicyResponse.fromJson(dynamic json) {
    if (json['insurance_policies_details'] != null) {
      _insurancePoliciesDetails = [];
      json['insurance_policies_details'].forEach((v) {
        _insurancePoliciesDetails?.add(InsurancePoliciesDetails.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<InsurancePoliciesDetails>? _insurancePoliciesDetails;
  num? _success;
  String? _message;
InsurancePolicyResponse copyWith({  List<InsurancePoliciesDetails>? insurancePoliciesDetails,
  num? success,
  String? message,
}) => InsurancePolicyResponse(  insurancePoliciesDetails: insurancePoliciesDetails ?? _insurancePoliciesDetails,
  success: success ?? _success,
  message: message ?? _message,
);
  List<InsurancePoliciesDetails>? get insurancePoliciesDetails => _insurancePoliciesDetails;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_insurancePoliciesDetails != null) {
      map['insurance_policies_details'] = _insurancePoliciesDetails?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// insurance_policies_id : "36"
/// user_id : "164"
/// holder_id : "97"
/// insurance_company : "LIC"
/// type_of_policy : "Policy Type"
/// policy_number : "#12345"
/// person_thing_insured : "Ravi Patel"
/// agent_name : "Maharshi Saparia"
/// agent_phone : "1234567890"
/// agent_address : "506 Coronation"
/// holder : "A"
/// holder_name : ""
/// sum_assured : "40000"
/// current_value : "42000"
/// purchased_on : "16/03/2019"
/// location_of_document : "At home"
/// notes : "test note"
/// nominee_name : "Pratik Kalariya"
/// timestamp : "1678957838"
/// upload_doc : "https://vault.alphacapital.in/api/assets/uploads/softcopy/1678957838_IMG_20230314_143128875.jpg"

InsurancePoliciesDetails insurancePoliciesDetailsFromJson(String str) => InsurancePoliciesDetails.fromJson(json.decode(str));
String insurancePoliciesDetailsToJson(InsurancePoliciesDetails data) => json.encode(data.toJson());
class InsurancePoliciesDetails {
  InsurancePoliciesDetails({
      String? insurancePoliciesId, 
      String? userId, 
      String? holderId, 
      String? insuranceCompany, 
      String? typeOfPolicy, 
      String? policyNumber, 
      String? personThingInsured, 
      String? agentName, 
      String? agentPhone, 
      String? agentAddress, 
      String? holder, 
      String? holderName, 
      String? sumAssured, 
      String? currentValue, 
      String? purchasedOn, 
      String? locationOfDocument, 
      String? notes, 
      String? nomineeName, 
      String? timestamp, 
      String? uploadDoc,}){
    _insurancePoliciesId = insurancePoliciesId;
    _userId = userId;
    _holderId = holderId;
    _insuranceCompany = insuranceCompany;
    _typeOfPolicy = typeOfPolicy;
    _policyNumber = policyNumber;
    _personThingInsured = personThingInsured;
    _agentName = agentName;
    _agentPhone = agentPhone;
    _agentAddress = agentAddress;
    _holder = holder;
    _holderName = holderName;
    _sumAssured = sumAssured;
    _currentValue = currentValue;
    _purchasedOn = purchasedOn;
    _locationOfDocument = locationOfDocument;
    _notes = notes;
    _nomineeName = nomineeName;
    _timestamp = timestamp;
    _uploadDoc = uploadDoc;
}

  InsurancePoliciesDetails.fromJson(dynamic json) {
    _insurancePoliciesId = json['insurance_policies_id'];
    _userId = json['user_id'];
    _holderId = json['holder_id'];
    _insuranceCompany = json['insurance_company'];
    _typeOfPolicy = json['type_of_policy'];
    _policyNumber = json['policy_number'];
    _personThingInsured = json['person_thing_insured'];
    _agentName = json['agent_name'];
    _agentPhone = json['agent_phone'];
    _agentAddress = json['agent_address'];
    _holder = json['holder'];
    _holderName = json['holder_name'];
    _sumAssured = json['sum_assured'];
    _currentValue = json['current_value'];
    _purchasedOn = json['purchased_on'];
    _locationOfDocument = json['location_of_document'];
    _notes = json['notes'];
    _nomineeName = json['nominee_name'];
    _timestamp = json['timestamp'];
    _uploadDoc = json['upload_doc'];
  }
  String? _insurancePoliciesId;
  String? _userId;
  String? _holderId;
  String? _insuranceCompany;
  String? _typeOfPolicy;
  String? _policyNumber;
  String? _personThingInsured;
  String? _agentName;
  String? _agentPhone;
  String? _agentAddress;
  String? _holder;
  String? _holderName;
  String? _sumAssured;
  String? _currentValue;
  String? _purchasedOn;
  String? _locationOfDocument;
  String? _notes;
  String? _nomineeName;
  String? _timestamp;
  String? _uploadDoc;
InsurancePoliciesDetails copyWith({  String? insurancePoliciesId,
  String? userId,
  String? holderId,
  String? insuranceCompany,
  String? typeOfPolicy,
  String? policyNumber,
  String? personThingInsured,
  String? agentName,
  String? agentPhone,
  String? agentAddress,
  String? holder,
  String? holderName,
  String? sumAssured,
  String? currentValue,
  String? purchasedOn,
  String? locationOfDocument,
  String? notes,
  String? nomineeName,
  String? timestamp,
  String? uploadDoc,
}) => InsurancePoliciesDetails(  insurancePoliciesId: insurancePoliciesId ?? _insurancePoliciesId,
  userId: userId ?? _userId,
  holderId: holderId ?? _holderId,
  insuranceCompany: insuranceCompany ?? _insuranceCompany,
  typeOfPolicy: typeOfPolicy ?? _typeOfPolicy,
  policyNumber: policyNumber ?? _policyNumber,
  personThingInsured: personThingInsured ?? _personThingInsured,
  agentName: agentName ?? _agentName,
  agentPhone: agentPhone ?? _agentPhone,
  agentAddress: agentAddress ?? _agentAddress,
  holder: holder ?? _holder,
  holderName: holderName ?? _holderName,
  sumAssured: sumAssured ?? _sumAssured,
  currentValue: currentValue ?? _currentValue,
  purchasedOn: purchasedOn ?? _purchasedOn,
  locationOfDocument: locationOfDocument ?? _locationOfDocument,
  notes: notes ?? _notes,
  nomineeName: nomineeName ?? _nomineeName,
  timestamp: timestamp ?? _timestamp,
  uploadDoc: uploadDoc ?? _uploadDoc,
);
  String? get insurancePoliciesId => _insurancePoliciesId;
  String? get userId => _userId;
  String? get holderId => _holderId;
  String? get insuranceCompany => _insuranceCompany;
  String? get typeOfPolicy => _typeOfPolicy;
  String? get policyNumber => _policyNumber;
  String? get personThingInsured => _personThingInsured;
  String? get agentName => _agentName;
  String? get agentPhone => _agentPhone;
  String? get agentAddress => _agentAddress;
  String? get holder => _holder;
  String? get holderName => _holderName;
  String? get sumAssured => _sumAssured;
  String? get currentValue => _currentValue;
  String? get purchasedOn => _purchasedOn;
  String? get locationOfDocument => _locationOfDocument;
  String? get notes => _notes;
  String? get nomineeName => _nomineeName;
  String? get timestamp => _timestamp;
  String? get uploadDoc => _uploadDoc;

  TextEditingController insuranceCompanyController = TextEditingController();
  TextEditingController typeOfPolicyController = TextEditingController();
  TextEditingController policyNumberController = TextEditingController();
  TextEditingController personThingInsuredController = TextEditingController();
  TextEditingController sumAssuredController = TextEditingController();
  TextEditingController currentValueController = TextEditingController();
  TextEditingController purchasedOnController = TextEditingController();
  TextEditingController agentNameController = TextEditingController();
  TextEditingController agentPhoneController = TextEditingController();
  TextEditingController agentAddressController = TextEditingController();
  TextEditingController locationOfDocumentController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController uploadDocController = TextEditingController();
  TextEditingController nomineeNameController = TextEditingController();

  set setInsuranceCompany(String value)
  {
    _insuranceCompany = value;
  }

  set setTypeOfPolicy(String value)
  {
    _typeOfPolicy = value;
  }

  set setPolicyNumber(String value)
  {
    _policyNumber = value;
  }

  set setPersonThingInsured(String value)
  {
    _personThingInsured = value;
  }

  set setSumAssured(String value)
  {
    _sumAssured = value;
  }

  set setCurrentValue(String value)
  {
    _currentValue = value;
  }

  set setPurchasedOn(String value)
  {
    _purchasedOn = value;
  }

  set setAgentName(String value)
  {
    _agentName = value;
  }

  set setAgentPhone(String value)
  {
    _agentPhone = value;
  }

  set setAgentAddress(String value)
  {
    _agentAddress = value;
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
    map['insurance_company'] = checkValidString(_insuranceCompany);
    map['type_of_policy'] = checkValidString(_typeOfPolicy);
    map['policy_number'] = checkValidString(_policyNumber);
    map['person_thing_insured'] = checkValidString(_personThingInsured);
    map['sum_assured'] = checkValidString(_sumAssured);
    map['current_value'] = checkValidString(_currentValue);
    map['purchased_on'] = checkValidString(_purchasedOn);
    map['agent_name'] = checkValidString(_agentName);
    map['agent_phone'] = checkValidString(_agentPhone);
    map['agent_address'] = checkValidString(_agentAddress);
    map['location_of_document'] = checkValidString(_locationOfDocument);
    map['notes'] = checkValidString(_notes);
    map['nominee_name'] = checkValidString(_nomineeName);
    map['upload_doc'] = checkValidString(_uploadDoc);
    if(checkValidString(_insurancePoliciesId).toString().isNotEmpty)
    {
      map['insurance_policies_id'] = checkValidString(_insurancePoliciesId);
    }
    return map;
  }

}