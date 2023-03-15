import 'dart:convert';
/// mcad_id : "33"
/// user_id : "164"
/// minor_children_and_dependents : "test1"
/// name_address_phone : "test2"
/// agreed_to_assume_responsibility : "test3"
/// have_you : "test4"
/// document_located : "test5"
/// instructions_directions_suggestions : "test6"
/// timestamp : "1678796783"

MinorChildrenDependentsData minorChildrenDependentsDataFromJson(String str) => MinorChildrenDependentsData.fromJson(json.decode(str));
String minorChildrenDependentsDataToJson(MinorChildrenDependentsData data) => json.encode(data.toJson());
class MinorChildrenDependentsData {
  MinorChildrenDependentsData({
      String? mcadId, 
      String? userId, 
      String? minorChildrenAndDependents, 
      String? nameAddressPhone, 
      String? agreedToAssumeResponsibility, 
      String? haveYou, 
      String? documentLocated, 
      String? instructionsDirectionsSuggestions, 
      String? timestamp,}){
    _mcadId = mcadId;
    _userId = userId;
    _minorChildrenAndDependents = minorChildrenAndDependents;
    _nameAddressPhone = nameAddressPhone;
    _agreedToAssumeResponsibility = agreedToAssumeResponsibility;
    _haveYou = haveYou;
    _documentLocated = documentLocated;
    _instructionsDirectionsSuggestions = instructionsDirectionsSuggestions;
    _timestamp = timestamp;
}

  MinorChildrenDependentsData.fromJson(dynamic json) {
    _mcadId = json['mcad_id'];
    _userId = json['user_id'];
    _minorChildrenAndDependents = json['minor_children_and_dependents'];
    _nameAddressPhone = json['name_address_phone'];
    _agreedToAssumeResponsibility = json['agreed_to_assume_responsibility'];
    _haveYou = json['have_you'];
    _documentLocated = json['document_located'];
    _instructionsDirectionsSuggestions = json['instructions_directions_suggestions'];
    _timestamp = json['timestamp'];
  }
  String? _mcadId;
  String? _userId;
  String? _minorChildrenAndDependents;
  String? _nameAddressPhone;
  String? _agreedToAssumeResponsibility;
  String? _haveYou;
  String? _documentLocated;
  String? _instructionsDirectionsSuggestions;
  String? _timestamp;
MinorChildrenDependentsData copyWith({  String? mcadId,
  String? userId,
  String? minorChildrenAndDependents,
  String? nameAddressPhone,
  String? agreedToAssumeResponsibility,
  String? haveYou,
  String? documentLocated,
  String? instructionsDirectionsSuggestions,
  String? timestamp,
}) => MinorChildrenDependentsData(  mcadId: mcadId ?? _mcadId,
  userId: userId ?? _userId,
  minorChildrenAndDependents: minorChildrenAndDependents ?? _minorChildrenAndDependents,
  nameAddressPhone: nameAddressPhone ?? _nameAddressPhone,
  agreedToAssumeResponsibility: agreedToAssumeResponsibility ?? _agreedToAssumeResponsibility,
  haveYou: haveYou ?? _haveYou,
  documentLocated: documentLocated ?? _documentLocated,
  instructionsDirectionsSuggestions: instructionsDirectionsSuggestions ?? _instructionsDirectionsSuggestions,
  timestamp: timestamp ?? _timestamp,
);
  String? get mcadId => _mcadId;
  String? get userId => _userId;
  String? get minorChildrenAndDependents => _minorChildrenAndDependents;
  String? get nameAddressPhone => _nameAddressPhone;
  String? get agreedToAssumeResponsibility => _agreedToAssumeResponsibility;
  String? get haveYou => _haveYou;
  String? get documentLocated => _documentLocated;
  String? get instructionsDirectionsSuggestions => _instructionsDirectionsSuggestions;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mcad_id'] = _mcadId;
    map['user_id'] = _userId;
    map['minor_children_and_dependents'] = _minorChildrenAndDependents;
    map['name_address_phone'] = _nameAddressPhone;
    map['agreed_to_assume_responsibility'] = _agreedToAssumeResponsibility;
    map['have_you'] = _haveYou;
    map['document_located'] = _documentLocated;
    map['instructions_directions_suggestions'] = _instructionsDirectionsSuggestions;
    map['timestamp'] = _timestamp;
    return map;
  }

}