import 'dart:convert';
/// links : [{"name":"blog","link":"https://alphacapital.in/blog/?noheader=true"},{"name":"videos","link":"https://www.alphacapital.in/video/"}]
/// success : 1
/// message : "2 Links found"

LinksResponseModel linksResponseModelFromJson(String str) => LinksResponseModel.fromJson(json.decode(str));
String linksResponseModelToJson(LinksResponseModel data) => json.encode(data.toJson());
class LinksResponseModel {
  LinksResponseModel({
      List<Links>? links, 
      num? success, 
      String? message,}){
    _links = links;
    _success = success;
    _message = message;
}

  LinksResponseModel.fromJson(dynamic json) {
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<Links>? _links;
  num? _success;
  String? _message;
LinksResponseModel copyWith({  List<Links>? links,
  num? success,
  String? message,
}) => LinksResponseModel(  links: links ?? _links,
  success: success ?? _success,
  message: message ?? _message,
);
  List<Links>? get links => _links;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// name : "blog"
/// link : "https://alphacapital.in/blog/?noheader=true"

Links linksFromJson(String str) => Links.fromJson(json.decode(str));
String linksToJson(Links data) => json.encode(data.toJson());
class Links {
  Links({
      String? name, 
      String? link,}){
    _name = name;
    _link = link;
}

  Links.fromJson(dynamic json) {
    _name = json['name'];
    _link = json['link'];
  }
  String? _name;
  String? _link;
Links copyWith({  String? name,
  String? link,
}) => Links(  name: name ?? _name,
  link: link ?? _link,
);
  String? get name => _name;
  String? get link => _link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['link'] = _link;
    return map;
  }

}