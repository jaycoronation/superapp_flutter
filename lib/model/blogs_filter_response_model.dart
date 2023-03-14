import 'dart:convert';
/// url : [{"title":"All","url":"https://www.alphacapital.in/blog/feed/json"},{"title":"Financial Planning","url":"https://www.alphacapital.in/blog/category/financial-planning/feed/json"},{"title":"General","url":"https://www.alphacapital.in/blog/category/general/feed/json"},{"title":"Investment Ideas","url":"https://www.alphacapital.in/blog/category/investmentideas/feed/json"},{"title":"Tax Planning","url":"https://www.alphacapital.in/blog/category/taxplanning/feed/json"}]

BlogsFilterResponseModel blogsFilterResponseModelFromJson(String str) => BlogsFilterResponseModel.fromJson(json.decode(str));
String blogsFilterResponseModelToJson(BlogsFilterResponseModel data) => json.encode(data.toJson());
class BlogsFilterResponseModel {
  BlogsFilterResponseModel({
      List<Url>? url,}){
    _url = url;
}

  BlogsFilterResponseModel.fromJson(dynamic json) {
    if (json['url'] != null) {
      _url = [];
      json['url'].forEach((v) {
        _url?.add(Url.fromJson(v));
      });
    }
  }
  List<Url>? _url;
BlogsFilterResponseModel copyWith({  List<Url>? url,
}) => BlogsFilterResponseModel(  url: url ?? _url,
);
  List<Url>? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_url != null) {
      map['url'] = _url?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// title : "All"
/// url : "https://www.alphacapital.in/blog/feed/json"

Url urlFromJson(String str) => Url.fromJson(json.decode(str));
String urlToJson(Url data) => json.encode(data.toJson());
class Url {
  Url({
      String? title, 
      String? url,}){
    _title = title;
    _url = url;
}

  Url.fromJson(dynamic json) {
    _title = json['title'];
    _url = json['url'];
  }
  String? _title;
  String? _url;
Url copyWith({  String? title,
  String? url,
}) => Url(  title: title ?? _title,
  url: url ?? _url,
);
  String? get title => _title;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['url'] = _url;
    return map;
  }

}