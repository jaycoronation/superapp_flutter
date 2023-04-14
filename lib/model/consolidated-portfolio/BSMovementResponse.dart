/// graph_data : [{"Hybrid":"2996805","Equity":"5642062","Debt":"7122895","timestamp":"31.12.2021","total":15761762}]
/// sheet_data : [{"Hybrid":"2996805","Equity":"5642062","Debt":"7122895","timestamp":"31.12.2021","total":15761762,"in_out_flow":0,"movement":0,"profite":0}]
/// success : 1
/// goldFlag : 0
/// othersFlag : 0
/// realEstateFlag : 0
/// solutionFlag : 0
/// debtFdFlag : 0
/// hybridFlag : 1
/// equityFlag : 1
/// debtFlag : 1

class BsMovementResponse {
  BsMovementResponse({
      List<GraphData>? graphData, 
      List<SheetData>? sheetData, 
      num? success, 
      num? goldFlag, 
      num? othersFlag, 
      num? realEstateFlag, 
      num? solutionFlag, 
      num? debtFdFlag, 
      num? hybridFlag, 
      num? equityFlag, 
      num? debtFlag,}){
    _graphData = graphData;
    _sheetData = sheetData;
    _success = success;
    _goldFlag = goldFlag;
    _othersFlag = othersFlag;
    _realEstateFlag = realEstateFlag;
    _solutionFlag = solutionFlag;
    _debtFdFlag = debtFdFlag;
    _hybridFlag = hybridFlag;
    _equityFlag = equityFlag;
    _debtFlag = debtFlag;
}

  BsMovementResponse.fromJson(dynamic json) {
    if (json['graph_data'] != null) {
      _graphData = [];
      json['graph_data'].forEach((v) {
        _graphData?.add(GraphData.fromJson(v));
      });
    }
    if (json['sheet_data'] != null) {
      _sheetData = [];
      json['sheet_data'].forEach((v) {
        _sheetData?.add(SheetData.fromJson(v));
      });
    }
    _success = json['success'];
    _goldFlag = json['goldFlag'];
    _othersFlag = json['othersFlag'];
    _realEstateFlag = json['realEstateFlag'];
    _solutionFlag = json['solutionFlag'];
    _debtFdFlag = json['debtFdFlag'];
    _hybridFlag = json['hybridFlag'];
    _equityFlag = json['equityFlag'];
    _debtFlag = json['debtFlag'];
  }
  List<GraphData>? _graphData;
  List<SheetData>? _sheetData;
  num? _success;
  num? _goldFlag;
  num? _othersFlag;
  num? _realEstateFlag;
  num? _solutionFlag;
  num? _debtFdFlag;
  num? _hybridFlag;
  num? _equityFlag;
  num? _debtFlag;
BsMovementResponse copyWith({  List<GraphData>? graphData,
  List<SheetData>? sheetData,
  num? success,
  num? goldFlag,
  num? othersFlag,
  num? realEstateFlag,
  num? solutionFlag,
  num? debtFdFlag,
  num? hybridFlag,
  num? equityFlag,
  num? debtFlag,
}) => BsMovementResponse(  graphData: graphData ?? _graphData,
  sheetData: sheetData ?? _sheetData,
  success: success ?? _success,
  goldFlag: goldFlag ?? _goldFlag,
  othersFlag: othersFlag ?? _othersFlag,
  realEstateFlag: realEstateFlag ?? _realEstateFlag,
  solutionFlag: solutionFlag ?? _solutionFlag,
  debtFdFlag: debtFdFlag ?? _debtFdFlag,
  hybridFlag: hybridFlag ?? _hybridFlag,
  equityFlag: equityFlag ?? _equityFlag,
  debtFlag: debtFlag ?? _debtFlag,
);
  List<GraphData>? get graphData => _graphData;
  List<SheetData>? get sheetData => _sheetData;
  num? get success => _success;
  num? get goldFlag => _goldFlag;
  num? get othersFlag => _othersFlag;
  num? get realEstateFlag => _realEstateFlag;
  num? get solutionFlag => _solutionFlag;
  num? get debtFdFlag => _debtFdFlag;
  num? get hybridFlag => _hybridFlag;
  num? get equityFlag => _equityFlag;
  num? get debtFlag => _debtFlag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_graphData != null) {
      map['graph_data'] = _graphData?.map((v) => v.toJson()).toList();
    }
    if (_sheetData != null) {
      map['sheet_data'] = _sheetData?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['goldFlag'] = _goldFlag;
    map['othersFlag'] = _othersFlag;
    map['realEstateFlag'] = _realEstateFlag;
    map['solutionFlag'] = _solutionFlag;
    map['debtFdFlag'] = _debtFdFlag;
    map['hybridFlag'] = _hybridFlag;
    map['equityFlag'] = _equityFlag;
    map['debtFlag'] = _debtFlag;
    return map;
  }

}

/// Hybrid : "2996805"
/// Equity : "5642062"
/// Debt : "7122895"
/// timestamp : "31.12.2021"
/// total : 15761762
/// in_out_flow : 0
/// movement : 0
/// profite : 0

class SheetData {
  SheetData({
      String? hybrid, 
      String? equity, 
      String? debt, 
      String? timestamp, 
      num? total, 
      num? inOutFlow, 
      num? movement, 
      num? profite,}){
    _hybrid = hybrid;
    _equity = equity;
    _debt = debt;
    _timestamp = timestamp;
    _total = total;
    _inOutFlow = inOutFlow;
    _movement = movement;
    _profite = profite;
}

  SheetData.fromJson(dynamic json) {
    _hybrid = json['Hybrid'];
    _equity = json['Equity'];
    _debt = json['Debt'];
    _timestamp = json['timestamp'];
    _total = json['total'];
    _inOutFlow = json['in_out_flow'];
    _movement = json['movement'];
    _profite = json['profite'];
  }
  String? _hybrid;
  String? _equity;
  String? _debt;
  String? _timestamp;
  num? _total;
  num? _inOutFlow;
  num? _movement;
  num? _profite;
SheetData copyWith({  String? hybrid,
  String? equity,
  String? debt,
  String? timestamp,
  num? total,
  num? inOutFlow,
  num? movement,
  num? profite,
}) => SheetData(  hybrid: hybrid ?? _hybrid,
  equity: equity ?? _equity,
  debt: debt ?? _debt,
  timestamp: timestamp ?? _timestamp,
  total: total ?? _total,
  inOutFlow: inOutFlow ?? _inOutFlow,
  movement: movement ?? _movement,
  profite: profite ?? _profite,
);
  String? get hybrid => _hybrid;
  String? get equity => _equity;
  String? get debt => _debt;
  String? get timestamp => _timestamp;
  num? get total => _total;
  num? get inOutFlow => _inOutFlow;
  num? get movement => _movement;
  num? get profite => _profite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Hybrid'] = _hybrid;
    map['Equity'] = _equity;
    map['Debt'] = _debt;
    map['timestamp'] = _timestamp;
    map['total'] = _total;
    map['in_out_flow'] = _inOutFlow;
    map['movement'] = _movement;
    map['profite'] = _profite;
    return map;
  }

}

/// Hybrid : "2996805"
/// Equity : "5642062"
/// Debt : "7122895"
/// timestamp : "31.12.2021"
/// total : 15761762

class GraphData {
  GraphData({
      String? hybrid, 
      String? equity, 
      String? debt, 
      String? timestamp, 
      num? total,}){
    _hybrid = hybrid;
    _equity = equity;
    _debt = debt;
    _timestamp = timestamp;
    _total = total;
}

  GraphData.fromJson(dynamic json) {
    _hybrid = json['Hybrid'];
    _equity = json['Equity'];
    _debt = json['Debt'];
    _timestamp = json['timestamp'];
    _total = json['total'];
  }
  String? _hybrid;
  String? _equity;
  String? _debt;
  String? _timestamp;
  num? _total;
GraphData copyWith({  String? hybrid,
  String? equity,
  String? debt,
  String? timestamp,
  num? total,
}) => GraphData(  hybrid: hybrid ?? _hybrid,
  equity: equity ?? _equity,
  debt: debt ?? _debt,
  timestamp: timestamp ?? _timestamp,
  total: total ?? _total,
);
  String? get hybrid => _hybrid;
  String? get equity => _equity;
  String? get debt => _debt;
  String? get timestamp => _timestamp;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Hybrid'] = _hybrid;
    map['Equity'] = _equity;
    map['Debt'] = _debt;
    map['timestamp'] = _timestamp;
    map['total'] = _total;
    return map;
  }

}