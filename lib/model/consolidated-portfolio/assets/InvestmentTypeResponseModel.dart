import 'dart:convert';
/// investment_type_list : [{"it_id":"1","name":"Shares","is_active":"1"},{"it_id":"2","name":"Mutual Funds","is_active":"1"},{"it_id":"3","name":"PMS","is_active":"1"},{"it_id":"4","name":"AIF","is_active":"1"},{"it_id":"5","name":"Gold","is_active":"1"},{"it_id":"6","name":"Silver","is_active":"1"},{"it_id":"7","name":"Commodities","is_active":"1"},{"it_id":"8","name":"Private Equity","is_active":"1"},{"it_id":"9","name":"Hedge Fund","is_active":"1"},{"it_id":"10","name":"Art","is_active":"1"},{"it_id":"11","name":"Others - Alternate","is_active":"1"},{"it_id":"12","name":"Bank Balance","is_active":"1"},{"it_id":"13","name":"Fixed Deposit","is_active":"1"},{"it_id":"14","name":"Company Deposit","is_active":"1"},{"it_id":"15","name":"NSC/ KVP","is_active":"1"},{"it_id":"16","name":"PPF","is_active":"1"},{"it_id":"17","name":"EPF","is_active":"1"},{"it_id":"18","name":"Taxable Bonds","is_active":"1"},{"it_id":"19","name":"Tax Free Bonds","is_active":"1"},{"it_id":"20","name":"Super Annuation Fund","is_active":"1"},{"it_id":"21","name":"NPS","is_active":"1"},{"it_id":"22","name":"Others - Debt","is_active":"1"},{"it_id":"23","name":"Residence","is_active":"1"},{"it_id":"24","name":"Residential Property","is_active":"1"},{"it_id":"25","name":"Commercial Property","is_active":"1"},{"it_id":"26","name":"Land","is_active":"1"},{"it_id":"27","name":"Real Estate Fund","is_active":"1"},{"it_id":"28","name":"Others - Real Estate","is_active":"1"},{"it_id":"29","name":"Insurance","is_active":"1"},{"it_id":"30","name":"Ulip","is_active":"1"},{"it_id":"31","name":"Endowment","is_active":"1"},{"it_id":"32","name":"Pension Plan","is_active":"1"},{"it_id":"33","name":"Loan Given","is_active":"1"},{"it_id":"34","name":"Stock Options","is_active":"1"},{"it_id":"35","name":"Loan Taken","is_active":"1"},{"it_id":"36","name":"Others - Equity","is_active":"1"},{"it_id":"37","name":"Crypto Currency","is_active":"1"}]
/// success : 1

InvestmentTypeResponseModel investmentTypeResponseModelFromJson(String str) => InvestmentTypeResponseModel.fromJson(json.decode(str));
String investmentTypeResponseModelToJson(InvestmentTypeResponseModel data) => json.encode(data.toJson());
class InvestmentTypeResponseModel {
  InvestmentTypeResponseModel({
      List<InvestmentTypeList>? investmentTypeList, 
      num? success,}){
    _investmentTypeList = investmentTypeList;
    _success = success;
}

  InvestmentTypeResponseModel.fromJson(dynamic json) {
    if (json['investment_type_list'] != null) {
      _investmentTypeList = [];
      json['investment_type_list'].forEach((v) {
        _investmentTypeList?.add(InvestmentTypeList.fromJson(v));
      });
    }
    _success = json['success'];
  }
  List<InvestmentTypeList>? _investmentTypeList;
  num? _success;
InvestmentTypeResponseModel copyWith({  List<InvestmentTypeList>? investmentTypeList,
  num? success,
}) => InvestmentTypeResponseModel(  investmentTypeList: investmentTypeList ?? _investmentTypeList,
  success: success ?? _success,
);
  List<InvestmentTypeList>? get investmentTypeList => _investmentTypeList;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_investmentTypeList != null) {
      map['investment_type_list'] = _investmentTypeList?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    return map;
  }

}

/// it_id : "1"
/// name : "Shares"
/// is_active : "1"

InvestmentTypeList investmentTypeListFromJson(String str) => InvestmentTypeList.fromJson(json.decode(str));
String investmentTypeListToJson(InvestmentTypeList data) => json.encode(data.toJson());
class InvestmentTypeList {
  InvestmentTypeList({
      String? itId, 
      String? name, 
      String? isActive,}){
    _itId = itId;
    _name = name;
    _isActive = isActive;
}

  InvestmentTypeList.fromJson(dynamic json) {
    _itId = json['it_id'];
    _name = json['name'];
    _isActive = json['is_active'];
  }
  String? _itId;
  String? _name;
  String? _isActive;
InvestmentTypeList copyWith({  String? itId,
  String? name,
  String? isActive,
}) => InvestmentTypeList(  itId: itId ?? _itId,
  name: name ?? _name,
  isActive: isActive ?? _isActive,
);
  String? get itId => _itId;
  String? get name => _name;
  String? get isActive => _isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['it_id'] = _itId;
    map['name'] = _name;
    map['is_active'] = _isActive;
    return map;
  }

}