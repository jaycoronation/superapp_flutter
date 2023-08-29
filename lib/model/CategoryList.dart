import 'dart:convert';
/// category : [{"category":"Tax Planning","isSelected":false}]
/// success : 1
/// message : "Records found."

CategoryList categoryListFromJson(String str) => CategoryList.fromJson(json.decode(str));
String categoryListToJson(CategoryList data) => json.encode(data.toJson());
class CategoryList {
  CategoryList({
      List<Category>? category, 
      num? success, 
      String? message,}){
    _category = category;
    _success = success;
    _message = message;
}

  CategoryList.fromJson(dynamic json) {
    if (json['category'] != null) {
      _category = [];
      json['category'].forEach((v) {
        _category?.add(Category.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
  }
  List<Category>? _category;
  num? _success;
  String? _message;
CategoryList copyWith({  List<Category>? category,
  num? success,
  String? message,
}) => CategoryList(  category: category ?? _category,
  success: success ?? _success,
  message: message ?? _message,
);
  List<Category>? get category => _category;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_category != null) {
      map['category'] = _category?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// category : "Tax Planning"
/// isSelected : false

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());
class Category {
  Category({
      String? category, 
      bool? isSelected,}){
    _category = category;
    _isSelected = isSelected;
}

  Category.fromJson(dynamic json) {
    _category = json['category'];
    _isSelected = json['isSelected'];
  }
  String? _category;
  bool? _isSelected;
Category copyWith({  String? category,
  bool? isSelected,
}) => Category(  category: category ?? _category,
  isSelected: isSelected ?? _isSelected,
);
  String? get category => _category;
  bool? get isSelected => _isSelected;

  set isSelected(bool? value) {
    _isSelected = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category'] = _category;
    map['isSelected'] = _isSelected;
    return map;
  }

}