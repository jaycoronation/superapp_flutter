import 'dart:convert';
/// android : {"version":"2.0.1.0","force_update":"1"}
/// ios : {"version":"","force_update":"0"}
/// success : 1
/// message : "Android version found!"

GetAppVersionRepsponseModel getAppVersionRepsponseModelFromJson(String str) => GetAppVersionRepsponseModel.fromJson(json.decode(str));
String getAppVersionRepsponseModelToJson(GetAppVersionRepsponseModel data) => json.encode(data.toJson());
class GetAppVersionRepsponseModel {
  GetAppVersionRepsponseModel({
      Android? android, 
      Ios? ios, 
      num? success, 
      String? message,}){
    _android = android;
    _ios = ios;
    _success = success;
    _message = message;
}

  GetAppVersionRepsponseModel.fromJson(dynamic json) {
    _android = json['android'] != null ? Android.fromJson(json['android']) : null;
    _ios = json['ios'] != null ? Ios.fromJson(json['ios']) : null;
    _success = json['success'];
    _message = json['message'];
  }
  Android? _android;
  Ios? _ios;
  num? _success;
  String? _message;
GetAppVersionRepsponseModel copyWith({  Android? android,
  Ios? ios,
  num? success,
  String? message,
}) => GetAppVersionRepsponseModel(  android: android ?? _android,
  ios: ios ?? _ios,
  success: success ?? _success,
  message: message ?? _message,
);
  Android? get android => _android;
  Ios? get ios => _ios;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_android != null) {
      map['android'] = _android?.toJson();
    }
    if (_ios != null) {
      map['ios'] = _ios?.toJson();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// version : ""
/// force_update : "0"

Ios iosFromJson(String str) => Ios.fromJson(json.decode(str));
String iosToJson(Ios data) => json.encode(data.toJson());
class Ios {
  Ios({
      String? version, 
      String? forceUpdate,}){
    _version = version;
    _forceUpdate = forceUpdate;
}

  Ios.fromJson(dynamic json) {
    _version = json['version'];
    _forceUpdate = json['force_update'];
  }
  String? _version;
  String? _forceUpdate;
Ios copyWith({  String? version,
  String? forceUpdate,
}) => Ios(  version: version ?? _version,
  forceUpdate: forceUpdate ?? _forceUpdate,
);
  String? get version => _version;
  String? get forceUpdate => _forceUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = _version;
    map['force_update'] = _forceUpdate;
    return map;
  }

}

/// version : "2.0.1.0"
/// force_update : "1"

Android androidFromJson(String str) => Android.fromJson(json.decode(str));
String androidToJson(Android data) => json.encode(data.toJson());
class Android {
  Android({
      String? version, 
      String? forceUpdate,}){
    _version = version;
    _forceUpdate = forceUpdate;
}

  Android.fromJson(dynamic json) {
    _version = json['version'];
    _forceUpdate = json['force_update'];
  }
  String? _version;
  String? _forceUpdate;
Android copyWith({  String? version,
  String? forceUpdate,
}) => Android(  version: version ?? _version,
  forceUpdate: forceUpdate ?? _forceUpdate,
);
  String? get version => _version;
  String? get forceUpdate => _forceUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = _version;
    map['force_update'] = _forceUpdate;
    return map;
  }

}