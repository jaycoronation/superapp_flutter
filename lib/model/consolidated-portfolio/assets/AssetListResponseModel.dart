/// assets : [{"quantity":"1","id":"27596","user_id":"500","it_id":"1","asset_class":"Equity","scheme_bank_name":"Apple Inc.","property_name":"","company_name":"","investment_type":"Shares","broker_advisor":"","first_holder":"MUKESH JINDAL (Added by Self)","current_value":24004.51,"deleted_on":"","is_active":"1"},{"quantity":"1","id":"30665","user_id":"500","it_id":"12","asset_class":"Debt","scheme_bank_name":"ICICI","property_name":"","company_name":"","investment_type":"Bank Balance","broker_advisor":"","first_holder":"MUKESH JINDAL (Added by Self)","current_value":"10000000","deleted_on":"","is_active":"1"}]
/// count : "2"
/// success : 1

class AssetListResponseModel {
  AssetListResponseModel({
      List<Assets>? assets,
      String? count,
      num? success,}){
    _assets = assets;
    _count = count;
    _success = success;
}

  AssetListResponseModel.fromJson(dynamic json) {
    if (json['assets'] != null) {
      _assets = [];
      json['assets'].forEach((v) {
        _assets?.add(Assets.fromJson(v));
      });
    }
    _count = json['count'];
    _success = json['success'];
  }
  List<Assets>? _assets;
  String? _count;
  num? _success;
AssetListResponseModel copyWith({  List<Assets>? assets,
  String? count,
  num? success,
}) => AssetListResponseModel(  assets: assets ?? _assets,
  count: count ?? _count,
  success: success ?? _success,
);
  List<Assets>? get assets => _assets;
  String? get count => _count;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_assets != null) {
      map['assets'] = _assets?.map((v) => v.toJson()).toList();
    }
    map['count'] = _count;
    map['success'] = _success;
    return map;
  }

}

/// quantity : "1"
/// id : "27596"
/// user_id : "500"
/// it_id : "1"
/// asset_class : "Equity"
/// scheme_bank_name : "Apple Inc."
/// property_name : ""
/// company_name : ""
/// investment_type : "Shares"
/// broker_advisor : ""
/// first_holder : "MUKESH JINDAL (Added by Self)"
/// current_value : 24004.51
/// deleted_on : ""
/// is_active : "1"

class Assets {
  Assets({
      String? quantity,
      String? id,
      String? userId,
      String? itId,
      String? assetClass,
      String? schemeBankName,
      String? propertyName,
      String? companyName,
      String? investmentType,
      String? brokerAdvisor,
      String? firstHolder,
      num? currentValue,
      String? deletedOn,
      String? isActive,}){
    _quantity = quantity;
    _id = id;
    _userId = userId;
    _itId = itId;
    _assetClass = assetClass;
    _schemeBankName = schemeBankName;
    _propertyName = propertyName;
    _companyName = companyName;
    _investmentType = investmentType;
    _brokerAdvisor = brokerAdvisor;
    _firstHolder = firstHolder;
    _currentValue = currentValue;
    _deletedOn = deletedOn;
    _isActive = isActive;
}

  Assets.fromJson(dynamic json) {
    _quantity = json['quantity'];
    _id = json['id'];
    _userId = json['user_id'];
    _itId = json['it_id'];
    _assetClass = json['asset_class'];
    _schemeBankName = json['scheme_bank_name'];
    _propertyName = json['property_name'];
    _companyName = json['company_name'];
    _investmentType = json['investment_type'];
    _brokerAdvisor = json['broker_advisor'];
    _firstHolder = json['first_holder'];
    _currentValue = json['current_value'] is String ? num.tryParse(json['current_value']) : json['current_value'];
    _deletedOn = json['deleted_on'];
    _isActive = json['is_active'];
  }
  String? _quantity;
  String? _id;
  String? _userId;
  String? _itId;
  String? _assetClass;
  String? _schemeBankName;
  String? _propertyName;
  String? _companyName;
  String? _investmentType;
  String? _brokerAdvisor;
  String? _firstHolder;
  num? _currentValue;
  String? _deletedOn;
  String? _isActive;
Assets copyWith({  String? quantity,
  String? id,
  String? userId,
  String? itId,
  String? assetClass,
  String? schemeBankName,
  String? propertyName,
  String? companyName,
  String? investmentType,
  String? brokerAdvisor,
  String? firstHolder,
  num? currentValue,
  String? deletedOn,
  String? isActive,
}) => Assets(  quantity: quantity ?? _quantity,
  id: id ?? _id,
  userId: userId ?? _userId,
  itId: itId ?? _itId,
  assetClass: assetClass ?? _assetClass,
  schemeBankName: schemeBankName ?? _schemeBankName,
  propertyName: propertyName ?? _propertyName,
  companyName: companyName ?? _companyName,
  investmentType: investmentType ?? _investmentType,
  brokerAdvisor: brokerAdvisor ?? _brokerAdvisor,
  firstHolder: firstHolder ?? _firstHolder,
  currentValue: currentValue ?? _currentValue,
  deletedOn: deletedOn ?? _deletedOn,
  isActive: isActive ?? _isActive,
);
  String? get quantity => _quantity;
  String? get id => _id;
  String? get userId => _userId;
  String? get itId => _itId;
  String? get assetClass => _assetClass;
  String? get schemeBankName => _schemeBankName;
  String? get propertyName => _propertyName;
  String? get companyName => _companyName;
  String? get investmentType => _investmentType;
  String? get brokerAdvisor => _brokerAdvisor;
  String? get firstHolder => _firstHolder;
  num? get currentValue => _currentValue;
  String? get deletedOn => _deletedOn;
  String? get isActive => _isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quantity'] = _quantity;
    map['id'] = _id;
    map['user_id'] = _userId;
    map['it_id'] = _itId;
    map['asset_class'] = _assetClass;
    map['scheme_bank_name'] = _schemeBankName;
    map['property_name'] = _propertyName;
    map['company_name'] = _companyName;
    map['investment_type'] = _investmentType;
    map['broker_advisor'] = _brokerAdvisor;
    map['first_holder'] = _firstHolder;
    map['current_value'] = _currentValue;
    map['deleted_on'] = _deletedOn;
    map['is_active'] = _isActive;
    return map;
  }

}