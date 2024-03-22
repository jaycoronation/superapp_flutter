import 'dart:convert';
/// graph_data : [{"Hybrid":749371,"Equity":51357245,"Debt":6592722,"Gold":45966,"Others":0,"timestamp":"31.03.2022","total":58745304},{"Hybrid":736248,"Equity":49681250,"Debt":8116246,"Gold":46739,"Others":0,"timestamp":"30.04.2022","total":58580483},{"Hybrid":712279,"Equity":47420038,"Debt":9962922,"Gold":45816,"Others":0,"timestamp":"31.05.2022","total":58141055},{"Hybrid":686053,"Equity":45866177,"Debt":10762006,"Gold":45686,"Others":0,"timestamp":"30.06.2022","total":57359922},{"Hybrid":735366,"Equity":49710349,"Debt":11331791,"Gold":45778,"Others":0,"timestamp":"31.07.2022","total":61823284},{"Hybrid":754826,"Equity":51396237,"Debt":10708492,"Gold":45760,"Others":0,"timestamp":"31.08.2022","total":62905315},{"Hybrid":737975,"Equity":50411053,"Debt":10907534,"Gold":44618,"Others":0,"timestamp":"30.09.2022","total":62101180},{"Hybrid":756394,"Equity":52432122,"Debt":11168155.63,"Gold":44961,"Others":0,"timestamp":"31.10.2022","total":64401632.63},{"Hybrid":766695,"Equity":55176748,"Debt":11233944.63,"Gold":46860,"Others":0,"timestamp":"30.11.2022","total":67224247.63},{"Hybrid":757433,"Equity":55005051,"Debt":11288175.63,"Gold":48784,"Others":0,"timestamp":"31.12.2022","total":67099443.63},{"Hybrid":741213,"Equity":53438773,"Debt":11337081.63,"Gold":50651,"Others":1657483,"timestamp":"31.01.2023","total":67225201.63},{"Hybrid":746125,"Equity":54303915,"Debt":11401165.63,"Gold":49457,"Others":1704634,"timestamp":"28.02.2023","total":68205296.63},{"Hybrid":739843,"Equity":56251647,"Debt":11071433.63,"Gold":52600,"Others":0,"timestamp":"31.03.2023","total":68115523.63},{"Hybrid":767586,"Equity":59306563,"Debt":11152911,"Gold":53216,"Others":0,"timestamp":"30.04.2023","total":71280276},{"Hybrid":797132,"Equity":63240722,"Debt":11226343,"Gold":53132,"Others":0,"timestamp":"31.05.2023","total":75317329},{"Hybrid":824274,"Equity":66893332,"Debt":11891805,"Gold":51191,"Others":0,"timestamp":"30.06.2023","total":79660602},{"Hybrid":6405185,"Equity":84967068,"Debt":12867257,"Gold":52573,"Others":0,"timestamp":"31.07.2023","total":104292083},{"Hybrid":6429544,"Equity":87887361,"Debt":12521001,"Gold":52441,"Others":0,"timestamp":"31.08.2023","total":106890347},{"Hybrid":6493926,"Equity":88605286,"Debt":9953888,"Gold":51109,"Others":0,"timestamp":"30.09.2023","total":105104209},{"Hybrid":6463099,"Equity":87088368,"Debt":12553397,"Gold":54009,"Others":0,"timestamp":"31.10.2023","total":106158873},{"Hybrid":6608257,"Equity":102907250,"Debt":5705481,"Gold":65392,"Others":0,"timestamp":"30.11.2023","total":115286380},{"Hybrid":6768003,"Equity":112008234,"Debt":5306900,"Gold":66144,"Others":0,"timestamp":"31.12.2023","total":124149281},{"Hybrid":6856864,"Equity":116760169,"Debt":5201264,"Gold":65399,"Others":0,"timestamp":"31.01.2024","total":128883696},{"Hybrid":942584,"Equity":129534056,"Debt":2664193,"Gold":69758,"Others":0,"timestamp":"20.03.2024","total":133210591}]
/// sheet_data : [{"Hybrid":749371,"Equity":51357245,"Debt":6592722,"Gold":45966,"Others":0,"timestamp":"31.03.2022","total":58745304,"in_out_flow":0,"movement":0,"profite":0},{"Hybrid":736248,"Equity":49681250,"Debt":8116246,"Gold":46739,"Others":0,"timestamp":"30.04.2022","total":58580483,"movement":-164821},{"Hybrid":712279,"Equity":47420038,"Debt":9962922,"Gold":45816,"Others":0,"timestamp":"31.05.2022","total":58141055,"movement":-439428},{"Hybrid":686053,"Equity":45866177,"Debt":10762006,"Gold":45686,"Others":0,"timestamp":"30.06.2022","total":57359922,"movement":-781133},{"Hybrid":735366,"Equity":49710349,"Debt":11331791,"Gold":45778,"Others":0,"timestamp":"31.07.2022","total":61823284,"movement":4463362},{"Hybrid":754826,"Equity":51396237,"Debt":10708492,"Gold":45760,"Others":0,"timestamp":"31.08.2022","total":62905315,"movement":1082031},{"Hybrid":737975,"Equity":50411053,"Debt":10907534,"Gold":44618,"Others":0,"timestamp":"30.09.2022","total":62101180,"movement":-804135},{"Hybrid":756394,"Equity":52432122,"Debt":11168155.63,"Gold":44961,"Others":0,"timestamp":"31.10.2022","total":64401632.63,"movement":2300452.63},{"Hybrid":766695,"Equity":55176748,"Debt":11233944.63,"Gold":46860,"Others":0,"timestamp":"30.11.2022","total":67224247.63,"movement":2822615},{"Hybrid":757433,"Equity":55005051,"Debt":11288175.63,"Gold":48784,"Others":0,"timestamp":"31.12.2022","total":67099443.63,"movement":-124803.99999999},{"Hybrid":741213,"Equity":53438773,"Debt":11337081.63,"Gold":50651,"Others":1657483,"timestamp":"31.01.2023","total":67225201.63,"movement":125757.99999999},{"Hybrid":746125,"Equity":54303915,"Debt":11401165.63,"Gold":49457,"Others":1704634,"timestamp":"28.02.2023","total":68205296.63,"movement":980095},{"Hybrid":739843,"Equity":56251647,"Debt":11071433.63,"Gold":52600,"Others":0,"timestamp":"31.03.2023","total":68115523.63,"movement":-89773},{"Hybrid":767586,"Equity":59306563,"Debt":11152911,"Gold":53216,"Others":0,"timestamp":"30.04.2023","total":71280276,"movement":3164752.37},{"Hybrid":797132,"Equity":63240722,"Debt":11226343,"Gold":53132,"Others":0,"timestamp":"31.05.2023","total":75317329,"movement":4037053},{"Hybrid":824274,"Equity":66893332,"Debt":11891805,"Gold":51191,"Others":0,"timestamp":"30.06.2023","total":79660602,"movement":4343273},{"Hybrid":6405185,"Equity":84967068,"Debt":12867257,"Gold":52573,"Others":0,"timestamp":"31.07.2023","total":104292083,"movement":24631481},{"Hybrid":6429544,"Equity":87887361,"Debt":12521001,"Gold":52441,"Others":0,"timestamp":"31.08.2023","total":106890347,"movement":2598264},{"Hybrid":6493926,"Equity":88605286,"Debt":9953888,"Gold":51109,"Others":0,"timestamp":"30.09.2023","total":105104209,"movement":-1786138},{"Hybrid":6463099,"Equity":87088368,"Debt":12553397,"Gold":54009,"Others":0,"timestamp":"31.10.2023","total":106158873,"movement":1054664},{"Hybrid":6608257,"Equity":102907250,"Debt":5705481,"Gold":65392,"Others":0,"timestamp":"30.11.2023","total":115286380,"movement":9127507},{"Hybrid":6768003,"Equity":112008234,"Debt":5306900,"Gold":66144,"Others":0,"timestamp":"31.12.2023","total":124149281,"movement":8862901},{"Hybrid":6856864,"Equity":116760169,"Debt":5201264,"Gold":65399,"Others":0,"timestamp":"31.01.2024","total":128883696,"movement":4734415},{"Hybrid":942584,"Equity":129534056,"Debt":2664193,"Gold":69758,"Others":0,"timestamp":"20.03.2024","total":133210591,"movement":4326895}]
/// success : 1
/// goldFlag : 1
/// othersFlag : 1
/// realEstateFlag : 0
/// solutionFlag : 0
/// hybridFlag : 1
/// equityFlag : 1
/// debtFlag : 1
/// AlternateFlag : 0
/// debtFdFlag : 0

BsMovementResponse bsMovementResponseFromJson(String str) => BsMovementResponse.fromJson(json.decode(str));
String bsMovementResponseToJson(BsMovementResponse data) => json.encode(data.toJson());
class BsMovementResponse {
  BsMovementResponse({
      List<GraphData>? graphData, 
      List<SheetData>? sheetData, 
      num? success, 
      num? goldFlag, 
      num? othersFlag, 
      num? realEstateFlag, 
      num? solutionFlag, 
      num? hybridFlag, 
      num? equityFlag, 
      num? debtFlag, 
      num? alternateFlag, 
      num? debtFdFlag,}){
    _graphData = graphData;
    _sheetData = sheetData;
    _success = success;
    _goldFlag = goldFlag;
    _othersFlag = othersFlag;
    _realEstateFlag = realEstateFlag;
    _solutionFlag = solutionFlag;
    _hybridFlag = hybridFlag;
    _equityFlag = equityFlag;
    _debtFlag = debtFlag;
    _alternateFlag = alternateFlag;
    _debtFdFlag = debtFdFlag;
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
    _hybridFlag = json['hybridFlag'];
    _equityFlag = json['equityFlag'];
    _debtFlag = json['debtFlag'];
    _alternateFlag = json['AlternateFlag'];
    _debtFdFlag = json['debtFdFlag'];
  }
  List<GraphData>? _graphData;
  List<SheetData>? _sheetData;
  num? _success;
  num? _goldFlag;
  num? _othersFlag;
  num? _realEstateFlag;
  num? _solutionFlag;
  num? _hybridFlag;
  num? _equityFlag;
  num? _debtFlag;
  num? _alternateFlag;
  num? _debtFdFlag;
BsMovementResponse copyWith({  List<GraphData>? graphData,
  List<SheetData>? sheetData,
  num? success,
  num? goldFlag,
  num? othersFlag,
  num? realEstateFlag,
  num? solutionFlag,
  num? hybridFlag,
  num? equityFlag,
  num? debtFlag,
  num? alternateFlag,
  num? debtFdFlag,
}) => BsMovementResponse(  graphData: graphData ?? _graphData,
  sheetData: sheetData ?? _sheetData,
  success: success ?? _success,
  goldFlag: goldFlag ?? _goldFlag,
  othersFlag: othersFlag ?? _othersFlag,
  realEstateFlag: realEstateFlag ?? _realEstateFlag,
  solutionFlag: solutionFlag ?? _solutionFlag,
  hybridFlag: hybridFlag ?? _hybridFlag,
  equityFlag: equityFlag ?? _equityFlag,
  debtFlag: debtFlag ?? _debtFlag,
  alternateFlag: alternateFlag ?? _alternateFlag,
  debtFdFlag: debtFdFlag ?? _debtFdFlag,
);
  List<GraphData>? get graphData => _graphData;
  List<SheetData>? get sheetData => _sheetData;
  num? get success => _success;
  num? get goldFlag => _goldFlag;
  num? get othersFlag => _othersFlag;
  num? get realEstateFlag => _realEstateFlag;
  num? get solutionFlag => _solutionFlag;
  num? get hybridFlag => _hybridFlag;
  num? get equityFlag => _equityFlag;
  num? get debtFlag => _debtFlag;
  num? get alternateFlag => _alternateFlag;
  num? get debtFdFlag => _debtFdFlag;

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
    map['hybridFlag'] = _hybridFlag;
    map['equityFlag'] = _equityFlag;
    map['debtFlag'] = _debtFlag;
    map['AlternateFlag'] = _alternateFlag;
    map['debtFdFlag'] = _debtFdFlag;
    return map;
  }

}

/// Hybrid : 749371
/// Equity : 51357245
/// Debt : 6592722
/// Gold : 45966
/// Others : 0
/// timestamp : "31.03.2022"
/// total : 58745304
/// in_out_flow : 0
/// movement : 0
/// profite : 0

SheetData sheetDataFromJson(String str) => SheetData.fromJson(json.decode(str));
String sheetDataToJson(SheetData data) => json.encode(data.toJson());
class SheetData {
  SheetData({
      num? hybrid, 
      num? equity, 
      num? debt, 
      num? gold, 
      num? others, 
      String? timestamp, 
      num? total, 
      num? inOutFlow, 
      num? movement, 
      num? profite,}){
    _hybrid = hybrid;
    _equity = equity;
    _debt = debt;
    _gold = gold;
    _others = others;
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
    _gold = json['Gold'];
    _others = json['Others'];
    _timestamp = json['timestamp'];
    _total = json['total'];
    _inOutFlow = json['in_out_flow'];
    _movement = json['movement'];
    _profite = json['profite'];
  }
  num? _hybrid;
  num? _equity;
  num? _debt;
  num? _gold;
  num? _others;
  String? _timestamp;
  num? _total;
  num? _inOutFlow;
  num? _movement;
  num? _profite;
SheetData copyWith({  num? hybrid,
  num? equity,
  num? debt,
  num? gold,
  num? others,
  String? timestamp,
  num? total,
  num? inOutFlow,
  num? movement,
  num? profite,
}) => SheetData(  hybrid: hybrid ?? _hybrid,
  equity: equity ?? _equity,
  debt: debt ?? _debt,
  gold: gold ?? _gold,
  others: others ?? _others,
  timestamp: timestamp ?? _timestamp,
  total: total ?? _total,
  inOutFlow: inOutFlow ?? _inOutFlow,
  movement: movement ?? _movement,
  profite: profite ?? _profite,
);
  num? get hybrid => _hybrid;
  num? get equity => _equity;
  num? get debt => _debt;
  num? get gold => _gold;
  num? get others => _others;
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
    map['Gold'] = _gold;
    map['Others'] = _others;
    map['timestamp'] = _timestamp;
    map['total'] = _total;
    map['in_out_flow'] = _inOutFlow;
    map['movement'] = _movement;
    map['profite'] = _profite;
    return map;
  }

}

/// Hybrid : 749371
/// Equity : 51357245
/// Debt : 6592722
/// Gold : 45966
/// Others : 0
/// timestamp : "31.03.2022"
/// total : 58745304

GraphData graphDataFromJson(String str) => GraphData.fromJson(json.decode(str));
String graphDataToJson(GraphData data) => json.encode(data.toJson());
class GraphData {
  GraphData({
      num? hybrid, 
      num? equity, 
      num? debt, 
      num? gold, 
      num? others, 
      String? timestamp, 
      num? total,}){
    _hybrid = hybrid;
    _equity = equity;
    _debt = debt;
    _gold = gold;
    _others = others;
    _timestamp = timestamp;
    _total = total;
}

  GraphData.fromJson(dynamic json) {
    _hybrid = json['Hybrid'];
    _equity = json['Equity'];
    _debt = json['Debt'];
    _gold = json['Gold'];
    _others = json['Others'];
    _timestamp = json['timestamp'];
    _total = json['total'];
  }
  num? _hybrid;
  num? _equity;
  num? _debt;
  num? _gold;
  num? _others;
  String? _timestamp;
  num? _total;
GraphData copyWith({  num? hybrid,
  num? equity,
  num? debt,
  num? gold,
  num? others,
  String? timestamp,
  num? total,
}) => GraphData(  hybrid: hybrid ?? _hybrid,
  equity: equity ?? _equity,
  debt: debt ?? _debt,
  gold: gold ?? _gold,
  others: others ?? _others,
  timestamp: timestamp ?? _timestamp,
  total: total ?? _total,
);
  num? get hybrid => _hybrid;
  num? get equity => _equity;
  num? get debt => _debt;
  num? get gold => _gold;
  num? get others => _others;
  String? get timestamp => _timestamp;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Hybrid'] = _hybrid;
    map['Equity'] = _equity;
    map['Debt'] = _debt;
    map['Gold'] = _gold;
    map['Others'] = _others;
    map['timestamp'] = _timestamp;
    map['total'] = _total;
    return map;
  }

}