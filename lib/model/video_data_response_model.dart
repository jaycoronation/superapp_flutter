import 'dart:convert';
/// kind : "youtube#searchListResponse"
/// etag : "5D50nweMu0hkz0iyedHlZWSDk1k"
/// regionCode : "IN"
/// pageInfo : {"totalResults":42,"resultsPerPage":40}
/// items : [{"kind":"youtube#searchResult","etag":"xOHyS332LJbZHlaZB6srVJMbWKo","id":{"kind":"youtube#video","videoId":"pakWNKbqg6Q"},"snippet":{"publishedAt":"2023-03-03T08:03:59Z","channelId":"UC4b3XGclFHdug9IbdsnbwjA","title":"Market Outlook for the Month of March&#39;23 by  Manjit Singh, Associate Partner, Alpha Capital","description":"","thumbnails":{"default":{"url":"https://i.ytimg.com/vi/pakWNKbqg6Q/default.jpg","width":120,"height":90},"medium":{"url":"https://i.ytimg.com/vi/pakWNKbqg6Q/mqdefault.jpg","width":320,"height":180},"high":{"url":"https://i.ytimg.com/vi/pakWNKbqg6Q/hqdefault.jpg","width":480,"height":360}},"channelTitle":"ALPHA CAPITAL","liveBroadcastContent":"none","publishTime":"2023-03-03T08:03:59Z"}}]

VideoDataResponseModel videoDataResponseModelFromJson(String str) => VideoDataResponseModel.fromJson(json.decode(str));
String videoDataResponseModelToJson(VideoDataResponseModel data) => json.encode(data.toJson());
class VideoDataResponseModel {
  VideoDataResponseModel({
      String? kind, 
      String? etag, 
      String? regionCode, 
      PageInfo? pageInfo, 
      List<Items>? items,}){
    _kind = kind;
    _etag = etag;
    _regionCode = regionCode;
    _pageInfo = pageInfo;
    _items = items;
}

  VideoDataResponseModel.fromJson(dynamic json) {
    _kind = json['kind'];
    _etag = json['etag'];
    _regionCode = json['regionCode'];
    _pageInfo = json['pageInfo'] != null ? PageInfo.fromJson(json['pageInfo']) : null;
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
  }
  String? _kind;
  String? _etag;
  String? _regionCode;
  PageInfo? _pageInfo;
  List<Items>? _items;
VideoDataResponseModel copyWith({  String? kind,
  String? etag,
  String? regionCode,
  PageInfo? pageInfo,
  List<Items>? items,
}) => VideoDataResponseModel(  kind: kind ?? _kind,
  etag: etag ?? _etag,
  regionCode: regionCode ?? _regionCode,
  pageInfo: pageInfo ?? _pageInfo,
  items: items ?? _items,
);
  String? get kind => _kind;
  String? get etag => _etag;
  String? get regionCode => _regionCode;
  PageInfo? get pageInfo => _pageInfo;
  List<Items>? get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['kind'] = _kind;
    map['etag'] = _etag;
    map['regionCode'] = _regionCode;
    if (_pageInfo != null) {
      map['pageInfo'] = _pageInfo?.toJson();
    }
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// kind : "youtube#searchResult"
/// etag : "xOHyS332LJbZHlaZB6srVJMbWKo"
/// id : {"kind":"youtube#video","videoId":"pakWNKbqg6Q"}
/// snippet : {"publishedAt":"2023-03-03T08:03:59Z","channelId":"UC4b3XGclFHdug9IbdsnbwjA","title":"Market Outlook for the Month of March&#39;23 by  Manjit Singh, Associate Partner, Alpha Capital","description":"","thumbnails":{"default":{"url":"https://i.ytimg.com/vi/pakWNKbqg6Q/default.jpg","width":120,"height":90},"medium":{"url":"https://i.ytimg.com/vi/pakWNKbqg6Q/mqdefault.jpg","width":320,"height":180},"high":{"url":"https://i.ytimg.com/vi/pakWNKbqg6Q/hqdefault.jpg","width":480,"height":360}},"channelTitle":"ALPHA CAPITAL","liveBroadcastContent":"none","publishTime":"2023-03-03T08:03:59Z"}

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));
String itemsToJson(Items data) => json.encode(data.toJson());
class Items {
  Items({
      String? kind, 
      String? etag, 
      Id? id, 
      Snippet? snippet,}){
    _kind = kind;
    _etag = etag;
    _id = id;
    _snippet = snippet;
}

  Items.fromJson(dynamic json) {
    _kind = json['kind'];
    _etag = json['etag'];
    _id = json['id'] != null ? Id.fromJson(json['id']) : null;
    _snippet = json['snippet'] != null ? Snippet.fromJson(json['snippet']) : null;
  }
  String? _kind;
  String? _etag;
  Id? _id;
  Snippet? _snippet;
Items copyWith({  String? kind,
  String? etag,
  Id? id,
  Snippet? snippet,
}) => Items(  kind: kind ?? _kind,
  etag: etag ?? _etag,
  id: id ?? _id,
  snippet: snippet ?? _snippet,
);
  String? get kind => _kind;
  String? get etag => _etag;
  Id? get id => _id;
  Snippet? get snippet => _snippet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['kind'] = _kind;
    map['etag'] = _etag;
    if (_id != null) {
      map['id'] = _id?.toJson();
    }
    if (_snippet != null) {
      map['snippet'] = _snippet?.toJson();
    }
    return map;
  }

}

/// publishedAt : "2023-03-03T08:03:59Z"
/// channelId : "UC4b3XGclFHdug9IbdsnbwjA"
/// title : "Market Outlook for the Month of March&#39;23 by  Manjit Singh, Associate Partner, Alpha Capital"
/// description : ""
/// thumbnails : {"default":{"url":"https://i.ytimg.com/vi/pakWNKbqg6Q/default.jpg","width":120,"height":90},"medium":{"url":"https://i.ytimg.com/vi/pakWNKbqg6Q/mqdefault.jpg","width":320,"height":180},"high":{"url":"https://i.ytimg.com/vi/pakWNKbqg6Q/hqdefault.jpg","width":480,"height":360}}
/// channelTitle : "ALPHA CAPITAL"
/// liveBroadcastContent : "none"
/// publishTime : "2023-03-03T08:03:59Z"

Snippet snippetFromJson(String str) => Snippet.fromJson(json.decode(str));
String snippetToJson(Snippet data) => json.encode(data.toJson());
class Snippet {
  Snippet({
      String? publishedAt, 
      String? channelId, 
      String? title, 
      String? description, 
      Thumbnails? thumbnails, 
      String? channelTitle, 
      String? liveBroadcastContent, 
      String? publishTime,}){
    _publishedAt = publishedAt;
    _channelId = channelId;
    _title = title;
    _description = description;
    _thumbnails = thumbnails;
    _channelTitle = channelTitle;
    _liveBroadcastContent = liveBroadcastContent;
    _publishTime = publishTime;
}

  Snippet.fromJson(dynamic json) {
    _publishedAt = json['publishedAt'];
    _channelId = json['channelId'];
    _title = json['title'];
    _description = json['description'];
    _thumbnails = json['thumbnails'] != null ? Thumbnails.fromJson(json['thumbnails']) : null;
    _channelTitle = json['channelTitle'];
    _liveBroadcastContent = json['liveBroadcastContent'];
    _publishTime = json['publishTime'];
  }
  String? _publishedAt;
  String? _channelId;
  String? _title;
  String? _description;
  Thumbnails? _thumbnails;
  String? _channelTitle;
  String? _liveBroadcastContent;
  String? _publishTime;
Snippet copyWith({  String? publishedAt,
  String? channelId,
  String? title,
  String? description,
  Thumbnails? thumbnails,
  String? channelTitle,
  String? liveBroadcastContent,
  String? publishTime,
}) => Snippet(  publishedAt: publishedAt ?? _publishedAt,
  channelId: channelId ?? _channelId,
  title: title ?? _title,
  description: description ?? _description,
  thumbnails: thumbnails ?? _thumbnails,
  channelTitle: channelTitle ?? _channelTitle,
  liveBroadcastContent: liveBroadcastContent ?? _liveBroadcastContent,
  publishTime: publishTime ?? _publishTime,
);
  String? get publishedAt => _publishedAt;
  String? get channelId => _channelId;
  String? get title => _title;
  String? get description => _description;
  Thumbnails? get thumbnails => _thumbnails;
  String? get channelTitle => _channelTitle;
  String? get liveBroadcastContent => _liveBroadcastContent;
  String? get publishTime => _publishTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['publishedAt'] = _publishedAt;
    map['channelId'] = _channelId;
    map['title'] = _title;
    map['description'] = _description;
    if (_thumbnails != null) {
      map['thumbnails'] = _thumbnails?.toJson();
    }
    map['channelTitle'] = _channelTitle;
    map['liveBroadcastContent'] = _liveBroadcastContent;
    map['publishTime'] = _publishTime;
    return map;
  }

}

/// default : {"url":"https://i.ytimg.com/vi/pakWNKbqg6Q/default.jpg","width":120,"height":90}
/// medium : {"url":"https://i.ytimg.com/vi/pakWNKbqg6Q/mqdefault.jpg","width":320,"height":180}
/// high : {"url":"https://i.ytimg.com/vi/pakWNKbqg6Q/hqdefault.jpg","width":480,"height":360}

Thumbnails thumbnailsFromJson(String str) => Thumbnails.fromJson(json.decode(str));
String thumbnailsToJson(Thumbnails data) => json.encode(data.toJson());
class Thumbnails {
  Thumbnails({
      DefaultData? defaultData, 
      Medium? medium, 
      High? high,}){
    _defaultData = defaultData;
    _medium = medium;
    _high = high;
}

  Thumbnails.fromJson(dynamic json) {
    _defaultData = json['default'] != null ? DefaultData.fromJson(json['default']) : null;
    _medium = json['medium'] != null ? Medium.fromJson(json['medium']) : null;
    _high = json['high'] != null ? High.fromJson(json['high']) : null;
  }
  DefaultData? _defaultData;
  Medium? _medium;
  High? _high;
Thumbnails copyWith({  DefaultData? defaultData,
  Medium? medium,
  High? high,
}) => Thumbnails(  defaultData: defaultData ?? _defaultData,
  medium: medium ?? _medium,
  high: high ?? _high,
);
  DefaultData? get defaultData => _defaultData;
  Medium? get medium => _medium;
  High? get high => _high;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_defaultData != null) {
      map['default'] = _defaultData?.toJson();
    }
    if (_medium != null) {
      map['medium'] = _medium?.toJson();
    }
    if (_high != null) {
      map['high'] = _high?.toJson();
    }
    return map;
  }

}

/// url : "https://i.ytimg.com/vi/pakWNKbqg6Q/hqdefault.jpg"
/// width : 480
/// height : 360

High highFromJson(String str) => High.fromJson(json.decode(str));
String highToJson(High data) => json.encode(data.toJson());
class High {
  High({
      String? url, 
      num? width, 
      num? height,}){
    _url = url;
    _width = width;
    _height = height;
}

  High.fromJson(dynamic json) {
    _url = json['url'];
    _width = json['width'];
    _height = json['height'];
  }
  String? _url;
  num? _width;
  num? _height;
High copyWith({  String? url,
  num? width,
  num? height,
}) => High(  url: url ?? _url,
  width: width ?? _width,
  height: height ?? _height,
);
  String? get url => _url;
  num? get width => _width;
  num? get height => _height;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['width'] = _width;
    map['height'] = _height;
    return map;
  }

}

/// url : "https://i.ytimg.com/vi/pakWNKbqg6Q/mqdefault.jpg"
/// width : 320
/// height : 180

Medium mediumFromJson(String str) => Medium.fromJson(json.decode(str));
String mediumToJson(Medium data) => json.encode(data.toJson());
class Medium {
  Medium({
      String? url, 
      num? width, 
      num? height,}){
    _url = url;
    _width = width;
    _height = height;
}

  Medium.fromJson(dynamic json) {
    _url = json['url'];
    _width = json['width'];
    _height = json['height'];
  }
  String? _url;
  num? _width;
  num? _height;
Medium copyWith({  String? url,
  num? width,
  num? height,
}) => Medium(  url: url ?? _url,
  width: width ?? _width,
  height: height ?? _height,
);
  String? get url => _url;
  num? get width => _width;
  num? get height => _height;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['width'] = _width;
    map['height'] = _height;
    return map;
  }

}

/// url : "https://i.ytimg.com/vi/pakWNKbqg6Q/default.jpg"
/// width : 120
/// height : 90

DefaultData defaultDataFromJson(String str) => DefaultData.fromJson(json.decode(str));
String defaultDataToJson(DefaultData data) => json.encode(data.toJson());
class DefaultData {
  DefaultData({
      String? url, 
      num? width, 
      num? height,}){
    _url = url;
    _width = width;
    _height = height;
}

  DefaultData.fromJson(dynamic json) {
    _url = json['url'];
    _width = json['width'];
    _height = json['height'];
  }
  String? _url;
  num? _width;
  num? _height;
DefaultData copyWith({  String? url,
  num? width,
  num? height,
}) => DefaultData(  url: url ?? _url,
  width: width ?? _width,
  height: height ?? _height,
);
  String? get url => _url;
  num? get width => _width;
  num? get height => _height;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['width'] = _width;
    map['height'] = _height;
    return map;
  }

}

/// kind : "youtube#video"
/// videoId : "pakWNKbqg6Q"

Id idFromJson(String str) => Id.fromJson(json.decode(str));
String idToJson(Id data) => json.encode(data.toJson());
class Id {
  Id({
      String? kind, 
      String? videoId,}){
    _kind = kind;
    _videoId = videoId;
}

  Id.fromJson(dynamic json) {
    _kind = json['kind'];
    _videoId = json['videoId'];
  }
  String? _kind;
  String? _videoId;
Id copyWith({  String? kind,
  String? videoId,
}) => Id(  kind: kind ?? _kind,
  videoId: videoId ?? _videoId,
);
  String? get kind => _kind;
  String? get videoId => _videoId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['kind'] = _kind;
    map['videoId'] = _videoId;
    return map;
  }

}

/// totalResults : 42
/// resultsPerPage : 40

PageInfo pageInfoFromJson(String str) => PageInfo.fromJson(json.decode(str));
String pageInfoToJson(PageInfo data) => json.encode(data.toJson());
class PageInfo {
  PageInfo({
      num? totalResults, 
      num? resultsPerPage,}){
    _totalResults = totalResults;
    _resultsPerPage = resultsPerPage;
}

  PageInfo.fromJson(dynamic json) {
    _totalResults = json['totalResults'];
    _resultsPerPage = json['resultsPerPage'];
  }
  num? _totalResults;
  num? _resultsPerPage;
PageInfo copyWith({  num? totalResults,
  num? resultsPerPage,
}) => PageInfo(  totalResults: totalResults ?? _totalResults,
  resultsPerPage: resultsPerPage ?? _resultsPerPage,
);
  num? get totalResults => _totalResults;
  num? get resultsPerPage => _resultsPerPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalResults'] = _totalResults;
    map['resultsPerPage'] = _resultsPerPage;
    return map;
  }

}