import 'dart:convert';
/// search_schemes : [{"SchemeName":"ICICI Prudential India Opportunities Fund - Direct Plan - IDCW Option","category":"Equity: Sectoral/ Thematic","isin_no":"INF109KC1RJ5","asset_class":"Equity"},{"SchemeName":"ICICI Prudential India Opportunities Fund - IDCW Option","category":"Equity: Sectoral/ Thematic","isin_no":"INF109KC1RG1","asset_class":"Equity"},{"SchemeName":"ICICI Prudential Banking and PSU Debt Fund - Direct Plan -  Growth","category":"Debt: Banking and PSU","isin_no":"INF109K010A6","asset_class":"Debt"},{"SchemeName":"ICICI Prudential Banking and PSU Debt Fund - Direct Plan -  Quarterly IDCW","category":"Debt: Banking and PSU","isin_no":"INF109K011A4","asset_class":"Debt"},{"SchemeName":"ICICI Prudential Banking and PSU Debt Fund - Growth","category":"Debt: Banking and PSU","isin_no":"INF109K01RT3","asset_class":"Debt"}]
/// success : 1

SearchSchemeResponseModel searchSchemeResponseModelFromJson(String str) => SearchSchemeResponseModel.fromJson(json.decode(str));
String searchSchemeResponseModelToJson(SearchSchemeResponseModel data) => json.encode(data.toJson());
class SearchSchemeResponseModel {
  SearchSchemeResponseModel({
      List<SearchSchemes>? searchSchemes, 
      num? success,}){
    _searchSchemes = searchSchemes;
    _success = success;
}

  SearchSchemeResponseModel.fromJson(dynamic json) {
    if (json['search_schemes'] != null) {
      _searchSchemes = [];
      json['search_schemes'].forEach((v) {
        _searchSchemes?.add(SearchSchemes.fromJson(v));
      });
    }
    _success = json['success'];
  }
  List<SearchSchemes>? _searchSchemes;
  num? _success;
SearchSchemeResponseModel copyWith({  List<SearchSchemes>? searchSchemes,
  num? success,
}) => SearchSchemeResponseModel(  searchSchemes: searchSchemes ?? _searchSchemes,
  success: success ?? _success,
);
  List<SearchSchemes>? get searchSchemes => _searchSchemes;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_searchSchemes != null) {
      map['search_schemes'] = _searchSchemes?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    return map;
  }

}

/// SchemeName : "ICICI Prudential India Opportunities Fund - Direct Plan - IDCW Option"
/// category : "Equity: Sectoral/ Thematic"
/// isin_no : "INF109KC1RJ5"
/// asset_class : "Equity"

SearchSchemes searchSchemesFromJson(String str) => SearchSchemes.fromJson(json.decode(str));
String searchSchemesToJson(SearchSchemes data) => json.encode(data.toJson());
class SearchSchemes {
  SearchSchemes({
      String? schemeName, 
      String? category, 
      String? isinNo, 
      String? assetClass,}){
    _schemeName = schemeName;
    _category = category;
    _isinNo = isinNo;
    _assetClass = assetClass;
}

  SearchSchemes.fromJson(dynamic json) {
    _schemeName = json['SchemeName'];
    _category = json['category'];
    _isinNo = json['isin_no'];
    _assetClass = json['asset_class'];
  }
  String? _schemeName;
  String? _category;
  String? _isinNo;
  String? _assetClass;
SearchSchemes copyWith({  String? schemeName,
  String? category,
  String? isinNo,
  String? assetClass,
}) => SearchSchemes(  schemeName: schemeName ?? _schemeName,
  category: category ?? _category,
  isinNo: isinNo ?? _isinNo,
  assetClass: assetClass ?? _assetClass,
);
  String? get schemeName => _schemeName;
  String? get category => _category;
  String? get isinNo => _isinNo;
  String? get assetClass => _assetClass;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SchemeName'] = _schemeName;
    map['category'] = _category;
    map['isin_no'] = _isinNo;
    map['asset_class'] = _assetClass;
    return map;
  }

}