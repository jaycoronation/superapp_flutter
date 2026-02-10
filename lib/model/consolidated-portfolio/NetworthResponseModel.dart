import 'dart:convert';
/// result : {"networth":[{"asset":"Debt","objectives":[{"objective":"Debt: Ultra Short Duration","applicants":[{"applicant":"ABHA AGARWAL","amount":114368},{"applicant":"MUKESH JINDAL","amount":4768419},{"applicant":"Amount Total","amount":4882787},{"applicant":"Percentage","amount":4.65}],"amount":4882787,"percentage":4.65},{"objective":"Debt: Money Market","applicants":[{"applicant":"ABHA AGARWAL","amount":124412},{"applicant":"MUKESH JINDAL","amount":0},{"applicant":"Amount Total","amount":124412},{"applicant":"Percentage","amount":0.12}],"amount":124412,"percentage":0.12},{"objective":"Debt: Low Duration","applicants":[{"applicant":"ABHA AGARWAL","amount":915128},{"applicant":"MUKESH JINDAL","amount":2446861},{"applicant":"Amount Total","amount":3361989},{"applicant":"Percentage","amount":3.2}],"amount":3361989,"percentage":3.2},{"objective":"Debt: Liquid","applicants":[{"applicant":"ABHA AGARWAL","amount":0},{"applicant":"MUKESH JINDAL","amount":1374406},{"applicant":"Amount Total","amount":1374406},{"applicant":"Percentage","amount":1.31}],"amount":1374406,"percentage":1.31},{"objective":"Bank Balance","applicants":[{"applicant":"ABHA AGARWAL","amount":0},{"applicant":"MUKESH JINDAL","amount":210293},{"applicant":"Amount Total","amount":210293},{"applicant":"Percentage","amount":0.2}],"amount":210293,"percentage":0.2},{"objective":"Sub Total","applicants":[{"applicant":"ABHA AGARWAL","amount":1153908},{"applicant":"MUKESH JINDAL","amount":8799979},{"applicant":"Amount Total","amount":9953887},{"applicant":"Percentage","amount":9.47}]}]},{"asset":"Equity","objectives":[{"objective":"Equity: Flexi Cap","applicants":[{"applicant":"ABHA AGARWAL","amount":2145889},{"applicant":"MUKESH JINDAL","amount":1732880},{"applicant":"Amount Total","amount":3878769},{"applicant":"Percentage","amount":3.69}],"amount":3878769,"percentage":3.69},{"objective":"Equity: Mid Cap","applicants":[{"applicant":"ABHA AGARWAL","amount":3685081},{"applicant":"MUKESH JINDAL","amount":9546101},{"applicant":"Amount Total","amount":13231182},{"applicant":"Percentage","amount":12.59}],"amount":13231182,"percentage":12.59},{"objective":"Equity: ELSS","applicants":[{"applicant":"ABHA AGARWAL","amount":1816204},{"applicant":"MUKESH JINDAL","amount":2489086},{"applicant":"Amount Total","amount":4305290},{"applicant":"Percentage","amount":4.1}],"amount":4305290,"percentage":4.1},{"objective":"Equity: Global","applicants":[{"applicant":"ABHA AGARWAL","amount":1723867},{"applicant":"MUKESH JINDAL","amount":14057174},{"applicant":"Amount Total","amount":15781041},{"applicant":"Percentage","amount":15.01}],"amount":15781041,"percentage":15.01},{"objective":"Equity: Small Cap","applicants":[{"applicant":"ABHA AGARWAL","amount":9148546},{"applicant":"MUKESH JINDAL","amount":21256042},{"applicant":"Amount Total","amount":30404588},{"applicant":"Percentage","amount":28.93}],"amount":30404588,"percentage":28.93},{"objective":"Equity: Large Cap","applicants":[{"applicant":"ABHA AGARWAL","amount":236492},{"applicant":"MUKESH JINDAL","amount":3001086},{"applicant":"Amount Total","amount":3237578},{"applicant":"Percentage","amount":3.08}],"amount":3237578,"percentage":3.08},{"objective":"Equity: Multi Cap","applicants":[{"applicant":"ABHA AGARWAL","amount":1050328},{"applicant":"MUKESH JINDAL","amount":0},{"applicant":"Amount Total","amount":1050328},{"applicant":"Percentage","amount":1}],"amount":1050328,"percentage":1},{"objective":"Equity: Value","applicants":[{"applicant":"ABHA AGARWAL","amount":1381828},{"applicant":"MUKESH JINDAL","amount":0},{"applicant":"Amount Total","amount":1381828},{"applicant":"Percentage","amount":1.31}],"amount":1381828,"percentage":1.31},{"objective":"Equity: Large & Mid Cap","applicants":[{"applicant":"ABHA AGARWAL","amount":1294017},{"applicant":"MUKESH JINDAL","amount":0},{"applicant":"Amount Total","amount":1294017},{"applicant":"Percentage","amount":1.23}],"amount":1294017,"percentage":1.23},{"objective":"Equity: Focused","applicants":[{"applicant":"ABHA AGARWAL","amount":1366639},{"applicant":"MUKESH JINDAL","amount":1267029},{"applicant":"Amount Total","amount":2633668},{"applicant":"Percentage","amount":2.51}],"amount":2633668,"percentage":2.51},{"objective":"Equity: Index","applicants":[{"applicant":"ABHA AGARWAL","amount":422377},{"applicant":"MUKESH JINDAL","amount":7180566},{"applicant":"Amount Total","amount":7602943},{"applicant":"Percentage","amount":7.23}],"amount":7602943,"percentage":7.23},{"objective":"Equity: Sectoral","applicants":[{"applicant":"ABHA AGARWAL","amount":0},{"applicant":"MUKESH JINDAL","amount":3804054},{"applicant":"Amount Total","amount":3804054},{"applicant":"Percentage","amount":3.62}],"amount":3804054,"percentage":3.62},{"objective":"Sub Total","applicants":[{"applicant":"ABHA AGARWAL","amount":24271268},{"applicant":"MUKESH JINDAL","amount":64334018},{"applicant":"Amount Total","amount":88605286},{"applicant":"Percentage","amount":84.3}]}]},{"asset":"Gold","objectives":[{"objective":"Gold: Gold Funds","applicants":[{"applicant":"ABHA AGARWAL","amount":0},{"applicant":"MUKESH JINDAL","amount":51109},{"applicant":"Amount Total","amount":51109},{"applicant":"Percentage","amount":0.05}],"amount":51109,"percentage":0.05},{"objective":"Sub Total","applicants":[{"applicant":"ABHA AGARWAL","amount":0},{"applicant":"MUKESH JINDAL","amount":51109},{"applicant":"Amount Total","amount":51109},{"applicant":"Percentage","amount":0.05}]}]},{"asset":"Hybrid","objectives":[{"objective":"Hybrid: Aggressive","applicants":[{"applicant":"ABHA AGARWAL","amount":684926},{"applicant":"MUKESH JINDAL","amount":0},{"applicant":"Amount Total","amount":684926},{"applicant":"Percentage","amount":0.65}],"amount":684926,"percentage":0.65},{"objective":"Hybrid: Balanced Advantage","applicants":[{"applicant":"ABHA AGARWAL","amount":173415},{"applicant":"MUKESH JINDAL","amount":0},{"applicant":"Amount Total","amount":173415},{"applicant":"Percentage","amount":0.16}],"amount":173415,"percentage":0.16},{"objective":"Hybrid: Equity Savings","applicants":[{"applicant":"ABHA AGARWAL","amount":0},{"applicant":"MUKESH JINDAL","amount":3091903},{"applicant":"Amount Total","amount":3091903},{"applicant":"Percentage","amount":2.94}],"amount":3091903,"percentage":2.94},{"objective":"Hybrid: Arbitrage","applicants":[{"applicant":"ABHA AGARWAL","amount":0},{"applicant":"MUKESH JINDAL","amount":2543682},{"applicant":"Amount Total","amount":2543682},{"applicant":"Percentage","amount":2.42}],"amount":2543682,"percentage":2.42},{"objective":"Sub Total","applicants":[{"applicant":"ABHA AGARWAL","amount":858341},{"applicant":"MUKESH JINDAL","amount":5635585},{"applicant":"Amount Total","amount":6493926},{"applicant":"Percentage","amount":6.18}]},{"objective":"Total","applicants":[{"applicant":"ABHA AGARWAL","amount":26283517},{"applicant":"MUKESH JINDAL","amount":78820691},{"applicant":"Amount Total","amount":105104208},{"applicant":"Percentage","amount":100}]}]}],"equity_table":[{"type":"Large cap","current_allocation":29,"suggested_allocation":30,"variation":1},{"type":"Mid cap","current_allocation":20,"suggested_allocation":20,"variation":0},{"type":"Small cap","current_allocation":32,"suggested_allocation":30,"variation":-2},{"type":"International","current_allocation":19,"suggested_allocation":20,"variation":1}],"scheme_allocation":[{"scheme_name":"HDFC Small Cap Fund (G)","current_value":8243816,"category":"Equity: Small Cap","allocation":7.86},{"scheme_name":"Kotak Smallcap Fund (G)","current_value":5748336,"category":"Equity: Small Cap","allocation":5.48},{"scheme_name":"Axis Small Cap Fund Reg (G)","current_value":5632055,"category":"Equity: Small Cap","allocation":5.37},{"scheme_name":"DSP Small cap Fund Reg (G)","current_value":5387034,"category":"Equity: Small Cap","allocation":5.14},{"scheme_name":"Franklin India Smaller Companies Fund (G)","current_value":5327464,"category":"Equity: Small Cap","allocation":5.08},{"scheme_name":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","current_value":5298056,"category":"Equity: Index","allocation":5.05},{"scheme_name":"Aditya Birla SL Savings Fund Reg (G)","current_value":4882787,"category":"Debt: Ultra Short Duration","allocation":4.65},{"scheme_name":"Edelweiss US Technology Equity Fund of Fund Reg (G)","current_value":4832314,"category":"Equity: Global","allocation":4.61},{"scheme_name":"DSP Mid cap Fund Reg (G)","current_value":4246462,"category":"Equity: Mid Cap","allocation":4.05},{"scheme_name":"Franklin India Technology Fund (G)","current_value":3699848,"category":"Equity: Sectoral","allocation":3.53},{"scheme_name":"ICICI Pru Savings Fund (G)","current_value":3361989,"category":"Debt: Low Duration","allocation":3.21},{"scheme_name":"HSBC Midcap Fund Reg (G)","current_value":3094452,"category":"Equity: Mid Cap","allocation":2.95},{"scheme_name":"HDFC Equity Savings Fund (G)","current_value":3086530,"category":"Hybrid: Equity Savings","allocation":2.94},{"scheme_name":"Franklin India Feeder Franklin US Opp (G)","current_value":3015972,"category":"Equity: Global","allocation":2.88},{"scheme_name":"SBI Magnum MidCap Fund Reg (G)","current_value":2937017,"category":"Equity: Mid Cap","allocation":2.8},{"scheme_name":"SBI Arbitrage Opp Fund Reg (G)","current_value":2543682,"category":"Hybrid: Arbitrage","allocation":2.43},{"scheme_name":"Kotak Nasdaq 100 FOF Reg (G)","current_value":2475985,"category":"Equity: Global","allocation":2.36},{"scheme_name":"Aditya Birla SL Flexi Cap Fund Reg (G)","current_value":2412940,"category":"Equity: Flexi Cap","allocation":2.3},{"scheme_name":"Motilal Oswal Nasdaq 100 FOF (G)","current_value":2087941,"category":"Equity: Global","allocation":1.99},{"scheme_name":"Edelweiss Emerging Markets Opp Equity Offshore Fund Reg (G)","current_value":1933886,"category":"Equity: Global","allocation":1.84},{"scheme_name":"HDFC Mid Cap Opportunities Fund (G)","current_value":1751169,"category":"Equity: Mid Cap","allocation":1.67},{"scheme_name":"ICICI Pru Bluechip Fund Reg (G)","current_value":1690566,"category":"Equity: Large Cap","allocation":1.61},{"scheme_name":"ICICI Pru Value Discovery Fund (G)","current_value":1381828,"category":"Equity: Value","allocation":1.32},{"scheme_name":"Motilal Oswal Liquid Fund (G)","current_value":1374406,"category":"Debt: Liquid","allocation":1.31},{"scheme_name":"Mirae Asset Focused Fund Reg (G)","current_value":1366639,"category":"Equity: Focused","allocation":1.3},{"scheme_name":"Mirae Asset Large Cap Fund Reg (G)","current_value":1310520,"category":"Equity: Large Cap","allocation":1.25},{"scheme_name":"Mirae Asset Emerging Bluechip Fund Reg (G)","current_value":1294017,"category":"Equity: Large & Mid Cap","allocation":1.23},{"scheme_name":"SBI Focused Equity Fund Reg (G)","current_value":1267029,"category":"Equity: Focused","allocation":1.21},{"scheme_name":"PGIM India Mid Cap Opp Fund Reg (G)","current_value":1202082,"category":"Equity: Mid Cap","allocation":1.15},{"scheme_name":"Edelweiss Greater China Equity Off-shore Fund Reg (G)","current_value":1190014,"category":"Equity: Global","allocation":1.13},{"scheme_name":"ICICI Pru Multicap Fund Reg (G)","current_value":1050328,"category":"Equity: Multi Cap","allocation":1},{"scheme_name":"Motilal Oswal Nifty Smallcap 250 Index Fund (G)","current_value":1048383,"category":"Equity: Index","allocation":1},{"scheme_name":"Motilal Oswal Flexi Cap Fund Reg (G)","current_value":980529,"category":"Equity: Flexi Cap","allocation":0.93},{"scheme_name":"Nippon India Tax Saver (G)","current_value":903530,"category":"Equity: ELSS","allocation":0.86},{"scheme_name":"DSP Tax Saver Fund Reg Fund (G)","current_value":879855,"category":"Equity: ELSS","allocation":0.84},{"scheme_name":"HDFC Tax Saver (G)","current_value":885363,"category":"Equity: ELSS","allocation":0.84},{"scheme_name":"Motilal Oswal Nifty Midcap 150 Index Fund Reg (G)","current_value":834127,"category":"Equity: Index","allocation":0.8},{"scheme_name":"SBI Long Term Equity Fund Reg (G)","current_value":727157,"category":"Equity: ELSS","allocation":0.69},{"scheme_name":"ICICI Pru Long Term Equity Fund Reg (G)","current_value":548849,"category":"Equity: ELSS","allocation":0.52},{"scheme_name":"HSBC Aggressive Hybrid Fund Reg (G)","current_value":483720,"category":"Hybrid: Aggressive","allocation":0.46},{"scheme_name":"Bandhan Flexi Cap Fund Reg (G)","current_value":454456,"category":"Equity: Flexi Cap","allocation":0.43},{"scheme_name":"Motilal Oswal S&P 500 Index Fund Reg (G)","current_value":422377,"category":"Equity: Index","allocation":0.4},{"scheme_name":"Aditya Birla SL Tax Relief 96 Fund (ELSS U/S 80C of IT ACT) Reg (G)","current_value":360536,"category":"Equity: ELSS","allocation":0.34},{"scheme_name":"HDFC Top 100 Fund (G)","current_value":236492,"category":"Equity: Large Cap","allocation":0.23},{"scheme_name":"Aditya Birla Sun Life Nasdaq 100 FOF Reg (G)","current_value":244929,"category":"Equity: Global","allocation":0.23},{"scheme_name":"DSP Equity & Bond Fund Reg (G)","current_value":201206,"category":"Hybrid: Aggressive","allocation":0.19},{"scheme_name":"ICICI Pru Balanced Advantage Fund Reg (G)","current_value":173415,"category":"Hybrid: Balanced Advantage","allocation":0.17},{"scheme_name":"HDFC Money Market Fund (G)","current_value":124412,"category":"Debt: Money Market","allocation":0.12},{"scheme_name":"DSP India T.I.G.E.R. Fund Reg (G)","current_value":104206,"category":"Equity: Sectoral","allocation":0.1},{"scheme_name":"SBI Small Cap Fund Reg (G)","current_value":65883,"category":"Equity: Small Cap","allocation":0.06},{"scheme_name":"HDFC Gold Fund (G)","current_value":51109,"category":"Gold: Gold Funds","allocation":0.05},{"scheme_name":"UTI Flexi Cap Fund Reg (G)","current_value":30844,"category":"Equity: Flexi Cap","allocation":0.03},{"scheme_name":"ICICI Pru Equity Savings Fund (G)","current_value":5373,"category":"Hybrid: Equity Savings","allocation":0.01},{"scheme_name":"Total","current_value":104893915,"category":"","allocation":100}],"fund_house_allocation":[{"fund_house":"HDFC Mutual Fund","current_value":14378891,"allocation":14},{"fund_house":"Motilal Oswal Mutual Fund","current_value":12045819,"allocation":11},{"fund_house":"Franklin Templeton Mutual Fund","current_value":12043284,"allocation":11},{"fund_house":"DSP Mutual Fund","current_value":10818763,"allocation":10},{"fund_house":"Aditya Birla Sun Life Mutual Fund","current_value":7901192,"allocation":8},{"fund_house":"ICICI Prudential Mutual Fund","current_value":8212348,"allocation":8},{"fund_house":"Edelweiss Mutual Fund","current_value":7956214,"allocation":8},{"fund_house":"Kotak Mahindra Mutual Fund","current_value":8224321,"allocation":8},{"fund_house":"SBI Mutual Fund","current_value":7540768,"allocation":7},{"fund_house":"Axis Mutual Fund","current_value":5632055,"allocation":5},{"fund_house":"Mirae Asset Mutual Fund","current_value":3971176,"allocation":4},{"fund_house":"HSBC Mutual Fund","current_value":3578172,"allocation":3},{"fund_house":"PGIM India Mutual Fund","current_value":1202082,"allocation":1},{"fund_house":"Nippon India Mutual Fund","current_value":903530,"allocation":0.86},{"fund_house":"Bandhan Mutual Fund","current_value":454456,"allocation":0.43},{"fund_house":"UTI Mutual Fund","current_value":30844,"allocation":0.03},{"fund_house":"Total","current_value":104893915,"allocation":100}],"micro_asset_stratagic":[{"asset":"Debt","amount":9953887,"actual":9,"policy":20,"variation":11},{"asset":"Equity","amount":88605286,"actual":84,"policy":80,"variation":-4},{"asset":"Hybrid","amount":6493926,"actual":6,"policy":0,"variation":-6},{"asset":"Real Estate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Alternate","amount":51109,"actual":0,"policy":0,"variation":0},{"asset":"Total","amount":105104208.63,"actual":100,"policy":100,"variation":0}],"micro_asset_tactical":[{"asset":"Debt","amount":9953887,"actual":9,"policy":32,"variation":23},{"asset":"Equity","amount":88605286,"actual":84,"policy":68,"variation":-16},{"asset":"Hybrid","amount":6493926,"actual":6,"policy":0,"variation":-6},{"asset":"Real Estate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Alternate","amount":51109,"actual":0,"policy":0,"variation":0},{"asset":"Total","amount":105104208.63,"actual":100,"policy":100,"variation":0}],"macro_asset_stratagic":[{"asset":"Volatile","amount":92877447,"actual":88,"policy":80,"variation":-8},{"asset":"Fixed Income","amount":12226761,"actual":11,"policy":20,"variation":9},{"asset":"Real Estate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Total","amount":105104208.63,"actual":100,"policy":100,"variation":0}],"macro_asset_tactical":[{"asset":"Volatile","amount":92877447,"actual":88,"policy":68,"variation":-20},{"asset":"Fixed Income","amount":12226761,"actual":11,"policy":32,"variation":21},{"asset":"Real Estate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Total","amount":105104208.63,"actual":100,"policy":100,"variation":0}],"service_providers":[{"service_provider":"AlphaCapital","amount":104893915,"allocation":100},{"service_provider":"Other Broker","amount":210294,"allocation":0},{"service_provider":"Total","amount":105104209,"allocation":100}],"applicant_details":[{"applicant":"ABHA AGARWAL","amount":26283517,"allocation":25.01},{"applicant":"MUKESH JINDAL","amount":78820691,"allocation":74.99},{"applicant":"Amount Total","amount":105104208,"allocation":100}]}
/// success : 1
/// message : ""

NetworthResponseModel networthResponseModelFromJson(String str) => NetworthResponseModel.fromJson(json.decode(str));
String networthResponseModelToJson(NetworthResponseModel data) => json.encode(data.toJson());
class NetworthResponseModel {
  NetworthResponseModel({
    List<String>? applicantsFilter,
    Result? result,
      num? success, 
      String? message,}){
    _applicantsFilter = applicantsFilter;
    _result = result;
    _success = success;
    _message = message;
}

  NetworthResponseModel.fromJson(dynamic json) {
    _applicantsFilter = json['applicants_filter'] != null ? json['applicants_filter'].cast<String>() : [];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
    _success = json['success'];
    _message = json['message'];
  }
  Result? _result;
  List<String>? _applicantsFilter;
  num? _success;
  String? _message;
NetworthResponseModel copyWith({  Result? result,
  List<String>? applicantsFilter,
  num? success,
  String? message,
}) => NetworthResponseModel(  result: result ?? _result,
  applicantsFilter: applicantsFilter ?? _applicantsFilter,
  success: success ?? _success,
  message: message ?? _message,
);
  Result? get result => _result;
  List<String>? get applicantsFilter => _applicantsFilter;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicants_filter'] = _applicantsFilter;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// networth : [{"asset":"Debt","objectives":[{"objective":"Debt: Ultra Short Duration","applicants":[{"applicant":"ABHA AGARWAL","amount":114368},{"applicant":"MUKESH JINDAL","amount":4768419},{"applicant":"Amount Total","amount":4882787},{"applicant":"Percentage","amount":4.65}],"amount":4882787,"percentage":4.65},{"objective":"Debt: Money Market","applicants":[{"applicant":"ABHA AGARWAL","amount":124412},{"applicant":"MUKESH JINDAL","amount":0},{"applicant":"Amount Total","amount":124412},{"applicant":"Percentage","amount":0.12}],"amount":124412,"percentage":0.12},{"objective":"Debt: Low Duration","applicants":[{"applicant":"ABHA AGARWAL","amount":915128},{"applicant":"MUKESH JINDAL","amount":2446861},{"applicant":"Amount Total","amount":3361989},{"applicant":"Percentage","amount":3.2}],"amount":3361989,"percentage":3.2},{"objective":"Debt: Liquid","applicants":[{"applicant":"ABHA AGARWAL","amount":0},{"applicant":"MUKESH JINDAL","amount":1374406},{"applicant":"Amount Total","amount":1374406},{"applicant":"Percentage","amount":1.31}],"amount":1374406,"percentage":1.31},{"objective":"Bank Balance","applicants":[{"applicant":"ABHA AGARWAL","amount":0},{"applicant":"MUKESH JINDAL","amount":210293},{"applicant":"Amount Total","amount":210293},{"applicant":"Percentage","amount":0.2}],"amount":210293,"percentage":0.2},{"objective":"Sub Total","applicants":[{"applicant":"ABHA AGARWAL","amount":1153908},{"applicant":"MUKESH JINDAL","amount":8799979},{"applicant":"Amount Total","amount":9953887},{"applicant":"Percentage","amount":9.47}]}]},{"asset":"Equity","objectives":[{"objective":"Equity: Flexi Cap","applicants":[{"applicant":"ABHA AGARWAL","amount":2145889},{"applicant":"MUKESH JINDAL","amount":1732880},{"applicant":"Amount Total","amount":3878769},{"applicant":"Percentage","amount":3.69}],"amount":3878769,"percentage":3.69},{"objective":"Equity: Mid Cap","applicants":[{"applicant":"ABHA AGARWAL","amount":3685081},{"applicant":"MUKESH JINDAL","amount":9546101},{"applicant":"Amount Total","amount":13231182},{"applicant":"Percentage","amount":12.59}],"amount":13231182,"percentage":12.59},{"objective":"Equity: ELSS","applicants":[{"applicant":"ABHA AGARWAL","amount":1816204},{"applicant":"MUKESH JINDAL","amount":2489086},{"applicant":"Amount Total","amount":4305290},{"applicant":"Percentage","amount":4.1}],"amount":4305290,"percentage":4.1},{"objective":"Equity: Global","applicants":[{"applicant":"ABHA AGARWAL","amount":1723867},{"applicant":"MUKESH JINDAL","amount":14057174},{"applicant":"Amount Total","amount":15781041},{"applicant":"Percentage","amount":15.01}],"amount":15781041,"percentage":15.01},{"objective":"Equity: Small Cap","applicants":[{"applicant":"ABHA AGARWAL","amount":9148546},{"applicant":"MUKESH JINDAL","amount":21256042},{"applicant":"Amount Total","amount":30404588},{"applicant":"Percentage","amount":28.93}],"amount":30404588,"percentage":28.93},{"objective":"Equity: Large Cap","applicants":[{"applicant":"ABHA AGARWAL","amount":236492},{"applicant":"MUKESH JINDAL","amount":3001086},{"applicant":"Amount Total","amount":3237578},{"applicant":"Percentage","amount":3.08}],"amount":3237578,"percentage":3.08},{"objective":"Equity: Multi Cap","applicants":[{"applicant":"ABHA AGARWAL","amount":1050328},{"applicant":"MUKESH JINDAL","amount":0},{"applicant":"Amount Total","amount":1050328},{"applicant":"Percentage","amount":1}],"amount":1050328,"percentage":1},{"objective":"Equity: Value","applicants":[{"applicant":"ABHA AGARWAL","amount":1381828},{"applicant":"MUKESH JINDAL","amount":0},{"applicant":"Amount Total","amount":1381828},{"applicant":"Percentage","amount":1.31}],"amount":1381828,"percentage":1.31},{"objective":"Equity: Large & Mid Cap","applicants":[{"applicant":"ABHA AGARWAL","amount":1294017},{"applicant":"MUKESH JINDAL","amount":0},{"applicant":"Amount Total","amount":1294017},{"applicant":"Percentage","amount":1.23}],"amount":1294017,"percentage":1.23},{"objective":"Equity: Focused","applicants":[{"applicant":"ABHA AGARWAL","amount":1366639},{"applicant":"MUKESH JINDAL","amount":1267029},{"applicant":"Amount Total","amount":2633668},{"applicant":"Percentage","amount":2.51}],"amount":2633668,"percentage":2.51},{"objective":"Equity: Index","applicants":[{"applicant":"ABHA AGARWAL","amount":422377},{"applicant":"MUKESH JINDAL","amount":7180566},{"applicant":"Amount Total","amount":7602943},{"applicant":"Percentage","amount":7.23}],"amount":7602943,"percentage":7.23},{"objective":"Equity: Sectoral","applicants":[{"applicant":"ABHA AGARWAL","amount":0},{"applicant":"MUKESH JINDAL","amount":3804054},{"applicant":"Amount Total","amount":3804054},{"applicant":"Percentage","amount":3.62}],"amount":3804054,"percentage":3.62},{"objective":"Sub Total","applicants":[{"applicant":"ABHA AGARWAL","amount":24271268},{"applicant":"MUKESH JINDAL","amount":64334018},{"applicant":"Amount Total","amount":88605286},{"applicant":"Percentage","amount":84.3}]}]},{"asset":"Gold","objectives":[{"objective":"Gold: Gold Funds","applicants":[{"applicant":"ABHA AGARWAL","amount":0},{"applicant":"MUKESH JINDAL","amount":51109},{"applicant":"Amount Total","amount":51109},{"applicant":"Percentage","amount":0.05}],"amount":51109,"percentage":0.05},{"objective":"Sub Total","applicants":[{"applicant":"ABHA AGARWAL","amount":0},{"applicant":"MUKESH JINDAL","amount":51109},{"applicant":"Amount Total","amount":51109},{"applicant":"Percentage","amount":0.05}]}]},{"asset":"Hybrid","objectives":[{"objective":"Hybrid: Aggressive","applicants":[{"applicant":"ABHA AGARWAL","amount":684926},{"applicant":"MUKESH JINDAL","amount":0},{"applicant":"Amount Total","amount":684926},{"applicant":"Percentage","amount":0.65}],"amount":684926,"percentage":0.65},{"objective":"Hybrid: Balanced Advantage","applicants":[{"applicant":"ABHA AGARWAL","amount":173415},{"applicant":"MUKESH JINDAL","amount":0},{"applicant":"Amount Total","amount":173415},{"applicant":"Percentage","amount":0.16}],"amount":173415,"percentage":0.16},{"objective":"Hybrid: Equity Savings","applicants":[{"applicant":"ABHA AGARWAL","amount":0},{"applicant":"MUKESH JINDAL","amount":3091903},{"applicant":"Amount Total","amount":3091903},{"applicant":"Percentage","amount":2.94}],"amount":3091903,"percentage":2.94},{"objective":"Hybrid: Arbitrage","applicants":[{"applicant":"ABHA AGARWAL","amount":0},{"applicant":"MUKESH JINDAL","amount":2543682},{"applicant":"Amount Total","amount":2543682},{"applicant":"Percentage","amount":2.42}],"amount":2543682,"percentage":2.42},{"objective":"Sub Total","applicants":[{"applicant":"ABHA AGARWAL","amount":858341},{"applicant":"MUKESH JINDAL","amount":5635585},{"applicant":"Amount Total","amount":6493926},{"applicant":"Percentage","amount":6.18}]},{"objective":"Total","applicants":[{"applicant":"ABHA AGARWAL","amount":26283517},{"applicant":"MUKESH JINDAL","amount":78820691},{"applicant":"Amount Total","amount":105104208},{"applicant":"Percentage","amount":100}]}]}]
/// equity_table : [{"type":"Large cap","current_allocation":29,"suggested_allocation":30,"variation":1},{"type":"Mid cap","current_allocation":20,"suggested_allocation":20,"variation":0},{"type":"Small cap","current_allocation":32,"suggested_allocation":30,"variation":-2},{"type":"International","current_allocation":19,"suggested_allocation":20,"variation":1}]
/// scheme_allocation : [{"scheme_name":"HDFC Small Cap Fund (G)","current_value":8243816,"category":"Equity: Small Cap","allocation":7.86},{"scheme_name":"Kotak Smallcap Fund (G)","current_value":5748336,"category":"Equity: Small Cap","allocation":5.48},{"scheme_name":"Axis Small Cap Fund Reg (G)","current_value":5632055,"category":"Equity: Small Cap","allocation":5.37},{"scheme_name":"DSP Small cap Fund Reg (G)","current_value":5387034,"category":"Equity: Small Cap","allocation":5.14},{"scheme_name":"Franklin India Smaller Companies Fund (G)","current_value":5327464,"category":"Equity: Small Cap","allocation":5.08},{"scheme_name":"Motilal Oswal Nifty Microcap 250 Index Fund Reg (G)","current_value":5298056,"category":"Equity: Index","allocation":5.05},{"scheme_name":"Aditya Birla SL Savings Fund Reg (G)","current_value":4882787,"category":"Debt: Ultra Short Duration","allocation":4.65},{"scheme_name":"Edelweiss US Technology Equity Fund of Fund Reg (G)","current_value":4832314,"category":"Equity: Global","allocation":4.61},{"scheme_name":"DSP Mid cap Fund Reg (G)","current_value":4246462,"category":"Equity: Mid Cap","allocation":4.05},{"scheme_name":"Franklin India Technology Fund (G)","current_value":3699848,"category":"Equity: Sectoral","allocation":3.53},{"scheme_name":"ICICI Pru Savings Fund (G)","current_value":3361989,"category":"Debt: Low Duration","allocation":3.21},{"scheme_name":"HSBC Midcap Fund Reg (G)","current_value":3094452,"category":"Equity: Mid Cap","allocation":2.95},{"scheme_name":"HDFC Equity Savings Fund (G)","current_value":3086530,"category":"Hybrid: Equity Savings","allocation":2.94},{"scheme_name":"Franklin India Feeder Franklin US Opp (G)","current_value":3015972,"category":"Equity: Global","allocation":2.88},{"scheme_name":"SBI Magnum MidCap Fund Reg (G)","current_value":2937017,"category":"Equity: Mid Cap","allocation":2.8},{"scheme_name":"SBI Arbitrage Opp Fund Reg (G)","current_value":2543682,"category":"Hybrid: Arbitrage","allocation":2.43},{"scheme_name":"Kotak Nasdaq 100 FOF Reg (G)","current_value":2475985,"category":"Equity: Global","allocation":2.36},{"scheme_name":"Aditya Birla SL Flexi Cap Fund Reg (G)","current_value":2412940,"category":"Equity: Flexi Cap","allocation":2.3},{"scheme_name":"Motilal Oswal Nasdaq 100 FOF (G)","current_value":2087941,"category":"Equity: Global","allocation":1.99},{"scheme_name":"Edelweiss Emerging Markets Opp Equity Offshore Fund Reg (G)","current_value":1933886,"category":"Equity: Global","allocation":1.84},{"scheme_name":"HDFC Mid Cap Opportunities Fund (G)","current_value":1751169,"category":"Equity: Mid Cap","allocation":1.67},{"scheme_name":"ICICI Pru Bluechip Fund Reg (G)","current_value":1690566,"category":"Equity: Large Cap","allocation":1.61},{"scheme_name":"ICICI Pru Value Discovery Fund (G)","current_value":1381828,"category":"Equity: Value","allocation":1.32},{"scheme_name":"Motilal Oswal Liquid Fund (G)","current_value":1374406,"category":"Debt: Liquid","allocation":1.31},{"scheme_name":"Mirae Asset Focused Fund Reg (G)","current_value":1366639,"category":"Equity: Focused","allocation":1.3},{"scheme_name":"Mirae Asset Large Cap Fund Reg (G)","current_value":1310520,"category":"Equity: Large Cap","allocation":1.25},{"scheme_name":"Mirae Asset Emerging Bluechip Fund Reg (G)","current_value":1294017,"category":"Equity: Large & Mid Cap","allocation":1.23},{"scheme_name":"SBI Focused Equity Fund Reg (G)","current_value":1267029,"category":"Equity: Focused","allocation":1.21},{"scheme_name":"PGIM India Mid Cap Opp Fund Reg (G)","current_value":1202082,"category":"Equity: Mid Cap","allocation":1.15},{"scheme_name":"Edelweiss Greater China Equity Off-shore Fund Reg (G)","current_value":1190014,"category":"Equity: Global","allocation":1.13},{"scheme_name":"ICICI Pru Multicap Fund Reg (G)","current_value":1050328,"category":"Equity: Multi Cap","allocation":1},{"scheme_name":"Motilal Oswal Nifty Smallcap 250 Index Fund (G)","current_value":1048383,"category":"Equity: Index","allocation":1},{"scheme_name":"Motilal Oswal Flexi Cap Fund Reg (G)","current_value":980529,"category":"Equity: Flexi Cap","allocation":0.93},{"scheme_name":"Nippon India Tax Saver (G)","current_value":903530,"category":"Equity: ELSS","allocation":0.86},{"scheme_name":"DSP Tax Saver Fund Reg Fund (G)","current_value":879855,"category":"Equity: ELSS","allocation":0.84},{"scheme_name":"HDFC Tax Saver (G)","current_value":885363,"category":"Equity: ELSS","allocation":0.84},{"scheme_name":"Motilal Oswal Nifty Midcap 150 Index Fund Reg (G)","current_value":834127,"category":"Equity: Index","allocation":0.8},{"scheme_name":"SBI Long Term Equity Fund Reg (G)","current_value":727157,"category":"Equity: ELSS","allocation":0.69},{"scheme_name":"ICICI Pru Long Term Equity Fund Reg (G)","current_value":548849,"category":"Equity: ELSS","allocation":0.52},{"scheme_name":"HSBC Aggressive Hybrid Fund Reg (G)","current_value":483720,"category":"Hybrid: Aggressive","allocation":0.46},{"scheme_name":"Bandhan Flexi Cap Fund Reg (G)","current_value":454456,"category":"Equity: Flexi Cap","allocation":0.43},{"scheme_name":"Motilal Oswal S&P 500 Index Fund Reg (G)","current_value":422377,"category":"Equity: Index","allocation":0.4},{"scheme_name":"Aditya Birla SL Tax Relief 96 Fund (ELSS U/S 80C of IT ACT) Reg (G)","current_value":360536,"category":"Equity: ELSS","allocation":0.34},{"scheme_name":"HDFC Top 100 Fund (G)","current_value":236492,"category":"Equity: Large Cap","allocation":0.23},{"scheme_name":"Aditya Birla Sun Life Nasdaq 100 FOF Reg (G)","current_value":244929,"category":"Equity: Global","allocation":0.23},{"scheme_name":"DSP Equity & Bond Fund Reg (G)","current_value":201206,"category":"Hybrid: Aggressive","allocation":0.19},{"scheme_name":"ICICI Pru Balanced Advantage Fund Reg (G)","current_value":173415,"category":"Hybrid: Balanced Advantage","allocation":0.17},{"scheme_name":"HDFC Money Market Fund (G)","current_value":124412,"category":"Debt: Money Market","allocation":0.12},{"scheme_name":"DSP India T.I.G.E.R. Fund Reg (G)","current_value":104206,"category":"Equity: Sectoral","allocation":0.1},{"scheme_name":"SBI Small Cap Fund Reg (G)","current_value":65883,"category":"Equity: Small Cap","allocation":0.06},{"scheme_name":"HDFC Gold Fund (G)","current_value":51109,"category":"Gold: Gold Funds","allocation":0.05},{"scheme_name":"UTI Flexi Cap Fund Reg (G)","current_value":30844,"category":"Equity: Flexi Cap","allocation":0.03},{"scheme_name":"ICICI Pru Equity Savings Fund (G)","current_value":5373,"category":"Hybrid: Equity Savings","allocation":0.01},{"scheme_name":"Total","current_value":104893915,"category":"","allocation":100}]
/// fund_house_allocation : [{"fund_house":"HDFC Mutual Fund","current_value":14378891,"allocation":14},{"fund_house":"Motilal Oswal Mutual Fund","current_value":12045819,"allocation":11},{"fund_house":"Franklin Templeton Mutual Fund","current_value":12043284,"allocation":11},{"fund_house":"DSP Mutual Fund","current_value":10818763,"allocation":10},{"fund_house":"Aditya Birla Sun Life Mutual Fund","current_value":7901192,"allocation":8},{"fund_house":"ICICI Prudential Mutual Fund","current_value":8212348,"allocation":8},{"fund_house":"Edelweiss Mutual Fund","current_value":7956214,"allocation":8},{"fund_house":"Kotak Mahindra Mutual Fund","current_value":8224321,"allocation":8},{"fund_house":"SBI Mutual Fund","current_value":7540768,"allocation":7},{"fund_house":"Axis Mutual Fund","current_value":5632055,"allocation":5},{"fund_house":"Mirae Asset Mutual Fund","current_value":3971176,"allocation":4},{"fund_house":"HSBC Mutual Fund","current_value":3578172,"allocation":3},{"fund_house":"PGIM India Mutual Fund","current_value":1202082,"allocation":1},{"fund_house":"Nippon India Mutual Fund","current_value":903530,"allocation":0.86},{"fund_house":"Bandhan Mutual Fund","current_value":454456,"allocation":0.43},{"fund_house":"UTI Mutual Fund","current_value":30844,"allocation":0.03},{"fund_house":"Total","current_value":104893915,"allocation":100}]
/// micro_asset_stratagic : [{"asset":"Debt","amount":9953887,"actual":9,"policy":20,"variation":11},{"asset":"Equity","amount":88605286,"actual":84,"policy":80,"variation":-4},{"asset":"Hybrid","amount":6493926,"actual":6,"policy":0,"variation":-6},{"asset":"Real Estate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Alternate","amount":51109,"actual":0,"policy":0,"variation":0},{"asset":"Total","amount":105104208.63,"actual":100,"policy":100,"variation":0}]
/// micro_asset_tactical : [{"asset":"Debt","amount":9953887,"actual":9,"policy":32,"variation":23},{"asset":"Equity","amount":88605286,"actual":84,"policy":68,"variation":-16},{"asset":"Hybrid","amount":6493926,"actual":6,"policy":0,"variation":-6},{"asset":"Real Estate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Alternate","amount":51109,"actual":0,"policy":0,"variation":0},{"asset":"Total","amount":105104208.63,"actual":100,"policy":100,"variation":0}]
/// macro_asset_stratagic : [{"asset":"Volatile","amount":92877447,"actual":88,"policy":80,"variation":-8},{"asset":"Fixed Income","amount":12226761,"actual":11,"policy":20,"variation":9},{"asset":"Real Estate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Total","amount":105104208.63,"actual":100,"policy":100,"variation":0}]
/// macro_asset_tactical : [{"asset":"Volatile","amount":92877447,"actual":88,"policy":68,"variation":-20},{"asset":"Fixed Income","amount":12226761,"actual":11,"policy":32,"variation":21},{"asset":"Real Estate","amount":0,"actual":0,"policy":0,"variation":0},{"asset":"Total","amount":105104208.63,"actual":100,"policy":100,"variation":0}]
/// service_providers : [{"service_provider":"AlphaCapital","amount":104893915,"allocation":100},{"service_provider":"Other Broker","amount":210294,"allocation":0},{"service_provider":"Total","amount":105104209,"allocation":100}]
/// applicant_details : [{"applicant":"ABHA AGARWAL","amount":26283517,"allocation":25.01},{"applicant":"MUKESH JINDAL","amount":78820691,"allocation":74.99},{"applicant":"Amount Total","amount":105104208,"allocation":100}]

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      List<Networth>? networth, 
      List<EquityTable>? equityTable, 
      List<SchemeAllocation>? schemeAllocation, 
      List<FundHouseAllocation>? fundHouseAllocation, 
      List<MicroAssetStratagic>? microAssetStratagic, 
      List<MicroAssetTactical>? microAssetTactical, 
      List<MacroAssetStratagic>? macroAssetStratagic, 
      List<MacroAssetTactical>? macroAssetTactical, 
      List<ServiceProviders>? serviceProviders, 
      List<ApplicantDetails>? applicantDetails,}){
    _networth = networth;
    _equityTable = equityTable;
    _schemeAllocation = schemeAllocation;
    _fundHouseAllocation = fundHouseAllocation;
    _microAssetStratagic = microAssetStratagic;
    _microAssetTactical = microAssetTactical;
    _macroAssetStratagic = macroAssetStratagic;
    _macroAssetTactical = macroAssetTactical;
    _serviceProviders = serviceProviders;
    _applicantDetails = applicantDetails;
}

  Result.fromJson(dynamic json) {
    if (json['networth'] != null) {
      _networth = [];
      json['networth'].forEach((v) {
        _networth?.add(Networth.fromJson(v));
      });
    }
    if (json['equity_table'] != null) {
      _equityTable = [];
      json['equity_table'].forEach((v) {
        _equityTable?.add(EquityTable.fromJson(v));
      });
    }
    if (json['scheme_allocation'] != null) {
      _schemeAllocation = [];
      json['scheme_allocation'].forEach((v) {
        _schemeAllocation?.add(SchemeAllocation.fromJson(v));
      });
    }
    if (json['fund_house_allocation'] != null) {
      _fundHouseAllocation = [];
      json['fund_house_allocation'].forEach((v) {
        _fundHouseAllocation?.add(FundHouseAllocation.fromJson(v));
      });
    }
    if (json['micro_asset_stratagic'] != null) {
      _microAssetStratagic = [];
      json['micro_asset_stratagic'].forEach((v) {
        _microAssetStratagic?.add(MicroAssetStratagic.fromJson(v));
      });
    }
    if (json['micro_asset_tactical'] != null) {
      _microAssetTactical = [];
      json['micro_asset_tactical'].forEach((v) {
        _microAssetTactical?.add(MicroAssetTactical.fromJson(v));
      });
    }
    if (json['macro_asset_stratagic'] != null) {
      _macroAssetStratagic = [];
      json['macro_asset_stratagic'].forEach((v) {
        _macroAssetStratagic?.add(MacroAssetStratagic.fromJson(v));
      });
    }
    if (json['macro_asset_tactical'] != null) {
      _macroAssetTactical = [];
      json['macro_asset_tactical'].forEach((v) {
        _macroAssetTactical?.add(MacroAssetTactical.fromJson(v));
      });
    }
    if (json['service_providers'] != null) {
      _serviceProviders = [];
      json['service_providers'].forEach((v) {
        _serviceProviders?.add(ServiceProviders.fromJson(v));
      });
    }
    if (json['applicant_details'] != null) {
      _applicantDetails = [];
      json['applicant_details'].forEach((v) {
        _applicantDetails?.add(ApplicantDetails.fromJson(v));
      });
    }
  }
  List<Networth>? _networth;
  List<EquityTable>? _equityTable;
  List<SchemeAllocation>? _schemeAllocation;
  List<FundHouseAllocation>? _fundHouseAllocation;
  List<MicroAssetStratagic>? _microAssetStratagic;
  List<MicroAssetTactical>? _microAssetTactical;
  List<MacroAssetStratagic>? _macroAssetStratagic;
  List<MacroAssetTactical>? _macroAssetTactical;
  List<ServiceProviders>? _serviceProviders;
  List<ApplicantDetails>? _applicantDetails;
Result copyWith({  List<Networth>? networth,
  List<EquityTable>? equityTable,
  List<SchemeAllocation>? schemeAllocation,
  List<FundHouseAllocation>? fundHouseAllocation,
  List<MicroAssetStratagic>? microAssetStratagic,
  List<MicroAssetTactical>? microAssetTactical,
  List<MacroAssetStratagic>? macroAssetStratagic,
  List<MacroAssetTactical>? macroAssetTactical,
  List<ServiceProviders>? serviceProviders,
  List<ApplicantDetails>? applicantDetails,
}) => Result(  networth: networth ?? _networth,
  equityTable: equityTable ?? _equityTable,
  schemeAllocation: schemeAllocation ?? _schemeAllocation,
  fundHouseAllocation: fundHouseAllocation ?? _fundHouseAllocation,
  microAssetStratagic: microAssetStratagic ?? _microAssetStratagic,
  microAssetTactical: microAssetTactical ?? _microAssetTactical,
  macroAssetStratagic: macroAssetStratagic ?? _macroAssetStratagic,
  macroAssetTactical: macroAssetTactical ?? _macroAssetTactical,
  serviceProviders: serviceProviders ?? _serviceProviders,
  applicantDetails: applicantDetails ?? _applicantDetails,
);
  List<Networth>? get networth => _networth;
  List<EquityTable>? get equityTable => _equityTable;
  List<SchemeAllocation>? get schemeAllocation => _schemeAllocation;
  List<FundHouseAllocation>? get fundHouseAllocation => _fundHouseAllocation;
  List<MicroAssetStratagic>? get microAssetStratagic => _microAssetStratagic;
  List<MicroAssetTactical>? get microAssetTactical => _microAssetTactical;
  List<MacroAssetStratagic>? get macroAssetStratagic => _macroAssetStratagic;
  List<MacroAssetTactical>? get macroAssetTactical => _macroAssetTactical;
  List<ServiceProviders>? get serviceProviders => _serviceProviders;
  List<ApplicantDetails>? get applicantDetails => _applicantDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_networth != null) {
      map['networth'] = _networth?.map((v) => v.toJson()).toList();
    }
    if (_equityTable != null) {
      map['equity_table'] = _equityTable?.map((v) => v.toJson()).toList();
    }
    if (_schemeAllocation != null) {
      map['scheme_allocation'] = _schemeAllocation?.map((v) => v.toJson()).toList();
    }
    if (_fundHouseAllocation != null) {
      map['fund_house_allocation'] = _fundHouseAllocation?.map((v) => v.toJson()).toList();
    }
    if (_microAssetStratagic != null) {
      map['micro_asset_stratagic'] = _microAssetStratagic?.map((v) => v.toJson()).toList();
    }
    if (_microAssetTactical != null) {
      map['micro_asset_tactical'] = _microAssetTactical?.map((v) => v.toJson()).toList();
    }
    if (_macroAssetStratagic != null) {
      map['macro_asset_stratagic'] = _macroAssetStratagic?.map((v) => v.toJson()).toList();
    }
    if (_macroAssetTactical != null) {
      map['macro_asset_tactical'] = _macroAssetTactical?.map((v) => v.toJson()).toList();
    }
    if (_serviceProviders != null) {
      map['service_providers'] = _serviceProviders?.map((v) => v.toJson()).toList();
    }
    if (_applicantDetails != null) {
      map['applicant_details'] = _applicantDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// applicant : "ABHA AGARWAL"
/// amount : 26283517
/// allocation : 25.01

ApplicantDetails applicantDetailsFromJson(String str) => ApplicantDetails.fromJson(json.decode(str));
String applicantDetailsToJson(ApplicantDetails data) => json.encode(data.toJson());
class ApplicantDetails {
  ApplicantDetails({
      String? applicant, 
      num? amount, 
      num? allocation,}){
    _applicant = applicant;
    _amount = amount;
    _allocation = allocation;
}

  ApplicantDetails.fromJson(dynamic json) {
    _applicant = json['applicant'];
    _amount = json['amount'];
    _allocation = json['allocation'];
  }
  String? _applicant;
  num? _amount;
  num? _allocation;
ApplicantDetails copyWith({  String? applicant,
  num? amount,
  num? allocation,
}) => ApplicantDetails(  applicant: applicant ?? _applicant,
  amount: amount ?? _amount,
  allocation: allocation ?? _allocation,
);
  String? get applicant => _applicant;
  num? get amount => _amount;
  num? get allocation => _allocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicant'] = _applicant;
    map['amount'] = _amount;
    map['allocation'] = _allocation;
    return map;
  }

}

/// service_provider : "AlphaCapital"
/// amount : 104893915
/// allocation : 100

ServiceProviders serviceProvidersFromJson(String str) => ServiceProviders.fromJson(json.decode(str));
String serviceProvidersToJson(ServiceProviders data) => json.encode(data.toJson());
class ServiceProviders {
  ServiceProviders({
      String? serviceProvider, 
      num? amount, 
      num? allocation,}){
    _serviceProvider = serviceProvider;
    _amount = amount;
    _allocation = allocation;
}

  ServiceProviders.fromJson(dynamic json) {
    _serviceProvider = json['service_provider'];
    _amount = json['amount'];
    _allocation = json['allocation'];
  }
  String? _serviceProvider;
  num? _amount;
  num? _allocation;
ServiceProviders copyWith({  String? serviceProvider,
  num? amount,
  num? allocation,
}) => ServiceProviders(  serviceProvider: serviceProvider ?? _serviceProvider,
  amount: amount ?? _amount,
  allocation: allocation ?? _allocation,
);
  String? get serviceProvider => _serviceProvider;
  num? get amount => _amount;
  num? get allocation => _allocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_provider'] = _serviceProvider;
    map['amount'] = _amount;
    map['allocation'] = _allocation;
    return map;
  }

}

/// asset : "Volatile"
/// amount : 92877447
/// actual : 88
/// policy : 68
/// variation : -20

MacroAssetTactical macroAssetTacticalFromJson(String str) => MacroAssetTactical.fromJson(json.decode(str));
String macroAssetTacticalToJson(MacroAssetTactical data) => json.encode(data.toJson());
class MacroAssetTactical {
  MacroAssetTactical({
      String? asset, 
      num? amount, 
      num? actual, 
      num? policy, 
      num? variation,}){
    _asset = asset;
    _amount = amount;
    _actual = actual;
    _policy = policy;
    _variation = variation;
}

  MacroAssetTactical.fromJson(dynamic json) {
    _asset = json['asset'];
    _amount = json['amount'];
    _actual = json['actual'];
    _policy = json['policy'];
    _variation = json['variation'];
  }
  String? _asset;
  num? _amount;
  num? _actual;
  num? _policy;
  num? _variation;
MacroAssetTactical copyWith({  String? asset,
  num? amount,
  num? actual,
  num? policy,
  num? variation,
}) => MacroAssetTactical(  asset: asset ?? _asset,
  amount: amount ?? _amount,
  actual: actual ?? _actual,
  policy: policy ?? _policy,
  variation: variation ?? _variation,
);
  String? get asset => _asset;
  num? get amount => _amount;
  num? get actual => _actual;
  num? get policy => _policy;
  num? get variation => _variation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['asset'] = _asset;
    map['amount'] = _amount;
    map['actual'] = _actual;
    map['policy'] = _policy;
    map['variation'] = _variation;
    return map;
  }

}

/// asset : "Volatile"
/// amount : 92877447
/// actual : 88
/// policy : 80
/// variation : -8

MacroAssetStratagic macroAssetStratagicFromJson(String str) => MacroAssetStratagic.fromJson(json.decode(str));
String macroAssetStratagicToJson(MacroAssetStratagic data) => json.encode(data.toJson());
class MacroAssetStratagic {
  MacroAssetStratagic({
      String? asset, 
      num? amount, 
      num? actual, 
      num? policy, 
      num? variation,}){
    _asset = asset;
    _amount = amount;
    _actual = actual;
    _policy = policy;
    _variation = variation;
}

  MacroAssetStratagic.fromJson(dynamic json) {
    _asset = json['asset'];
    _amount = json['amount'];
    _actual = json['actual'];
    _policy = json['policy'];
    _variation = json['variation'];
  }
  String? _asset;
  num? _amount;
  num? _actual;
  num? _policy;
  num? _variation;
MacroAssetStratagic copyWith({  String? asset,
  num? amount,
  num? actual,
  num? policy,
  num? variation,
}) => MacroAssetStratagic(  asset: asset ?? _asset,
  amount: amount ?? _amount,
  actual: actual ?? _actual,
  policy: policy ?? _policy,
  variation: variation ?? _variation,
);
  String? get asset => _asset;
  num? get amount => _amount;
  num? get actual => _actual;
  num? get policy => _policy;
  num? get variation => _variation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['asset'] = _asset;
    map['amount'] = _amount;
    map['actual'] = _actual;
    map['policy'] = _policy;
    map['variation'] = _variation;
    return map;
  }

}

/// asset : "Debt"
/// amount : 9953887
/// actual : 9
/// policy : 32
/// variation : 23

MicroAssetTactical microAssetTacticalFromJson(String str) => MicroAssetTactical.fromJson(json.decode(str));
String microAssetTacticalToJson(MicroAssetTactical data) => json.encode(data.toJson());
class MicroAssetTactical {
  MicroAssetTactical({
      String? asset, 
      num? amount, 
      num? actual, 
      num? policy, 
      num? variation,}){
    _asset = asset;
    _amount = amount;
    _actual = actual;
    _policy = policy;
    _variation = variation;
}

  MicroAssetTactical.fromJson(dynamic json) {
    _asset = json['asset'];
    _amount = json['amount'];
    _actual = json['actual'];
    _policy = json['policy'];
    _variation = json['variation'];
  }
  String? _asset;
  num? _amount;
  num? _actual;
  num? _policy;
  num? _variation;
MicroAssetTactical copyWith({  String? asset,
  num? amount,
  num? actual,
  num? policy,
  num? variation,
}) => MicroAssetTactical(  asset: asset ?? _asset,
  amount: amount ?? _amount,
  actual: actual ?? _actual,
  policy: policy ?? _policy,
  variation: variation ?? _variation,
);
  String? get asset => _asset;
  num? get amount => _amount;
  num? get actual => _actual;
  num? get policy => _policy;
  num? get variation => _variation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['asset'] = _asset;
    map['amount'] = _amount;
    map['actual'] = _actual;
    map['policy'] = _policy;
    map['variation'] = _variation;
    return map;
  }

}

/// asset : "Debt"
/// amount : 9953887
/// actual : 9
/// policy : 20
/// variation : 11

MicroAssetStratagic microAssetStratagicFromJson(String str) => MicroAssetStratagic.fromJson(json.decode(str));
String microAssetStratagicToJson(MicroAssetStratagic data) => json.encode(data.toJson());
class MicroAssetStratagic {
  MicroAssetStratagic({
      String? asset, 
      num? amount, 
      num? actual, 
      num? policy, 
      num? variation,}){
    _asset = asset;
    _amount = amount;
    _actual = actual;
    _policy = policy;
    _variation = variation;
}

  MicroAssetStratagic.fromJson(dynamic json) {
    _asset = json['asset'];
    _amount = json['amount'];
    _actual = json['actual'];
    _policy = json['policy'];
    _variation = json['variation'];
  }
  String? _asset;
  num? _amount;
  num? _actual;
  num? _policy;
  num? _variation;
MicroAssetStratagic copyWith({  String? asset,
  num? amount,
  num? actual,
  num? policy,
  num? variation,
}) => MicroAssetStratagic(  asset: asset ?? _asset,
  amount: amount ?? _amount,
  actual: actual ?? _actual,
  policy: policy ?? _policy,
  variation: variation ?? _variation,
);
  String? get asset => _asset;
  num? get amount => _amount;
  num? get actual => _actual;
  num? get policy => _policy;
  num? get variation => _variation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['asset'] = _asset;
    map['amount'] = _amount;
    map['actual'] = _actual;
    map['policy'] = _policy;
    map['variation'] = _variation;
    return map;
  }

}

/// fund_house : "HDFC Mutual Fund"
/// current_value : 14378891
/// allocation : 14

FundHouseAllocation fundHouseAllocationFromJson(String str) => FundHouseAllocation.fromJson(json.decode(str));
String fundHouseAllocationToJson(FundHouseAllocation data) => json.encode(data.toJson());
class FundHouseAllocation {
  FundHouseAllocation({
      String? fundHouse, 
      num? currentValue, 
      num? allocation,}){
    _fundHouse = fundHouse;
    _currentValue = currentValue;
    _allocation = allocation;
}

  FundHouseAllocation.fromJson(dynamic json) {
    _fundHouse = json['fund_house'];
    _currentValue = json['current_value'];
    _allocation = json['allocation'];
  }
  String? _fundHouse;
  num? _currentValue;
  num? _allocation;
FundHouseAllocation copyWith({  String? fundHouse,
  num? currentValue,
  num? allocation,
}) => FundHouseAllocation(  fundHouse: fundHouse ?? _fundHouse,
  currentValue: currentValue ?? _currentValue,
  allocation: allocation ?? _allocation,
);
  String? get fundHouse => _fundHouse;
  num? get currentValue => _currentValue;
  num? get allocation => _allocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fund_house'] = _fundHouse;
    map['current_value'] = _currentValue;
    map['allocation'] = _allocation;
    return map;
  }

}

/// scheme_name : "HDFC Small Cap Fund (G)"
/// current_value : 8243816
/// category : "Equity: Small Cap"
/// allocation : 7.86

SchemeAllocation schemeAllocationFromJson(String str) => SchemeAllocation.fromJson(json.decode(str));
String schemeAllocationToJson(SchemeAllocation data) => json.encode(data.toJson());
class SchemeAllocation {
  SchemeAllocation({
      String? schemeName, 
      num? currentValue, 
      String? category, 
      num? allocation,}){
    _schemeName = schemeName;
    _currentValue = currentValue;
    _category = category;
    _allocation = allocation;
}

  SchemeAllocation.fromJson(dynamic json) {
    _schemeName = json['scheme_name'];
    _currentValue = json['current_value'];
    _category = json['category'];
    _allocation = json['allocation'];
  }
  String? _schemeName;
  num? _currentValue;
  String? _category;
  num? _allocation;
SchemeAllocation copyWith({  String? schemeName,
  num? currentValue,
  String? category,
  num? allocation,
}) => SchemeAllocation(  schemeName: schemeName ?? _schemeName,
  currentValue: currentValue ?? _currentValue,
  category: category ?? _category,
  allocation: allocation ?? _allocation,
);
  String? get schemeName => _schemeName;
  num? get currentValue => _currentValue;
  String? get category => _category;
  num? get allocation => _allocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['scheme_name'] = _schemeName;
    map['current_value'] = _currentValue;
    map['category'] = _category;
    map['allocation'] = _allocation;
    return map;
  }

}

/// type : "Large cap"
/// current_allocation : 29
/// suggested_allocation : 30
/// variation : 1

EquityTable equityTableFromJson(String str) => EquityTable.fromJson(json.decode(str));
String equityTableToJson(EquityTable data) => json.encode(data.toJson());
class EquityTable {
  EquityTable({
      String? type, 
      num? currentAllocation, 
      num? suggestedAllocation, 
      num? variation,}){
    _type = type;
    _currentAllocation = currentAllocation;
    _suggestedAllocation = suggestedAllocation;
    _variation = variation;
}

  EquityTable.fromJson(dynamic json) {
    _type = json['type'];
    _currentAllocation = json['current_allocation'];
    _suggestedAllocation = json['suggested_allocation'];
    _variation = json['variation'];
  }
  String? _type;
  num? _currentAllocation;
  num? _suggestedAllocation;
  num? _variation;
EquityTable copyWith({  String? type,
  num? currentAllocation,
  num? suggestedAllocation,
  num? variation,
}) => EquityTable(  type: type ?? _type,
  currentAllocation: currentAllocation ?? _currentAllocation,
  suggestedAllocation: suggestedAllocation ?? _suggestedAllocation,
  variation: variation ?? _variation,
);
  String? get type => _type;
  num? get currentAllocation => _currentAllocation;
  num? get suggestedAllocation => _suggestedAllocation;
  num? get variation => _variation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['current_allocation'] = _currentAllocation;
    map['suggested_allocation'] = _suggestedAllocation;
    map['variation'] = _variation;
    return map;
  }

}

/// asset : "Debt"
/// objectives : [{"objective":"Debt: Ultra Short Duration","applicants":[{"applicant":"ABHA AGARWAL","amount":114368},{"applicant":"MUKESH JINDAL","amount":4768419},{"applicant":"Amount Total","amount":4882787},{"applicant":"Percentage","amount":4.65}],"amount":4882787,"percentage":4.65},{"objective":"Debt: Money Market","applicants":[{"applicant":"ABHA AGARWAL","amount":124412},{"applicant":"MUKESH JINDAL","amount":0},{"applicant":"Amount Total","amount":124412},{"applicant":"Percentage","amount":0.12}],"amount":124412,"percentage":0.12},{"objective":"Debt: Low Duration","applicants":[{"applicant":"ABHA AGARWAL","amount":915128},{"applicant":"MUKESH JINDAL","amount":2446861},{"applicant":"Amount Total","amount":3361989},{"applicant":"Percentage","amount":3.2}],"amount":3361989,"percentage":3.2},{"objective":"Debt: Liquid","applicants":[{"applicant":"ABHA AGARWAL","amount":0},{"applicant":"MUKESH JINDAL","amount":1374406},{"applicant":"Amount Total","amount":1374406},{"applicant":"Percentage","amount":1.31}],"amount":1374406,"percentage":1.31},{"objective":"Bank Balance","applicants":[{"applicant":"ABHA AGARWAL","amount":0},{"applicant":"MUKESH JINDAL","amount":210293},{"applicant":"Amount Total","amount":210293},{"applicant":"Percentage","amount":0.2}],"amount":210293,"percentage":0.2},{"objective":"Sub Total","applicants":[{"applicant":"ABHA AGARWAL","amount":1153908},{"applicant":"MUKESH JINDAL","amount":8799979},{"applicant":"Amount Total","amount":9953887},{"applicant":"Percentage","amount":9.47}]}]

Networth networthFromJson(String str) => Networth.fromJson(json.decode(str));
String networthToJson(Networth data) => json.encode(data.toJson());
class Networth {
  Networth({
      String? asset, 
      List<Objectives>? objectives,}){
    _asset = asset;
    _objectives = objectives;
}

  Networth.fromJson(dynamic json) {
    _asset = json['asset'];
    if (json['objectives'] != null) {
      _objectives = [];
      json['objectives'].forEach((v) {
        _objectives?.add(Objectives.fromJson(v));
      });
    }
  }
  String? _asset;
  List<Objectives>? _objectives;
Networth copyWith({  String? asset,
  List<Objectives>? objectives,
}) => Networth(  asset: asset ?? _asset,
  objectives: objectives ?? _objectives,
);
  String? get asset => _asset;
  List<Objectives>? get objectives => _objectives;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['asset'] = _asset;
    if (_objectives != null) {
      map['objectives'] = _objectives?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// objective : "Debt: Ultra Short Duration"
/// applicants : [{"applicant":"ABHA AGARWAL","amount":114368},{"applicant":"MUKESH JINDAL","amount":4768419},{"applicant":"Amount Total","amount":4882787},{"applicant":"Percentage","amount":4.65}]
/// amount : 4882787
/// percentage : 4.65

Objectives objectivesFromJson(String str) => Objectives.fromJson(json.decode(str));
String objectivesToJson(Objectives data) => json.encode(data.toJson());
class Objectives {
  Objectives({
      String? objective, 
      List<Applicants>? applicants, 
      num? amount, 
      num? percentage,}){
    _objective = objective;
    _applicants = applicants;
    _amount = amount;
    _percentage = percentage;
}

  Objectives.fromJson(dynamic json) {
    _objective = json['objective'];
    if (json['applicants'] != null) {
      _applicants = [];
      json['applicants'].forEach((v) {
        _applicants?.add(Applicants.fromJson(v));
      });
    }
    _amount = json['amount'];
    _percentage = json['percentage'];
  }
  String? _objective;
  List<Applicants>? _applicants;
  num? _amount;
  num? _percentage;
Objectives copyWith({  String? objective,
  List<Applicants>? applicants,
  num? amount,
  num? percentage,
}) => Objectives(  objective: objective ?? _objective,
  applicants: applicants ?? _applicants,
  amount: amount ?? _amount,
  percentage: percentage ?? _percentage,
);
  String? get objective => _objective;
  List<Applicants>? get applicants => _applicants;
  num? get amount => _amount;
  num? get percentage => _percentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['objective'] = _objective;
    if (_applicants != null) {
      map['applicants'] = _applicants?.map((v) => v.toJson()).toList();
    }
    map['amount'] = _amount;
    map['percentage'] = _percentage;
    return map;
  }

}

/// applicant : "ABHA AGARWAL"
/// amount : 114368

Applicants applicantsFromJson(String str) => Applicants.fromJson(json.decode(str));
String applicantsToJson(Applicants data) => json.encode(data.toJson());
class Applicants {
  Applicants({
      String? applicant, 
      num? amount,}){
    _applicant = applicant;
    _amount = amount;
}

  Applicants.fromJson(dynamic json) {
    _applicant = json['applicant'];
    _amount = json['amount'];
  }
  String? _applicant;
  num? _amount;
Applicants copyWith({  String? applicant,
  num? amount,
}) => Applicants(  applicant: applicant ?? _applicant,
  amount: amount ?? _amount,
);
  String? get applicant => _applicant;
  num? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applicant'] = _applicant;
    map['amount'] = _amount;
    return map;
  }

}