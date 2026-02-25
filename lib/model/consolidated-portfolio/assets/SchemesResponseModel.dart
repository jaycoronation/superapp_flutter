import 'dart:convert';
/// schemes_final : [{"scheme_id":"43186","scheme_name":"YES - Liquid Fund (W) (D) Reinv Direct","category":"Debt: Liquid","timestamp":"1554963227"}]
/// success : 1

SchemesResponseModel schemesResponseModelFromJson(String str) => SchemesResponseModel.fromJson(json.decode(str));
String schemesResponseModelToJson(SchemesResponseModel data) => json.encode(data.toJson());
class SchemesResponseModel {
  SchemesResponseModel({
      List<SchemesFinal>? schemesFinal, 
      num? success,}){
    _schemesFinal = schemesFinal;
    _success = success;
}

  SchemesResponseModel.fromJson(dynamic json) {
    if (json['schemes_final'] != null) {
      _schemesFinal = [];
      json['schemes_final'].forEach((v) {
        _schemesFinal?.add(SchemesFinal.fromJson(v));
      });
    }
    _success = json['success'];
  }
  List<SchemesFinal>? _schemesFinal;
  num? _success;
SchemesResponseModel copyWith({  List<SchemesFinal>? schemesFinal,
  num? success,
}) => SchemesResponseModel(  schemesFinal: schemesFinal ?? _schemesFinal,
  success: success ?? _success,
);
  List<SchemesFinal>? get schemesFinal => _schemesFinal;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_schemesFinal != null) {
      map['schemes_final'] = _schemesFinal?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    return map;
  }

}

/// scheme_id : "43186"
/// scheme_name : "YES - Liquid Fund (W) (D) Reinv Direct"
/// category : "Debt: Liquid"
/// timestamp : "1554963227"

SchemesFinal schemesFinalFromJson(String str) => SchemesFinal.fromJson(json.decode(str));
String schemesFinalToJson(SchemesFinal data) => json.encode(data.toJson());
class SchemesFinal {
  SchemesFinal({
      String? schemeId, 
      String? schemeName, 
      String? category, 
      String? timestamp,}){
    _schemeId = schemeId;
    _schemeName = schemeName;
    _category = category;
    _timestamp = timestamp;
}

  SchemesFinal.fromJson(dynamic json) {
    _schemeId = json['scheme_id'];
    _schemeName = json['scheme_name'];
    _category = json['category'];
    _timestamp = json['timestamp'];
  }
  String? _schemeId;
  String? _schemeName;
  String? _category;
  String? _timestamp;
SchemesFinal copyWith({  String? schemeId,
  String? schemeName,
  String? category,
  String? timestamp,
}) => SchemesFinal(  schemeId: schemeId ?? _schemeId,
  schemeName: schemeName ?? _schemeName,
  category: category ?? _category,
  timestamp: timestamp ?? _timestamp,
);
  String? get schemeId => _schemeId;
  String? get schemeName => _schemeName;
  String? get category => _category;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['scheme_id'] = _schemeId;
    map['scheme_name'] = _schemeName;
    map['category'] = _category;
    map['timestamp'] = _timestamp;
    return map;
  }

}