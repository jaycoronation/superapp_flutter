import 'dart:convert';
/// aspirations : {"listData":[{"aspiration_id":"116","user_id":"26","start_year":"2023","end_year":"2030","periodicity":"5","amount":"2000","aspiration_type":"Retirement","classification":"Living","other_aspiration":"","total_outflow":"4000","total_inflation_adjusted_expense":"4676","wealth_required_today_total":"3662","volatile_component":"23%","target_return":"9%"},{"aspiration_id":"128","user_id":"26","start_year":"2024","end_year":"2030","periodicity":"5","amount":"5000","aspiration_type":"Vacation With Family","classification":"Lifestyle","other_aspiration":"","total_outflow":"5000","total_inflation_adjusted_expense":"6691","wealth_required_today_total":"4155","volatile_component":"50%","target_return":"10%"},{"aspiration_id":"129","user_id":"26","start_year":"2024","end_year":"2030","periodicity":"5","amount":"5500","aspiration_type":"Rent","classification":"Lifestyle","other_aspiration":"","total_outflow":"5500","total_inflation_adjusted_expense":"7360","wealth_required_today_total":"4570","volatile_component":"50%","target_return":"11%"}],"total":{"aspiration_type":"Total","total_outflow":"14500","total_inflation_adjusted_expense":"18727","wealth_required_today_total":"12387","volatile_component":"42%","target_return":"10%"}}
/// message : "Aspirations found..."
/// success : 1

AspirationResponseModel aspirationResponseModelFromJson(String str) => AspirationResponseModel.fromJson(json.decode(str));
String aspirationResponseModelToJson(AspirationResponseModel data) => json.encode(data.toJson());
class AspirationResponseModel {
  AspirationResponseModel({
      Aspirations? aspirations, 
      String? message, 
      num? success,}){
    _aspirations = aspirations;
    _message = message;
    _success = success;
}

  AspirationResponseModel.fromJson(dynamic json) {
    _aspirations = json['aspirations'] != null ? Aspirations.fromJson(json['aspirations']) : null;
    _message = json['message'];
    _success = json['success'];
  }
  Aspirations? _aspirations;
  String? _message;
  num? _success;
AspirationResponseModel copyWith({  Aspirations? aspirations,
  String? message,
  num? success,
}) => AspirationResponseModel(  aspirations: aspirations ?? _aspirations,
  message: message ?? _message,
  success: success ?? _success,
);
  Aspirations? get aspirations => _aspirations;
  String? get message => _message;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_aspirations != null) {
      map['aspirations'] = _aspirations?.toJson();
    }
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// listData : [{"aspiration_id":"116","user_id":"26","start_year":"2023","end_year":"2030","periodicity":"5","amount":"2000","aspiration_type":"Retirement","classification":"Living","other_aspiration":"","total_outflow":"4000","total_inflation_adjusted_expense":"4676","wealth_required_today_total":"3662","volatile_component":"23%","target_return":"9%"},{"aspiration_id":"128","user_id":"26","start_year":"2024","end_year":"2030","periodicity":"5","amount":"5000","aspiration_type":"Vacation With Family","classification":"Lifestyle","other_aspiration":"","total_outflow":"5000","total_inflation_adjusted_expense":"6691","wealth_required_today_total":"4155","volatile_component":"50%","target_return":"10%"},{"aspiration_id":"129","user_id":"26","start_year":"2024","end_year":"2030","periodicity":"5","amount":"5500","aspiration_type":"Rent","classification":"Lifestyle","other_aspiration":"","total_outflow":"5500","total_inflation_adjusted_expense":"7360","wealth_required_today_total":"4570","volatile_component":"50%","target_return":"11%"}]
/// total : {"aspiration_type":"Total","total_outflow":"14500","total_inflation_adjusted_expense":"18727","wealth_required_today_total":"12387","volatile_component":"42%","target_return":"10%"}

Aspirations aspirationsFromJson(String str) => Aspirations.fromJson(json.decode(str));
String aspirationsToJson(Aspirations data) => json.encode(data.toJson());
class Aspirations {
  Aspirations({
      List<ListData>? listData, 
      Total? total,}){
    _listData = listData;
    _total = total;
}

  Aspirations.fromJson(dynamic json) {
    if (json['list'] != null) {
      _listData = [];
      json['list'].forEach((v) {
        _listData?.add(ListData.fromJson(v));
      });
    }
    _total = json['total'] != null ? Total.fromJson(json['total']) : null;
  }
  List<ListData>? _listData;
  Total? _total;
Aspirations copyWith({  List<ListData>? listData,
  Total? total,
}) => Aspirations(  listData: listData ?? _listData,
  total: total ?? _total,
);
  List<ListData>? get listData => _listData;
  Total? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_listData != null) {
      map['list'] = _listData?.map((v) => v.toJson()).toList();
    }
    if (_total != null) {
      map['total'] = _total?.toJson();
    }
    return map;
  }

}

/// aspiration_type : "Total"
/// total_outflow : "14500"
/// total_inflation_adjusted_expense : "18727"
/// wealth_required_today_total : "12387"
/// volatile_component : "42%"
/// target_return : "10%"

Total totalFromJson(String str) => Total.fromJson(json.decode(str));
String totalToJson(Total data) => json.encode(data.toJson());
class Total {
  Total({
      String? aspirationType, 
      String? totalOutflow, 
      String? totalInflationAdjustedExpense, 
      String? wealthRequiredTodayTotal, 
      String? volatileComponent, 
      String? targetReturn,}){
    _aspirationType = aspirationType;
    _totalOutflow = totalOutflow;
    _totalInflationAdjustedExpense = totalInflationAdjustedExpense;
    _wealthRequiredTodayTotal = wealthRequiredTodayTotal;
    _volatileComponent = volatileComponent;
    _targetReturn = targetReturn;
}

  Total.fromJson(dynamic json) {
    _aspirationType = json['aspiration_type'];
    _totalOutflow = json['total_outflow'];
    _totalInflationAdjustedExpense = json['total_inflation_adjusted_expense'];
    _wealthRequiredTodayTotal = json['wealth_required_today_total'];
    _volatileComponent = json['volatile_component'];
    _targetReturn = json['target_return'];
  }
  String? _aspirationType;
  String? _totalOutflow;
  String? _totalInflationAdjustedExpense;
  String? _wealthRequiredTodayTotal;
  String? _volatileComponent;
  String? _targetReturn;
Total copyWith({  String? aspirationType,
  String? totalOutflow,
  String? totalInflationAdjustedExpense,
  String? wealthRequiredTodayTotal,
  String? volatileComponent,
  String? targetReturn,
}) => Total(  aspirationType: aspirationType ?? _aspirationType,
  totalOutflow: totalOutflow ?? _totalOutflow,
  totalInflationAdjustedExpense: totalInflationAdjustedExpense ?? _totalInflationAdjustedExpense,
  wealthRequiredTodayTotal: wealthRequiredTodayTotal ?? _wealthRequiredTodayTotal,
  volatileComponent: volatileComponent ?? _volatileComponent,
  targetReturn: targetReturn ?? _targetReturn,
);
  String? get aspirationType => _aspirationType;
  String? get totalOutflow => _totalOutflow;
  String? get totalInflationAdjustedExpense => _totalInflationAdjustedExpense;
  String? get wealthRequiredTodayTotal => _wealthRequiredTodayTotal;
  String? get volatileComponent => _volatileComponent;
  String? get targetReturn => _targetReturn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aspiration_type'] = _aspirationType;
    map['total_outflow'] = _totalOutflow;
    map['total_inflation_adjusted_expense'] = _totalInflationAdjustedExpense;
    map['wealth_required_today_total'] = _wealthRequiredTodayTotal;
    map['volatile_component'] = _volatileComponent;
    map['target_return'] = _targetReturn;
    return map;
  }

}

/// aspiration_id : "116"
/// user_id : "26"
/// start_year : "2023"
/// end_year : "2030"
/// periodicity : "5"
/// amount : "2000"
/// aspiration_type : "Retirement"
/// classification : "Living"
/// other_aspiration : ""
/// total_outflow : "4000"
/// total_inflation_adjusted_expense : "4676"
/// wealth_required_today_total : "3662"
/// volatile_component : "23%"
/// target_return : "9%"

ListData listDataFromJson(String str) => ListData.fromJson(json.decode(str));
String listDataToJson(ListData data) => json.encode(data.toJson());
class ListData {
  ListData({
      String? aspirationId, 
      String? userId, 
      String? startYear, 
      String? endYear, 
      String? periodicity, 
      String? amount, 
      String? aspirationType, 
      String? classification, 
      String? otherAspiration, 
      String? totalOutflow, 
      String? totalInflationAdjustedExpense, 
      String? wealthRequiredTodayTotal, 
      String? volatileComponent, 
      String? targetReturn,}){
    _aspirationId = aspirationId;
    _userId = userId;
    _startYear = startYear;
    _endYear = endYear;
    _periodicity = periodicity;
    _amount = amount;
    _aspirationType = aspirationType;
    _classification = classification;
    _otherAspiration = otherAspiration;
    _totalOutflow = totalOutflow;
    _totalInflationAdjustedExpense = totalInflationAdjustedExpense;
    _wealthRequiredTodayTotal = wealthRequiredTodayTotal;
    _volatileComponent = volatileComponent;
    _targetReturn = targetReturn;
}

  ListData.fromJson(dynamic json) {
    _aspirationId = json['aspiration_id'];
    _userId = json['user_id'];
    _startYear = json['start_year'];
    _endYear = json['end_year'];
    _periodicity = json['periodicity'];
    _amount = json['amount'];
    _aspirationType = json['aspiration_type'];
    _classification = json['classification'];
    _otherAspiration = json['other_aspiration'];
    _totalOutflow = json['total_outflow'];
    _totalInflationAdjustedExpense = json['total_inflation_adjusted_expense'];
    _wealthRequiredTodayTotal = json['wealth_required_today_total'];
    _volatileComponent = json['volatile_component'];
    _targetReturn = json['target_return'];
  }
  String? _aspirationId;
  String? _userId;
  String? _startYear;
  String? _endYear;
  String? _periodicity;
  String? _amount;
  String? _aspirationType;
  String? _classification;
  String? _otherAspiration;
  String? _totalOutflow;
  String? _totalInflationAdjustedExpense;
  String? _wealthRequiredTodayTotal;
  String? _volatileComponent;
  String? _targetReturn;
ListData copyWith({  String? aspirationId,
  String? userId,
  String? startYear,
  String? endYear,
  String? periodicity,
  String? amount,
  String? aspirationType,
  String? classification,
  String? otherAspiration,
  String? totalOutflow,
  String? totalInflationAdjustedExpense,
  String? wealthRequiredTodayTotal,
  String? volatileComponent,
  String? targetReturn,
}) => ListData(  aspirationId: aspirationId ?? _aspirationId,
  userId: userId ?? _userId,
  startYear: startYear ?? _startYear,
  endYear: endYear ?? _endYear,
  periodicity: periodicity ?? _periodicity,
  amount: amount ?? _amount,
  aspirationType: aspirationType ?? _aspirationType,
  classification: classification ?? _classification,
  otherAspiration: otherAspiration ?? _otherAspiration,
  totalOutflow: totalOutflow ?? _totalOutflow,
  totalInflationAdjustedExpense: totalInflationAdjustedExpense ?? _totalInflationAdjustedExpense,
  wealthRequiredTodayTotal: wealthRequiredTodayTotal ?? _wealthRequiredTodayTotal,
  volatileComponent: volatileComponent ?? _volatileComponent,
  targetReturn: targetReturn ?? _targetReturn,
);
  String? get aspirationId => _aspirationId;
  String? get userId => _userId;
  String? get startYear => _startYear;
  String? get endYear => _endYear;
  String? get periodicity => _periodicity;
  String? get amount => _amount;
  String? get aspirationType => _aspirationType;
  String? get classification => _classification;
  String? get otherAspiration => _otherAspiration;
  String? get totalOutflow => _totalOutflow;
  String? get totalInflationAdjustedExpense => _totalInflationAdjustedExpense;
  String? get wealthRequiredTodayTotal => _wealthRequiredTodayTotal;
  String? get volatileComponent => _volatileComponent;
  String? get targetReturn => _targetReturn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aspiration_id'] = _aspirationId;
    map['user_id'] = _userId;
    map['start_year'] = _startYear;
    map['end_year'] = _endYear;
    map['periodicity'] = _periodicity;
    map['amount'] = _amount;
    map['aspiration_type'] = _aspirationType;
    map['classification'] = _classification;
    map['other_aspiration'] = _otherAspiration;
    map['total_outflow'] = _totalOutflow;
    map['total_inflation_adjusted_expense'] = _totalInflationAdjustedExpense;
    map['wealth_required_today_total'] = _wealthRequiredTodayTotal;
    map['volatile_component'] = _volatileComponent;
    map['target_return'] = _targetReturn;
    return map;
  }

}