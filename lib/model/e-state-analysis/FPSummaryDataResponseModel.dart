import 'dart:convert';
/// success : 1
/// message : "Data Loaded"
/// data : {"user_details":{"user_name":"MUKESH JINDAL ","first_name":"MUKESH JINDAL","action_points":null,"last_name":"","life_expectancy":null,"risk_profile":"Highly Aggressive","time_horizon":"","asset_allocation":null,"expected_return":7,"objective":"Comfortable Lifestyle","success":1},"linked_user":{"user_name":"MUKESH JINDAL ","first_name":"MUKESH JINDAL","action_points":null,"last_name":"","life_expectancy":null,"risk_profile":"Highly Aggressive","time_horizon":"","asset_allocation":null,"expected_return":7,"objective":"Comfortable Lifestyle","success":1},"risk_profile_allocation":[{"asset_class":"Volatile","allocation":"90","expected_return":"14"},{"asset_class":"Fixed Income","allocation":"10","expected_return":"7"},{"asset_class":"Total","allocation":"100","expected_return":"13"}],"aspirations_classified":[{"aspirations_classified_user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"302","user_id":"1218","start_year":"2026","end_year":"2080","periodicity":"5","amount":"7500000","aspiration_type":"Automobile","classification":"Lifestyle","other_aspiration":"","total_outflow":"90000000","total_inflation_adjusted_expense":"669162879","wealth_required_today_total":"21350996","volatile_component":"75%","target_return":"12%","required_sip":213849},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"310","user_id":"1218","start_year":"2026","end_year":"2080","periodicity":"1","amount":"10000000","aspiration_type":"Retirement","classification":"Living","other_aspiration":"","total_outflow":"560000000","total_inflation_adjusted_expense":"3951154230","wealth_required_today_total":"125146617","volatile_component":"92%","target_return":"13%","required_sip":1357015},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"325","user_id":"1218","start_year":"2030","end_year":"2035","periodicity":"1","amount":"10000000","aspiration_type":"Child Education - Post Graduation","classification":"Parental Aspiration","other_aspiration":"","total_outflow":"60000000","total_inflation_adjusted_expense":"88061791","wealth_required_today_total":"38029324","volatile_component":"95%","target_return":"14%","required_sip":621160},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"326","user_id":"1218","start_year":"2034","end_year":"2039","periodicity":"1","amount":"10000000","aspiration_type":"Child Education - Post Graduation","classification":"Parental Aspiration","other_aspiration":"","total_outflow":"60000000","total_inflation_adjusted_expense":"111175982","wealth_required_today_total":"23270940","volatile_component":"100%","target_return":"16%","required_sip":355278},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"327","user_id":"1218","start_year":"2030","end_year":"2030","periodicity":"1","amount":"150000000","aspiration_type":"Lifestyle Villa","classification":"Real Estate","other_aspiration":"","total_outflow":"150000000","total_inflation_adjusted_expense":"189371544","wealth_required_today_total":"115326474","volatile_component":"90%","target_return":"13%","required_sip":3093921}],"aspirations_summary":{"aspirations_summary_list":[{"aspirations_summary_user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"302","user_id":"1218","start_year":"2026","end_year":"2080","periodicity":"5","amount":"7500000","aspiration_type":"Automobile","classification":"Lifestyle","other_aspiration":"","total_outflow":"90000000","total_inflation_adjusted_expense":"669162879","wealth_required_today_total":"21350996","volatile_component":"75%","target_return":"12%","required_sip":213849},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"310","user_id":"1218","start_year":"2026","end_year":"2080","periodicity":"1","amount":"10000000","aspiration_type":"Retirement","classification":"Living","other_aspiration":"","total_outflow":"560000000","total_inflation_adjusted_expense":"3951154230","wealth_required_today_total":"125146617","volatile_component":"92%","target_return":"13%","required_sip":1357015},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"325","user_id":"1218","start_year":"2030","end_year":"2035","periodicity":"1","amount":"10000000","aspiration_type":"Child Education - Post Graduation","classification":"Parental Aspiration","other_aspiration":"","total_outflow":"60000000","total_inflation_adjusted_expense":"88061791","wealth_required_today_total":"38029324","volatile_component":"95%","target_return":"14%","required_sip":621160},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"326","user_id":"1218","start_year":"2034","end_year":"2039","periodicity":"1","amount":"10000000","aspiration_type":"Child Education - Post Graduation","classification":"Parental Aspiration","other_aspiration":"","total_outflow":"60000000","total_inflation_adjusted_expense":"111175982","wealth_required_today_total":"23270940","volatile_component":"100%","target_return":"16%","required_sip":355278},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"327","user_id":"1218","start_year":"2030","end_year":"2030","periodicity":"1","amount":"150000000","aspiration_type":"Lifestyle Villa","classification":"Real Estate","other_aspiration":"","total_outflow":"150000000","total_inflation_adjusted_expense":"189371544","wealth_required_today_total":"115326474","volatile_component":"90%","target_return":"13%","required_sip":3093921}],"aspirations_summary_total":{"aspiration_type":"Total","total_outflow":"920000000","total_inflation_adjusted_expense":"5008926426","wealth_required_today_total":"323124351","volatile_component":"91%","target_return":"13%","required_sip":5641223}},"networth":{"networth_list":[{"investment_type":"Bank Balance","asset_type":"Cash","current_value":"250","existing_assets_id":"13190","is_new":"","user_id":"1218","networth_user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Real Estate","asset_type":"Real Estate","current_value":"20000000","existing_assets_id":"14608","is_new":"","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Mutual Funds - Debt","asset_type":"Debt","current_value":"14080881","existing_assets_id":"25814","is_new":"1","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Mutual Funds - Equity","asset_type":"Equity","current_value":"159172094","existing_assets_id":"25815","is_new":"1","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Mutual Funds - Alternate","asset_type":"Alternate","current_value":"29996458","existing_assets_id":"25816","is_new":"1","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Mutual Funds - Hybrid","asset_type":"Hybrid","current_value":"1096608","existing_assets_id":"25817","is_new":"1","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Bank Balance - Debt","asset_type":"Debt","current_value":"381429","existing_assets_id":"25818","is_new":"1","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"}],"networth_total":{"current_value":"224727720"}},"liabilities_data":{"liabilities_list":[{"liability_type":"Car Loan","asset_type":"Debt","current_value":"1000000"}],"total_liabilities":"1000000","success":1,"message":""},"wealth_metrics":{"required_amount":" 323124351","existing_amount":223727720,"total_amount":595853331},"future_inflows":{"future_inflows_list":[{"future_inflow_id":"152","user_id":"1218","source":"Salary","start_year":"2026","end_year":"2035","expected_growth":"20","amount":" 20000000","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","inflation_adjusted_income":" 519173642","pv_of_income":" 372125611"}],"future_inflows_total":{"inflation_adjusted_income":"519173642.24","amount":"20000000","pv_of_income":"372125610.7"}},"risk_components":{"realEstateComponent":9,"volatileComponent":83,"fixedIncomeComponent":8},"recommendation_table":{"components":[{"asset_class":"Volatile","allocation_pct":83,"expected_return":14},{"asset_class":"Fixed Income","allocation_pct":8,"expected_return":7},{"asset_class":"Real Estate","allocation_pct":9,"expected_return":10}],"summary":{"total_allocation_pct":100,"overall_expected_return":13.08}},"range_of_return":[{"range_of_return":"High","one_year":"66.8%","three_year":"40%","five_year":"26.6%"},{"range_of_return":"Average","one_year":"13.08%","three_year":"13.08%","five_year":"13.08%"},{"range_of_return":"Low","one_year":"-40.6%","three_year":"-13.8%","five_year":"1.2%"}],"macro_allocation":[{"asset_class":"Volatile","amount":189881347,"allocation":84,"recommended_allocation":83,"variation":-1},{"asset_class":"Fixed Income","amount":14846373,"allocation":7,"recommended_allocation":8,"variation":1},{"asset_class":"Real Estate","amount":20000000,"allocation":9,"recommended_allocation":9,"variation":0}],"balance_sheet":[{"year":2026,"opening_balance":223727720,"fresh_inflow":15000000,"expected_profit":22544703,"outflow":17500000,"closing_balance":243772423,"present_value":229973984,"growth":22544703,"inflow":15000000,"closing_pv":229973984,"profit_growth_calculation":13},{"year":2027,"opening_balance":243772423,"fresh_inflow":24000000,"outflow":10600000,"expected_profit":33250415,"closing_balance":290422838,"present_value":258475292,"profit_growth_calculation":13},{"year":2028,"opening_balance":290422838,"fresh_inflow":28800000,"outflow":11236000,"expected_profit":39626969,"closing_balance":347613807,"present_value":291863255,"profit_growth_calculation":13},{"year":2029,"opening_balance":347613807,"fresh_inflow":34560000,"outflow":11910160,"expected_profit":47436195,"closing_balance":417699842,"present_value":330857398,"profit_growth_calculation":13},{"year":2030,"opening_balance":417699842,"fresh_inflow":41472000,"outflow":214621083,"expected_profit":56996659,"closing_balance":301547418,"present_value":225333773,"profit_growth_calculation":13},{"year":2031,"opening_balance":301547418,"fresh_inflow":49766400,"outflow":36801203,"expected_profit":42435980,"closing_balance":356948595,"present_value":251634674,"profit_growth_calculation":13},{"year":2032,"opening_balance":356948595,"fresh_inflow":59719680,"outflow":28370382,"expected_profit":50285097,"closing_balance":438582990,"present_value":291682737,"profit_growth_calculation":13},{"year":2033,"opening_balance":438582990,"fresh_inflow":71663616,"outflow":30072605,"expected_profit":61673924,"closing_balance":541847925,"present_value":339962092,"profit_growth_calculation":13},{"year":2034,"opening_balance":541847925,"fresh_inflow":85996339,"outflow":47815442,"expected_profit":76029992,"closing_balance":656058814,"present_value":388320204,"profit_growth_calculation":13},{"year":2035,"opening_balance":656058814,"fresh_inflow":103195607,"outflow":50684369,"expected_profit":91995360,"closing_balance":800565412,"present_value":447031545,"profit_growth_calculation":13},{"year":2036,"opening_balance":800565412,"fresh_inflow":0,"outflow":49248312,"expected_profit":104073504,"closing_balance":855390604,"present_value":450609100,"profit_growth_calculation":13},{"year":2037,"opening_balance":855390604,"fresh_inflow":0,"outflow":37965971,"expected_profit":111200779,"closing_balance":928625412,"present_value":461498380,"profit_growth_calculation":13},{"year":2038,"opening_balance":928625412,"fresh_inflow":0,"outflow":40243929,"expected_profit":120721304,"closing_balance":1009102787,"present_value":473106764,"profit_growth_calculation":13},{"year":2039,"opening_balance":1009102787,"fresh_inflow":0,"outflow":42658565,"expected_profit":131183362,"closing_balance":1097627584,"present_value":485481739,"profit_growth_calculation":13},{"year":2040,"opening_balance":1097627584,"fresh_inflow":0,"outflow":22609040,"expected_profit":142691586,"closing_balance":1217710130,"present_value":508107891,"profit_growth_calculation":13},{"year":2041,"opening_balance":1217710130,"fresh_inflow":0,"outflow":41939768,"expected_profit":158302317,"closing_balance":1334072679,"present_value":525152752,"profit_growth_calculation":13},{"year":2042,"opening_balance":1334072679,"fresh_inflow":0,"outflow":25403517,"expected_profit":173429448,"closing_balance":1482098610,"present_value":550398689,"profit_growth_calculation":13},{"year":2043,"opening_balance":1482098610,"fresh_inflow":0,"outflow":26927728,"expected_profit":192672819,"closing_balance":1647843701,"present_value":577311809,"profit_growth_calculation":13},{"year":2044,"opening_balance":1647843701,"fresh_inflow":0,"outflow":28543392,"expected_profit":214219681,"closing_balance":1833519990,"present_value":606002212,"profit_growth_calculation":13},{"year":2045,"opening_balance":1833519990,"fresh_inflow":0,"outflow":30255995,"expected_profit":238357599,"closing_balance":2041621594,"present_value":636587264,"profit_growth_calculation":13},{"year":2046,"opening_balance":2041621594,"fresh_inflow":0,"outflow":56124871,"expected_profit":265410807,"closing_balance":2250907530,"present_value":662116611,"profit_growth_calculation":13},{"year":2047,"opening_balance":2250907530,"fresh_inflow":0,"outflow":33995636,"expected_profit":292617979,"closing_balance":2509529873,"present_value":696407331,"profit_growth_calculation":13},{"year":2048,"opening_balance":2509529873,"fresh_inflow":0,"outflow":36035374,"expected_profit":326238883,"closing_balance":2799733382,"present_value":732962532,"profit_growth_calculation":13},{"year":2049,"opening_balance":2799733382,"fresh_inflow":0,"outflow":38197497,"expected_profit":363965340,"closing_balance":3125501225,"present_value":771931755,"profit_growth_calculation":13},{"year":2050,"opening_balance":3125501225,"fresh_inflow":0,"outflow":40489346,"expected_profit":406315159,"closing_balance":3491327038,"present_value":813474418,"profit_growth_calculation":13}]}

FpSummaryDataResponseModel fpSummaryDataResponseModelFromJson(String str) => FpSummaryDataResponseModel.fromJson(json.decode(str));
String fpSummaryDataResponseModelToJson(FpSummaryDataResponseModel data) => json.encode(data.toJson());
class FpSummaryDataResponseModel {
  FpSummaryDataResponseModel({
      num? success, 
      String? message, 
      SummaryData? summaryData,}){
    _success = success;
    _message = message;
    _summaryData = summaryData;
}

  FpSummaryDataResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _summaryData = json['data'] != null ? SummaryData.fromJson(json['data']) : null;
  }
  num? _success;
  String? _message;
  SummaryData? _summaryData;
FpSummaryDataResponseModel copyWith({  num? success,
  String? message,
  SummaryData? summaryData,
}) => FpSummaryDataResponseModel(  success: success ?? _success,
  message: message ?? _message,
  summaryData: summaryData ?? _summaryData,
);
  num? get success => _success;
  String? get message => _message;
  SummaryData? get summaryData => _summaryData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_summaryData != null) {
      map['data'] = _summaryData?.toJson();
    }
    return map;
  }

}

/// user_details : {"user_name":"MUKESH JINDAL ","first_name":"MUKESH JINDAL","action_points":null,"last_name":"","life_expectancy":null,"risk_profile":"Highly Aggressive","time_horizon":"","asset_allocation":null,"expected_return":7,"objective":"Comfortable Lifestyle","success":1}
/// linked_user : {"user_name":"MUKESH JINDAL ","first_name":"MUKESH JINDAL","action_points":null,"last_name":"","life_expectancy":null,"risk_profile":"Highly Aggressive","time_horizon":"","asset_allocation":null,"expected_return":7,"objective":"Comfortable Lifestyle","success":1}
/// risk_profile_allocation : [{"asset_class":"Volatile","allocation":"90","expected_return":"14"},{"asset_class":"Fixed Income","allocation":"10","expected_return":"7"},{"asset_class":"Total","allocation":"100","expected_return":"13"}]
/// aspirations_classified : [{"aspirations_classified_user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"302","user_id":"1218","start_year":"2026","end_year":"2080","periodicity":"5","amount":"7500000","aspiration_type":"Automobile","classification":"Lifestyle","other_aspiration":"","total_outflow":"90000000","total_inflation_adjusted_expense":"669162879","wealth_required_today_total":"21350996","volatile_component":"75%","target_return":"12%","required_sip":213849},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"310","user_id":"1218","start_year":"2026","end_year":"2080","periodicity":"1","amount":"10000000","aspiration_type":"Retirement","classification":"Living","other_aspiration":"","total_outflow":"560000000","total_inflation_adjusted_expense":"3951154230","wealth_required_today_total":"125146617","volatile_component":"92%","target_return":"13%","required_sip":1357015},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"325","user_id":"1218","start_year":"2030","end_year":"2035","periodicity":"1","amount":"10000000","aspiration_type":"Child Education - Post Graduation","classification":"Parental Aspiration","other_aspiration":"","total_outflow":"60000000","total_inflation_adjusted_expense":"88061791","wealth_required_today_total":"38029324","volatile_component":"95%","target_return":"14%","required_sip":621160},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"326","user_id":"1218","start_year":"2034","end_year":"2039","periodicity":"1","amount":"10000000","aspiration_type":"Child Education - Post Graduation","classification":"Parental Aspiration","other_aspiration":"","total_outflow":"60000000","total_inflation_adjusted_expense":"111175982","wealth_required_today_total":"23270940","volatile_component":"100%","target_return":"16%","required_sip":355278},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"327","user_id":"1218","start_year":"2030","end_year":"2030","periodicity":"1","amount":"150000000","aspiration_type":"Lifestyle Villa","classification":"Real Estate","other_aspiration":"","total_outflow":"150000000","total_inflation_adjusted_expense":"189371544","wealth_required_today_total":"115326474","volatile_component":"90%","target_return":"13%","required_sip":3093921}]
/// aspirations_summary : {"aspirations_summary_list":[{"aspirations_summary_user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"302","user_id":"1218","start_year":"2026","end_year":"2080","periodicity":"5","amount":"7500000","aspiration_type":"Automobile","classification":"Lifestyle","other_aspiration":"","total_outflow":"90000000","total_inflation_adjusted_expense":"669162879","wealth_required_today_total":"21350996","volatile_component":"75%","target_return":"12%","required_sip":213849},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"310","user_id":"1218","start_year":"2026","end_year":"2080","periodicity":"1","amount":"10000000","aspiration_type":"Retirement","classification":"Living","other_aspiration":"","total_outflow":"560000000","total_inflation_adjusted_expense":"3951154230","wealth_required_today_total":"125146617","volatile_component":"92%","target_return":"13%","required_sip":1357015},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"325","user_id":"1218","start_year":"2030","end_year":"2035","periodicity":"1","amount":"10000000","aspiration_type":"Child Education - Post Graduation","classification":"Parental Aspiration","other_aspiration":"","total_outflow":"60000000","total_inflation_adjusted_expense":"88061791","wealth_required_today_total":"38029324","volatile_component":"95%","target_return":"14%","required_sip":621160},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"326","user_id":"1218","start_year":"2034","end_year":"2039","periodicity":"1","amount":"10000000","aspiration_type":"Child Education - Post Graduation","classification":"Parental Aspiration","other_aspiration":"","total_outflow":"60000000","total_inflation_adjusted_expense":"111175982","wealth_required_today_total":"23270940","volatile_component":"100%","target_return":"16%","required_sip":355278},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"327","user_id":"1218","start_year":"2030","end_year":"2030","periodicity":"1","amount":"150000000","aspiration_type":"Lifestyle Villa","classification":"Real Estate","other_aspiration":"","total_outflow":"150000000","total_inflation_adjusted_expense":"189371544","wealth_required_today_total":"115326474","volatile_component":"90%","target_return":"13%","required_sip":3093921}],"aspirations_summary_total":{"aspiration_type":"Total","total_outflow":"920000000","total_inflation_adjusted_expense":"5008926426","wealth_required_today_total":"323124351","volatile_component":"91%","target_return":"13%","required_sip":5641223}}
/// networth : {"networth_list":[{"investment_type":"Bank Balance","asset_type":"Cash","current_value":"250","existing_assets_id":"13190","is_new":"","user_id":"1218","networth_user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Real Estate","asset_type":"Real Estate","current_value":"20000000","existing_assets_id":"14608","is_new":"","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Mutual Funds - Debt","asset_type":"Debt","current_value":"14080881","existing_assets_id":"25814","is_new":"1","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Mutual Funds - Equity","asset_type":"Equity","current_value":"159172094","existing_assets_id":"25815","is_new":"1","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Mutual Funds - Alternate","asset_type":"Alternate","current_value":"29996458","existing_assets_id":"25816","is_new":"1","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Mutual Funds - Hybrid","asset_type":"Hybrid","current_value":"1096608","existing_assets_id":"25817","is_new":"1","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Bank Balance - Debt","asset_type":"Debt","current_value":"381429","existing_assets_id":"25818","is_new":"1","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"}],"networth_total":{"current_value":"224727720"}}
/// liabilities_data : {"liabilities_list":[{"liability_type":"Car Loan","asset_type":"Debt","current_value":"1000000"}],"total_liabilities":"1000000","success":1,"message":""}
/// wealth_metrics : {"required_amount":" 323124351","existing_amount":223727720,"total_amount":595853331}
/// future_inflows : {"future_inflows_list":[{"future_inflow_id":"152","user_id":"1218","source":"Salary","start_year":"2026","end_year":"2035","expected_growth":"20","amount":" 20000000","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","inflation_adjusted_income":" 519173642","pv_of_income":" 372125611"}],"future_inflows_total":{"inflation_adjusted_income":"519173642.24","amount":"20000000","pv_of_income":"372125610.7"}}
/// risk_components : {"realEstateComponent":9,"volatileComponent":83,"fixedIncomeComponent":8}
/// recommendation_table : {"components":[{"asset_class":"Volatile","allocation_pct":83,"expected_return":14},{"asset_class":"Fixed Income","allocation_pct":8,"expected_return":7},{"asset_class":"Real Estate","allocation_pct":9,"expected_return":10}],"summary":{"total_allocation_pct":100,"overall_expected_return":13.08}}
/// range_of_return : [{"range_of_return":"High","one_year":"66.8%","three_year":"40%","five_year":"26.6%"},{"range_of_return":"Average","one_year":"13.08%","three_year":"13.08%","five_year":"13.08%"},{"range_of_return":"Low","one_year":"-40.6%","three_year":"-13.8%","five_year":"1.2%"}]
/// macro_allocation : [{"asset_class":"Volatile","amount":189881347,"allocation":84,"recommended_allocation":83,"variation":-1},{"asset_class":"Fixed Income","amount":14846373,"allocation":7,"recommended_allocation":8,"variation":1},{"asset_class":"Real Estate","amount":20000000,"allocation":9,"recommended_allocation":9,"variation":0}]
/// balance_sheet : [{"year":2026,"opening_balance":223727720,"fresh_inflow":15000000,"expected_profit":22544703,"outflow":17500000,"closing_balance":243772423,"present_value":229973984,"growth":22544703,"inflow":15000000,"closing_pv":229973984,"profit_growth_calculation":13},{"year":2027,"opening_balance":243772423,"fresh_inflow":24000000,"outflow":10600000,"expected_profit":33250415,"closing_balance":290422838,"present_value":258475292,"profit_growth_calculation":13},{"year":2028,"opening_balance":290422838,"fresh_inflow":28800000,"outflow":11236000,"expected_profit":39626969,"closing_balance":347613807,"present_value":291863255,"profit_growth_calculation":13},{"year":2029,"opening_balance":347613807,"fresh_inflow":34560000,"outflow":11910160,"expected_profit":47436195,"closing_balance":417699842,"present_value":330857398,"profit_growth_calculation":13},{"year":2030,"opening_balance":417699842,"fresh_inflow":41472000,"outflow":214621083,"expected_profit":56996659,"closing_balance":301547418,"present_value":225333773,"profit_growth_calculation":13},{"year":2031,"opening_balance":301547418,"fresh_inflow":49766400,"outflow":36801203,"expected_profit":42435980,"closing_balance":356948595,"present_value":251634674,"profit_growth_calculation":13},{"year":2032,"opening_balance":356948595,"fresh_inflow":59719680,"outflow":28370382,"expected_profit":50285097,"closing_balance":438582990,"present_value":291682737,"profit_growth_calculation":13},{"year":2033,"opening_balance":438582990,"fresh_inflow":71663616,"outflow":30072605,"expected_profit":61673924,"closing_balance":541847925,"present_value":339962092,"profit_growth_calculation":13},{"year":2034,"opening_balance":541847925,"fresh_inflow":85996339,"outflow":47815442,"expected_profit":76029992,"closing_balance":656058814,"present_value":388320204,"profit_growth_calculation":13},{"year":2035,"opening_balance":656058814,"fresh_inflow":103195607,"outflow":50684369,"expected_profit":91995360,"closing_balance":800565412,"present_value":447031545,"profit_growth_calculation":13},{"year":2036,"opening_balance":800565412,"fresh_inflow":0,"outflow":49248312,"expected_profit":104073504,"closing_balance":855390604,"present_value":450609100,"profit_growth_calculation":13},{"year":2037,"opening_balance":855390604,"fresh_inflow":0,"outflow":37965971,"expected_profit":111200779,"closing_balance":928625412,"present_value":461498380,"profit_growth_calculation":13},{"year":2038,"opening_balance":928625412,"fresh_inflow":0,"outflow":40243929,"expected_profit":120721304,"closing_balance":1009102787,"present_value":473106764,"profit_growth_calculation":13},{"year":2039,"opening_balance":1009102787,"fresh_inflow":0,"outflow":42658565,"expected_profit":131183362,"closing_balance":1097627584,"present_value":485481739,"profit_growth_calculation":13},{"year":2040,"opening_balance":1097627584,"fresh_inflow":0,"outflow":22609040,"expected_profit":142691586,"closing_balance":1217710130,"present_value":508107891,"profit_growth_calculation":13},{"year":2041,"opening_balance":1217710130,"fresh_inflow":0,"outflow":41939768,"expected_profit":158302317,"closing_balance":1334072679,"present_value":525152752,"profit_growth_calculation":13},{"year":2042,"opening_balance":1334072679,"fresh_inflow":0,"outflow":25403517,"expected_profit":173429448,"closing_balance":1482098610,"present_value":550398689,"profit_growth_calculation":13},{"year":2043,"opening_balance":1482098610,"fresh_inflow":0,"outflow":26927728,"expected_profit":192672819,"closing_balance":1647843701,"present_value":577311809,"profit_growth_calculation":13},{"year":2044,"opening_balance":1647843701,"fresh_inflow":0,"outflow":28543392,"expected_profit":214219681,"closing_balance":1833519990,"present_value":606002212,"profit_growth_calculation":13},{"year":2045,"opening_balance":1833519990,"fresh_inflow":0,"outflow":30255995,"expected_profit":238357599,"closing_balance":2041621594,"present_value":636587264,"profit_growth_calculation":13},{"year":2046,"opening_balance":2041621594,"fresh_inflow":0,"outflow":56124871,"expected_profit":265410807,"closing_balance":2250907530,"present_value":662116611,"profit_growth_calculation":13},{"year":2047,"opening_balance":2250907530,"fresh_inflow":0,"outflow":33995636,"expected_profit":292617979,"closing_balance":2509529873,"present_value":696407331,"profit_growth_calculation":13},{"year":2048,"opening_balance":2509529873,"fresh_inflow":0,"outflow":36035374,"expected_profit":326238883,"closing_balance":2799733382,"present_value":732962532,"profit_growth_calculation":13},{"year":2049,"opening_balance":2799733382,"fresh_inflow":0,"outflow":38197497,"expected_profit":363965340,"closing_balance":3125501225,"present_value":771931755,"profit_growth_calculation":13},{"year":2050,"opening_balance":3125501225,"fresh_inflow":0,"outflow":40489346,"expected_profit":406315159,"closing_balance":3491327038,"present_value":813474418,"profit_growth_calculation":13}]

SummaryData summaryDataFromJson(String str) => SummaryData.fromJson(json.decode(str));
String summaryDataToJson(SummaryData data) => json.encode(data.toJson());
class SummaryData {
  SummaryData({
      UserDetails? userDetails, 
      LinkedUser? linkedUser, 
      List<RiskProfileAllocation>? riskProfileAllocation, 
      List<AspirationsClassified>? aspirationsClassified, 
      AspirationsSummary? aspirationsSummary, 
      Networth? networth, 
      LiabilitiesData? liabilitiesData, 
      WealthMetrics? wealthMetrics, 
      FutureInflows? futureInflows, 
      RiskComponents? riskComponents, 
      RecommendationTable? recommendationTable, 
      List<RangeOfReturn>? rangeOfReturn, 
      List<MacroAllocation>? macroAllocation, 
      List<BalanceSheet>? balanceSheet,}){
    _userDetails = userDetails;
    _linkedUser = linkedUser;
    _riskProfileAllocation = riskProfileAllocation;
    _aspirationsClassified = aspirationsClassified;
    _aspirationsSummary = aspirationsSummary;
    _networth = networth;
    _liabilitiesData = liabilitiesData;
    _wealthMetrics = wealthMetrics;
    _futureInflows = futureInflows;
    _riskComponents = riskComponents;
    _recommendationTable = recommendationTable;
    _rangeOfReturn = rangeOfReturn;
    _macroAllocation = macroAllocation;
    _balanceSheet = balanceSheet;
}

  SummaryData.fromJson(dynamic json) {
    _userDetails = json['user_details'] != null ? UserDetails.fromJson(json['user_details']) : null;
    _linkedUser = json['linked_user'] != null ? LinkedUser.fromJson(json['linked_user']) : null;
    if (json['risk_profile_allocation'] != null) {
      _riskProfileAllocation = [];
      json['risk_profile_allocation'].forEach((v) {
        _riskProfileAllocation?.add(RiskProfileAllocation.fromJson(v));
      });
    }
    if (json['aspirations_classified'] != null) {
      _aspirationsClassified = [];
      json['aspirations_classified'].forEach((v) {
        _aspirationsClassified?.add(AspirationsClassified.fromJson(v));
      });
    }
    _aspirationsSummary = json['aspirations_summary'] != null ? AspirationsSummary.fromJson(json['aspirations_summary']) : null;
    _networth = json['networth'] != null ? Networth.fromJson(json['networth']) : null;
    _liabilitiesData = json['liabilities'] != null ? LiabilitiesData.fromJson(json['liabilities']) : null;
    _wealthMetrics = json['wealth_metrics'] != null ? WealthMetrics.fromJson(json['wealth_metrics']) : null;
    _futureInflows = json['future_inflows'] != null ? FutureInflows.fromJson(json['future_inflows']) : null;
    _riskComponents = json['risk_components'] != null ? RiskComponents.fromJson(json['risk_components']) : null;
    _recommendationTable = json['recommendation_table'] != null ? RecommendationTable.fromJson(json['recommendation_table']) : null;
    if (json['range_of_return'] != null) {
      _rangeOfReturn = [];
      json['range_of_return'].forEach((v) {
        _rangeOfReturn?.add(RangeOfReturn.fromJson(v));
      });
    }
    if (json['macro_allocation'] != null) {
      _macroAllocation = [];
      json['macro_allocation'].forEach((v) {
        _macroAllocation?.add(MacroAllocation.fromJson(v));
      });
    }
    if (json['balance_sheet'] != null) {
      _balanceSheet = [];
      json['balance_sheet'].forEach((v) {
        _balanceSheet?.add(BalanceSheet.fromJson(v));
      });
    }
  }
  UserDetails? _userDetails;
  LinkedUser? _linkedUser;
  List<RiskProfileAllocation>? _riskProfileAllocation;
  List<AspirationsClassified>? _aspirationsClassified;
  AspirationsSummary? _aspirationsSummary;
  Networth? _networth;
  LiabilitiesData? _liabilitiesData;
  WealthMetrics? _wealthMetrics;
  FutureInflows? _futureInflows;
  RiskComponents? _riskComponents;
  RecommendationTable? _recommendationTable;
  List<RangeOfReturn>? _rangeOfReturn;
  List<MacroAllocation>? _macroAllocation;
  List<BalanceSheet>? _balanceSheet;
SummaryData copyWith({  UserDetails? userDetails,
  LinkedUser? linkedUser,
  List<RiskProfileAllocation>? riskProfileAllocation,
  List<AspirationsClassified>? aspirationsClassified,
  AspirationsSummary? aspirationsSummary,
  Networth? networth,
  LiabilitiesData? liabilitiesData,
  WealthMetrics? wealthMetrics,
  FutureInflows? futureInflows,
  RiskComponents? riskComponents,
  RecommendationTable? recommendationTable,
  List<RangeOfReturn>? rangeOfReturn,
  List<MacroAllocation>? macroAllocation,
  List<BalanceSheet>? balanceSheet,
}) => SummaryData(  userDetails: userDetails ?? _userDetails,
  linkedUser: linkedUser ?? _linkedUser,
  riskProfileAllocation: riskProfileAllocation ?? _riskProfileAllocation,
  aspirationsClassified: aspirationsClassified ?? _aspirationsClassified,
  aspirationsSummary: aspirationsSummary ?? _aspirationsSummary,
  networth: networth ?? _networth,
  liabilitiesData: liabilitiesData ?? _liabilitiesData,
  wealthMetrics: wealthMetrics ?? _wealthMetrics,
  futureInflows: futureInflows ?? _futureInflows,
  riskComponents: riskComponents ?? _riskComponents,
  recommendationTable: recommendationTable ?? _recommendationTable,
  rangeOfReturn: rangeOfReturn ?? _rangeOfReturn,
  macroAllocation: macroAllocation ?? _macroAllocation,
  balanceSheet: balanceSheet ?? _balanceSheet,
);
  UserDetails? get userDetails => _userDetails;
  LinkedUser? get linkedUser => _linkedUser;
  List<RiskProfileAllocation>? get riskProfileAllocation => _riskProfileAllocation;
  List<AspirationsClassified>? get aspirationsClassified => _aspirationsClassified;
  AspirationsSummary? get aspirationsSummary => _aspirationsSummary;
  Networth? get networth => _networth;
  LiabilitiesData? get liabilitiesData => _liabilitiesData;
  WealthMetrics? get wealthMetrics => _wealthMetrics;
  FutureInflows? get futureInflows => _futureInflows;
  RiskComponents? get riskComponents => _riskComponents;
  RecommendationTable? get recommendationTable => _recommendationTable;
  List<RangeOfReturn>? get rangeOfReturn => _rangeOfReturn;
  List<MacroAllocation>? get macroAllocation => _macroAllocation;
  List<BalanceSheet>? get balanceSheet => _balanceSheet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_userDetails != null) {
      map['user_details'] = _userDetails?.toJson();
    }
    if (_linkedUser != null) {
      map['linked_user'] = _linkedUser?.toJson();
    }
    if (_riskProfileAllocation != null) {
      map['risk_profile_allocation'] = _riskProfileAllocation?.map((v) => v.toJson()).toList();
    }
    if (_aspirationsClassified != null) {
      map['aspirations_classified'] = _aspirationsClassified?.map((v) => v.toJson()).toList();
    }
    if (_aspirationsSummary != null) {
      map['aspirations_summary'] = _aspirationsSummary?.toJson();
    }
    if (_networth != null) {
      map['networth'] = _networth?.toJson();
    }
    if (_liabilitiesData != null) {
      map['liabilities'] = _liabilitiesData?.toJson();
    }
    if (_wealthMetrics != null) {
      map['wealth_metrics'] = _wealthMetrics?.toJson();
    }
    if (_futureInflows != null) {
      map['future_inflows'] = _futureInflows?.toJson();
    }
    if (_riskComponents != null) {
      map['risk_components'] = _riskComponents?.toJson();
    }
    if (_recommendationTable != null) {
      map['recommendation_table'] = _recommendationTable?.toJson();
    }
    if (_rangeOfReturn != null) {
      map['range_of_return'] = _rangeOfReturn?.map((v) => v.toJson()).toList();
    }
    if (_macroAllocation != null) {
      map['macro_allocation'] = _macroAllocation?.map((v) => v.toJson()).toList();
    }
    if (_balanceSheet != null) {
      map['balance_sheet'] = _balanceSheet?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// year : 2026
/// opening_balance : 223727720
/// fresh_inflow : 15000000
/// expected_profit : 22544703
/// outflow : 17500000
/// closing_balance : 243772423
/// present_value : 229973984
/// growth : 22544703
/// inflow : 15000000
/// closing_pv : 229973984
/// profit_growth_calculation : 13

BalanceSheet balanceSheetFromJson(String str) => BalanceSheet.fromJson(json.decode(str));
String balanceSheetToJson(BalanceSheet data) => json.encode(data.toJson());
class BalanceSheet {
  BalanceSheet({
      num? year, 
      num? openingBalance, 
      num? freshInflow, 
      num? expectedProfit, 
      num? outflow, 
      num? closingBalance, 
      num? presentValue, 
      num? growth, 
      num? inflow, 
      num? closingPv, 
      num? profitGrowthCalculation,}){
    _year = year;
    _openingBalance = openingBalance;
    _freshInflow = freshInflow;
    _expectedProfit = expectedProfit;
    _outflow = outflow;
    _closingBalance = closingBalance;
    _presentValue = presentValue;
    _growth = growth;
    _inflow = inflow;
    _closingPv = closingPv;
    _profitGrowthCalculation = profitGrowthCalculation;
}

  BalanceSheet.fromJson(dynamic json) {
    _year = json['year'];
    _openingBalance = json['opening_balance'];
    _freshInflow = json['fresh_inflow'];
    _expectedProfit = json['expected_profit'];
    _outflow = json['outflow'];
    _closingBalance = json['closing_balance'];
    _presentValue = json['present_value'];
    _growth = json['growth'];
    _inflow = json['inflow'];
    _closingPv = json['closing_pv'];
    _profitGrowthCalculation = json['profit_growth_calculation'];
  }
  num? _year;
  num? _openingBalance;
  num? _freshInflow;
  num? _expectedProfit;
  num? _outflow;
  num? _closingBalance;
  num? _presentValue;
  num? _growth;
  num? _inflow;
  num? _closingPv;
  num? _profitGrowthCalculation;
BalanceSheet copyWith({  num? year,
  num? openingBalance,
  num? freshInflow,
  num? expectedProfit,
  num? outflow,
  num? closingBalance,
  num? presentValue,
  num? growth,
  num? inflow,
  num? closingPv,
  num? profitGrowthCalculation,
}) => BalanceSheet(  year: year ?? _year,
  openingBalance: openingBalance ?? _openingBalance,
  freshInflow: freshInflow ?? _freshInflow,
  expectedProfit: expectedProfit ?? _expectedProfit,
  outflow: outflow ?? _outflow,
  closingBalance: closingBalance ?? _closingBalance,
  presentValue: presentValue ?? _presentValue,
  growth: growth ?? _growth,
  inflow: inflow ?? _inflow,
  closingPv: closingPv ?? _closingPv,
  profitGrowthCalculation: profitGrowthCalculation ?? _profitGrowthCalculation,
);
  num? get year => _year;
  num? get openingBalance => _openingBalance;
  num? get freshInflow => _freshInflow;
  num? get expectedProfit => _expectedProfit;
  num? get outflow => _outflow;
  num? get closingBalance => _closingBalance;
  num? get presentValue => _presentValue;
  num? get growth => _growth;
  num? get inflow => _inflow;
  num? get closingPv => _closingPv;
  num? get profitGrowthCalculation => _profitGrowthCalculation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = _year;
    map['opening_balance'] = _openingBalance;
    map['fresh_inflow'] = _freshInflow;
    map['expected_profit'] = _expectedProfit;
    map['outflow'] = _outflow;
    map['closing_balance'] = _closingBalance;
    map['present_value'] = _presentValue;
    map['growth'] = _growth;
    map['inflow'] = _inflow;
    map['closing_pv'] = _closingPv;
    map['profit_growth_calculation'] = _profitGrowthCalculation;
    return map;
  }

}

/// asset_class : "Volatile"
/// amount : 189881347
/// allocation : 84
/// recommended_allocation : 83
/// variation : -1

MacroAllocation macroAllocationFromJson(String str) => MacroAllocation.fromJson(json.decode(str));
String macroAllocationToJson(MacroAllocation data) => json.encode(data.toJson());
class MacroAllocation {
  MacroAllocation({
      String? assetClass, 
      num? amount, 
      num? allocation, 
      num? recommendedAllocation, 
      num? variation,}){
    _assetClass = assetClass;
    _amount = amount;
    _allocation = allocation;
    _recommendedAllocation = recommendedAllocation;
    _variation = variation;
}

  MacroAllocation.fromJson(dynamic json) {
    _assetClass = json['asset_class'];
    _amount = json['amount'];
    _allocation = json['allocation'];
    _recommendedAllocation = json['recommended_allocation'];
    _variation = json['variation'];
  }
  String? _assetClass;
  num? _amount;
  num? _allocation;
  num? _recommendedAllocation;
  num? _variation;
MacroAllocation copyWith({  String? assetClass,
  num? amount,
  num? allocation,
  num? recommendedAllocation,
  num? variation,
}) => MacroAllocation(  assetClass: assetClass ?? _assetClass,
  amount: amount ?? _amount,
  allocation: allocation ?? _allocation,
  recommendedAllocation: recommendedAllocation ?? _recommendedAllocation,
  variation: variation ?? _variation,
);
  String? get assetClass => _assetClass;
  num? get amount => _amount;
  num? get allocation => _allocation;
  num? get recommendedAllocation => _recommendedAllocation;
  num? get variation => _variation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['asset_class'] = _assetClass;
    map['amount'] = _amount;
    map['allocation'] = _allocation;
    map['recommended_allocation'] = _recommendedAllocation;
    map['variation'] = _variation;
    return map;
  }

}

/// range_of_return : "High"
/// one_year : "66.8%"
/// three_year : "40%"
/// five_year : "26.6%"

RangeOfReturn rangeOfReturnFromJson(String str) => RangeOfReturn.fromJson(json.decode(str));
String rangeOfReturnToJson(RangeOfReturn data) => json.encode(data.toJson());
class RangeOfReturn {
  RangeOfReturn({
      String? rangeOfReturn, 
      String? oneYear, 
      String? threeYear, 
      String? fiveYear,}){
    _rangeOfReturn = rangeOfReturn;
    _oneYear = oneYear;
    _threeYear = threeYear;
    _fiveYear = fiveYear;
}

  RangeOfReturn.fromJson(dynamic json) {
    _rangeOfReturn = json['range_of_return'];
    _oneYear = json['one_year'];
    _threeYear = json['three_year'];
    _fiveYear = json['five_year'];
  }
  String? _rangeOfReturn;
  String? _oneYear;
  String? _threeYear;
  String? _fiveYear;
RangeOfReturn copyWith({  String? rangeOfReturn,
  String? oneYear,
  String? threeYear,
  String? fiveYear,
}) => RangeOfReturn(  rangeOfReturn: rangeOfReturn ?? _rangeOfReturn,
  oneYear: oneYear ?? _oneYear,
  threeYear: threeYear ?? _threeYear,
  fiveYear: fiveYear ?? _fiveYear,
);
  String? get rangeOfReturn => _rangeOfReturn;
  String? get oneYear => _oneYear;
  String? get threeYear => _threeYear;
  String? get fiveYear => _fiveYear;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['range_of_return'] = _rangeOfReturn;
    map['one_year'] = _oneYear;
    map['three_year'] = _threeYear;
    map['five_year'] = _fiveYear;
    return map;
  }

}

/// components : [{"asset_class":"Volatile","allocation_pct":83,"expected_return":14},{"asset_class":"Fixed Income","allocation_pct":8,"expected_return":7},{"asset_class":"Real Estate","allocation_pct":9,"expected_return":10}]
/// summary : {"total_allocation_pct":100,"overall_expected_return":13.08}

RecommendationTable recommendationTableFromJson(String str) => RecommendationTable.fromJson(json.decode(str));
String recommendationTableToJson(RecommendationTable data) => json.encode(data.toJson());
class RecommendationTable {
  RecommendationTable({
      List<Components>? components, 
      Summary? summary,}){
    _components = components;
    _summary = summary;
}

  RecommendationTable.fromJson(dynamic json) {
    if (json['components'] != null) {
      _components = [];
      json['components'].forEach((v) {
        _components?.add(Components.fromJson(v));
      });
    }
    _summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
  }
  List<Components>? _components;
  Summary? _summary;
RecommendationTable copyWith({  List<Components>? components,
  Summary? summary,
}) => RecommendationTable(  components: components ?? _components,
  summary: summary ?? _summary,
);
  List<Components>? get components => _components;
  Summary? get summary => _summary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_components != null) {
      map['components'] = _components?.map((v) => v.toJson()).toList();
    }
    if (_summary != null) {
      map['summary'] = _summary?.toJson();
    }
    return map;
  }

}

/// total_allocation_pct : 100
/// overall_expected_return : 13.08

Summary summaryFromJson(String str) => Summary.fromJson(json.decode(str));
String summaryToJson(Summary data) => json.encode(data.toJson());
class Summary {
  Summary({
      num? totalAllocationPct, 
      num? overallExpectedReturn,}){
    _totalAllocationPct = totalAllocationPct;
    _overallExpectedReturn = overallExpectedReturn;
}

  Summary.fromJson(dynamic json) {
    _totalAllocationPct = json['total_allocation_pct'];
    _overallExpectedReturn = json['overall_expected_return'];
  }
  num? _totalAllocationPct;
  num? _overallExpectedReturn;
Summary copyWith({  num? totalAllocationPct,
  num? overallExpectedReturn,
}) => Summary(  totalAllocationPct: totalAllocationPct ?? _totalAllocationPct,
  overallExpectedReturn: overallExpectedReturn ?? _overallExpectedReturn,
);
  num? get totalAllocationPct => _totalAllocationPct;
  num? get overallExpectedReturn => _overallExpectedReturn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_allocation_pct'] = _totalAllocationPct;
    map['overall_expected_return'] = _overallExpectedReturn;
    return map;
  }

}

/// asset_class : "Volatile"
/// allocation_pct : 83
/// expected_return : 14

Components componentsFromJson(String str) => Components.fromJson(json.decode(str));
String componentsToJson(Components data) => json.encode(data.toJson());
class Components {
  Components({
      String? assetClass, 
      num? allocationPct, 
      num? expectedReturn,}){
    _assetClass = assetClass;
    _allocationPct = allocationPct;
    _expectedReturn = expectedReturn;
}

  Components.fromJson(dynamic json) {
    _assetClass = json['asset_class'];
    _allocationPct = json['allocation_pct'];
    _expectedReturn = json['expected_return'];
  }
  String? _assetClass;
  num? _allocationPct;
  num? _expectedReturn;
Components copyWith({  String? assetClass,
  num? allocationPct,
  num? expectedReturn,
}) => Components(  assetClass: assetClass ?? _assetClass,
  allocationPct: allocationPct ?? _allocationPct,
  expectedReturn: expectedReturn ?? _expectedReturn,
);
  String? get assetClass => _assetClass;
  num? get allocationPct => _allocationPct;
  num? get expectedReturn => _expectedReturn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['asset_class'] = _assetClass;
    map['allocation_pct'] = _allocationPct;
    map['expected_return'] = _expectedReturn;
    return map;
  }

}

/// realEstateComponent : 9
/// volatileComponent : 83
/// fixedIncomeComponent : 8

RiskComponents riskComponentsFromJson(String str) => RiskComponents.fromJson(json.decode(str));
String riskComponentsToJson(RiskComponents data) => json.encode(data.toJson());
class RiskComponents {
  RiskComponents({
      num? realEstateComponent, 
      num? volatileComponent, 
      num? fixedIncomeComponent,}){
    _realEstateComponent = realEstateComponent;
    _volatileComponent = volatileComponent;
    _fixedIncomeComponent = fixedIncomeComponent;
}

  RiskComponents.fromJson(dynamic json) {
    _realEstateComponent = json['realEstateComponent'];
    _volatileComponent = json['volatileComponent'];
    _fixedIncomeComponent = json['fixedIncomeComponent'];
  }
  num? _realEstateComponent;
  num? _volatileComponent;
  num? _fixedIncomeComponent;
RiskComponents copyWith({  num? realEstateComponent,
  num? volatileComponent,
  num? fixedIncomeComponent,
}) => RiskComponents(  realEstateComponent: realEstateComponent ?? _realEstateComponent,
  volatileComponent: volatileComponent ?? _volatileComponent,
  fixedIncomeComponent: fixedIncomeComponent ?? _fixedIncomeComponent,
);
  num? get realEstateComponent => _realEstateComponent;
  num? get volatileComponent => _volatileComponent;
  num? get fixedIncomeComponent => _fixedIncomeComponent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['realEstateComponent'] = _realEstateComponent;
    map['volatileComponent'] = _volatileComponent;
    map['fixedIncomeComponent'] = _fixedIncomeComponent;
    return map;
  }

}

/// list : [{"future_inflow_id":"152","user_id":"1218","source":"Salary","start_year":"2026","end_year":"2035","expected_growth":"20","amount":" 20000000","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","inflation_adjusted_income":" 519173642","pv_of_income":" 372125611"}]
/// total : {"inflation_adjusted_income":"519173642.24","amount":"20000000","pv_of_income":"372125610.7"}

FutureInflows futureInflowsFromJson(String str) => FutureInflows.fromJson(json.decode(str));
String futureInflowsToJson(FutureInflows data) => json.encode(data.toJson());
class FutureInflows {
  FutureInflows({
      List<FutureInflowsList>? futureInflowsList, 
      FutureInflowsTotal? futureInflowsTotal,}){
    _futureInflowsList = futureInflowsList;
    _futureInflowsTotal = futureInflowsTotal;
}

  FutureInflows.fromJson(dynamic json) {
    if (json['list'] != null) {
      _futureInflowsList = [];
      json['list'].forEach((v) {
        _futureInflowsList?.add(FutureInflowsList.fromJson(v));
      });
    }
    _futureInflowsTotal = json['total'] != null ? FutureInflowsTotal.fromJson(json['total']) : null;
  }
  List<FutureInflowsList>? _futureInflowsList;
  FutureInflowsTotal? _futureInflowsTotal;
FutureInflows copyWith({  List<FutureInflowsList>? futureInflowsList,
  FutureInflowsTotal? futureInflowsTotal,
}) => FutureInflows(  futureInflowsList: futureInflowsList ?? _futureInflowsList,
  futureInflowsTotal: futureInflowsTotal ?? _futureInflowsTotal,
);
  List<FutureInflowsList>? get futureInflowsList => _futureInflowsList;
  FutureInflowsTotal? get futureInflowsTotal => _futureInflowsTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_futureInflowsList != null) {
      map['list'] = _futureInflowsList?.map((v) => v.toJson()).toList();
    }
    if (_futureInflowsTotal != null) {
      map['total'] = _futureInflowsTotal?.toJson();
    }
    return map;
  }

}

/// inflation_adjusted_income : "519173642.24"
/// amount : "20000000"
/// pv_of_income : "372125610.7"

FutureInflowsTotal futureInflowsTotalFromJson(String str) => FutureInflowsTotal.fromJson(json.decode(str));
String futureInflowsTotalToJson(FutureInflowsTotal data) => json.encode(data.toJson());
class FutureInflowsTotal {
  FutureInflowsTotal({
      String? inflationAdjustedIncome, 
      String? amount, 
      String? pvOfIncome,}){
    _inflationAdjustedIncome = inflationAdjustedIncome;
    _amount = amount;
    _pvOfIncome = pvOfIncome;
}

  FutureInflowsTotal.fromJson(dynamic json) {
    _inflationAdjustedIncome = json['inflation_adjusted_income'];
    _amount = json['amount'];
    _pvOfIncome = json['pv_of_income'];
  }
  String? _inflationAdjustedIncome;
  String? _amount;
  String? _pvOfIncome;
FutureInflowsTotal copyWith({  String? inflationAdjustedIncome,
  String? amount,
  String? pvOfIncome,
}) => FutureInflowsTotal(  inflationAdjustedIncome: inflationAdjustedIncome ?? _inflationAdjustedIncome,
  amount: amount ?? _amount,
  pvOfIncome: pvOfIncome ?? _pvOfIncome,
);
  String? get inflationAdjustedIncome => _inflationAdjustedIncome;
  String? get amount => _amount;
  String? get pvOfIncome => _pvOfIncome;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['inflation_adjusted_income'] = _inflationAdjustedIncome;
    map['amount'] = _amount;
    map['pv_of_income'] = _pvOfIncome;
    return map;
  }

}

/// future_inflow_id : "152"
/// user_id : "1218"
/// source : "Salary"
/// start_year : "2026"
/// end_year : "2035"
/// expected_growth : "20"
/// amount : " 20000000"
/// user : {"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""}
/// name : "MUKESH JINDAL"
/// inflation_adjusted_income : " 519173642"
/// pv_of_income : " 372125611"

FutureInflowsList futureInflowsListFromJson(String str) => FutureInflowsList.fromJson(json.decode(str));
String futureInflowsListToJson(FutureInflowsList data) => json.encode(data.toJson());
class FutureInflowsList {
  FutureInflowsList({
      String? futureInflowId, 
      String? userId, 
      String? source, 
      String? startYear, 
      String? endYear, 
      String? expectedGrowth, 
      String? amount, 
      User? user, 
      String? name, 
      String? inflationAdjustedIncome, 
      String? pvOfIncome,}){
    _futureInflowId = futureInflowId;
    _userId = userId;
    _source = source;
    _startYear = startYear;
    _endYear = endYear;
    _expectedGrowth = expectedGrowth;
    _amount = amount;
    _user = user;
    _name = name;
    _inflationAdjustedIncome = inflationAdjustedIncome;
    _pvOfIncome = pvOfIncome;
}

  FutureInflowsList.fromJson(dynamic json) {
    _futureInflowId = json['future_inflow_id'];
    _userId = json['user_id'];
    _source = json['source'];
    _startYear = json['start_year'];
    _endYear = json['end_year'];
    _expectedGrowth = json['expected_growth'];
    _amount = json['amount'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _name = json['name'];
    _inflationAdjustedIncome = json['inflation_adjusted_income'];
    _pvOfIncome = json['pv_of_income'];
  }
  String? _futureInflowId;
  String? _userId;
  String? _source;
  String? _startYear;
  String? _endYear;
  String? _expectedGrowth;
  String? _amount;
  User? _user;
  String? _name;
  String? _inflationAdjustedIncome;
  String? _pvOfIncome;
FutureInflowsList copyWith({  String? futureInflowId,
  String? userId,
  String? source,
  String? startYear,
  String? endYear,
  String? expectedGrowth,
  String? amount,
  User? user,
  String? name,
  String? inflationAdjustedIncome,
  String? pvOfIncome,
}) => FutureInflowsList(  futureInflowId: futureInflowId ?? _futureInflowId,
  userId: userId ?? _userId,
  source: source ?? _source,
  startYear: startYear ?? _startYear,
  endYear: endYear ?? _endYear,
  expectedGrowth: expectedGrowth ?? _expectedGrowth,
  amount: amount ?? _amount,
  user: user ?? _user,
  name: name ?? _name,
  inflationAdjustedIncome: inflationAdjustedIncome ?? _inflationAdjustedIncome,
  pvOfIncome: pvOfIncome ?? _pvOfIncome,
);
  String? get futureInflowId => _futureInflowId;
  String? get userId => _userId;
  String? get source => _source;
  String? get startYear => _startYear;
  String? get endYear => _endYear;
  String? get expectedGrowth => _expectedGrowth;
  String? get amount => _amount;
  User? get user => _user;
  String? get name => _name;
  String? get inflationAdjustedIncome => _inflationAdjustedIncome;
  String? get pvOfIncome => _pvOfIncome;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['future_inflow_id'] = _futureInflowId;
    map['user_id'] = _userId;
    map['source'] = _source;
    map['start_year'] = _startYear;
    map['end_year'] = _endYear;
    map['expected_growth'] = _expectedGrowth;
    map['amount'] = _amount;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['name'] = _name;
    map['inflation_adjusted_income'] = _inflationAdjustedIncome;
    map['pv_of_income'] = _pvOfIncome;
    return map;
  }

}

/// user_id : "1218"
/// first_name : "MUKESH JINDAL"
/// last_name : ""
/// email : "jindalmukesh@gmail.com"
/// mobile : ""
/// dob : ""
/// age : ""
/// retirement_age : ""
/// life_expectancy : ""
/// tax_slab : ""
/// risk_profile : "Highly Aggressive"
/// time_horizon : ""
/// amount_invested : ""
/// is_active : "1"
/// timestamp : ""
/// username : "MUKESH81"
/// name : "MUKESH JINDAL"
/// success : 1
/// message : ""

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? userId, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? mobile, 
      String? dob, 
      String? age, 
      String? retirementAge, 
      String? lifeExpectancy, 
      String? taxSlab, 
      String? riskProfile, 
      String? timeHorizon, 
      String? amountInvested, 
      String? isActive, 
      String? timestamp, 
      String? username, 
      String? name, 
      num? success, 
      String? message,}){
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _mobile = mobile;
    _dob = dob;
    _age = age;
    _retirementAge = retirementAge;
    _lifeExpectancy = lifeExpectancy;
    _taxSlab = taxSlab;
    _riskProfile = riskProfile;
    _timeHorizon = timeHorizon;
    _amountInvested = amountInvested;
    _isActive = isActive;
    _timestamp = timestamp;
    _username = username;
    _name = name;
    _success = success;
    _message = message;
}

  User.fromJson(dynamic json) {
    _userId = json['user_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _dob = json['dob'];
    _age = json['age'];
    _retirementAge = json['retirement_age'];
    _lifeExpectancy = json['life_expectancy'];
    _taxSlab = json['tax_slab'];
    _riskProfile = json['risk_profile'];
    _timeHorizon = json['time_horizon'];
    _amountInvested = json['amount_invested'];
    _isActive = json['is_active'];
    _timestamp = json['timestamp'];
    _username = json['username'];
    _name = json['name'];
    _success = json['success'];
    _message = json['message'];
  }
  String? _userId;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _mobile;
  String? _dob;
  String? _age;
  String? _retirementAge;
  String? _lifeExpectancy;
  String? _taxSlab;
  String? _riskProfile;
  String? _timeHorizon;
  String? _amountInvested;
  String? _isActive;
  String? _timestamp;
  String? _username;
  String? _name;
  num? _success;
  String? _message;
User copyWith({  String? userId,
  String? firstName,
  String? lastName,
  String? email,
  String? mobile,
  String? dob,
  String? age,
  String? retirementAge,
  String? lifeExpectancy,
  String? taxSlab,
  String? riskProfile,
  String? timeHorizon,
  String? amountInvested,
  String? isActive,
  String? timestamp,
  String? username,
  String? name,
  num? success,
  String? message,
}) => User(  userId: userId ?? _userId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  dob: dob ?? _dob,
  age: age ?? _age,
  retirementAge: retirementAge ?? _retirementAge,
  lifeExpectancy: lifeExpectancy ?? _lifeExpectancy,
  taxSlab: taxSlab ?? _taxSlab,
  riskProfile: riskProfile ?? _riskProfile,
  timeHorizon: timeHorizon ?? _timeHorizon,
  amountInvested: amountInvested ?? _amountInvested,
  isActive: isActive ?? _isActive,
  timestamp: timestamp ?? _timestamp,
  username: username ?? _username,
  name: name ?? _name,
  success: success ?? _success,
  message: message ?? _message,
);
  String? get userId => _userId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get dob => _dob;
  String? get age => _age;
  String? get retirementAge => _retirementAge;
  String? get lifeExpectancy => _lifeExpectancy;
  String? get taxSlab => _taxSlab;
  String? get riskProfile => _riskProfile;
  String? get timeHorizon => _timeHorizon;
  String? get amountInvested => _amountInvested;
  String? get isActive => _isActive;
  String? get timestamp => _timestamp;
  String? get username => _username;
  String? get name => _name;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['dob'] = _dob;
    map['age'] = _age;
    map['retirement_age'] = _retirementAge;
    map['life_expectancy'] = _lifeExpectancy;
    map['tax_slab'] = _taxSlab;
    map['risk_profile'] = _riskProfile;
    map['time_horizon'] = _timeHorizon;
    map['amount_invested'] = _amountInvested;
    map['is_active'] = _isActive;
    map['timestamp'] = _timestamp;
    map['username'] = _username;
    map['name'] = _name;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// required_amount : " 323124351"
/// existing_amount : 223727720
/// total_amount : 595853331

WealthMetrics wealthMetricsFromJson(String str) => WealthMetrics.fromJson(json.decode(str));
String wealthMetricsToJson(WealthMetrics data) => json.encode(data.toJson());
class WealthMetrics {
  WealthMetrics({
      String? requiredAmount, 
      String? existingAmount,
      String? totalAmount,}){
    _requiredAmount = requiredAmount;
    _existingAmount = existingAmount;
    _totalAmount = totalAmount;
}

  WealthMetrics.fromJson(dynamic json) {
    _requiredAmount = json['required_amount']is int || json['required_amount']is double ? json['required_amount'].toString() : json['required_amount'];
    _existingAmount = json['existing_amount']is int || json['existing_amount']is double ? json['existing_amount'].toString() : json['existing_amount'];
    _totalAmount = json['total_amount'] is int ? json['total_amount'].toString() : json['total_amount'];
  }
  String? _requiredAmount;
  String? _existingAmount;
  String? _totalAmount;
WealthMetrics copyWith({  String? requiredAmount,
  String? existingAmount,
  String? totalAmount,
}) => WealthMetrics(  requiredAmount: requiredAmount ?? _requiredAmount,
  existingAmount: existingAmount ?? _existingAmount,
  totalAmount: totalAmount ?? _totalAmount,
);
  String? get requiredAmount => _requiredAmount;
  String? get existingAmount => _existingAmount;
  String? get totalAmount => _totalAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['required_amount'] = _requiredAmount;
    map['existing_amount'] = _existingAmount;
    map['total_amount'] = _totalAmount;
    return map;
  }

}

/// liabilities : [{"liability_type":"Car Loan","asset_type":"Debt","current_value":"1000000"}]
/// total_liabilities : "1000000"
/// success : 1
/// message : ""

LiabilitiesData liabilitiesDataFromJson(String str) => LiabilitiesData.fromJson(json.decode(str));
String liabilitiesDataToJson(LiabilitiesData data) => json.encode(data.toJson());
class LiabilitiesData {
  LiabilitiesData({
      List<LiabilitiesList>? liabilitiesList, 
      String? totalLiabilities, 
      num? success, 
      String? message,}){
    _liabilitiesList = liabilitiesList;
    _totalLiabilities = totalLiabilities;
    _success = success;
    _message = message;
}

  LiabilitiesData.fromJson(dynamic json) {
    if (json['liabilities'] != null) {
      _liabilitiesList = [];
      json['liabilities'].forEach((v) {
        _liabilitiesList?.add(LiabilitiesList.fromJson(v));
      });
    }
    _totalLiabilities = json['total_liabilities'];
    _success = json['success'];
    _message = json['message'];
  }
  List<LiabilitiesList>? _liabilitiesList;
  String? _totalLiabilities;
  num? _success;
  String? _message;
LiabilitiesData copyWith({  List<LiabilitiesList>? liabilitiesList,
  String? totalLiabilities,
  num? success,
  String? message,
}) => LiabilitiesData(  liabilitiesList: liabilitiesList ?? _liabilitiesList,
  totalLiabilities: totalLiabilities ?? _totalLiabilities,
  success: success ?? _success,
  message: message ?? _message,
);
  List<LiabilitiesList>? get liabilitiesList => _liabilitiesList;
  String? get totalLiabilities => _totalLiabilities;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_liabilitiesList != null) {
      map['liabilities'] = _liabilitiesList?.map((v) => v.toJson()).toList();
    }
    map['total_liabilities'] = _totalLiabilities;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// liability_type : "Car Loan"
/// asset_type : "Debt"
/// current_value : "1000000"

LiabilitiesList liabilitiesListFromJson(String str) => LiabilitiesList.fromJson(json.decode(str));
String liabilitiesListToJson(LiabilitiesList data) => json.encode(data.toJson());
class LiabilitiesList {
  LiabilitiesList({
      String? liabilityType, 
      String? assetType, 
      String? currentValue,}){
    _liabilityType = liabilityType;
    _assetType = assetType;
    _currentValue = currentValue;
}

  LiabilitiesList.fromJson(dynamic json) {
    _liabilityType = json['liability_type'];
    _assetType = json['asset_type'];
    _currentValue = json['current_value'];
  }
  String? _liabilityType;
  String? _assetType;
  String? _currentValue;
LiabilitiesList copyWith({  String? liabilityType,
  String? assetType,
  String? currentValue,
}) => LiabilitiesList(  liabilityType: liabilityType ?? _liabilityType,
  assetType: assetType ?? _assetType,
  currentValue: currentValue ?? _currentValue,
);
  String? get liabilityType => _liabilityType;
  String? get assetType => _assetType;
  String? get currentValue => _currentValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['liability_type'] = _liabilityType;
    map['asset_type'] = _assetType;
    map['current_value'] = _currentValue;
    return map;
  }

}

/// list : [{"investment_type":"Bank Balance","asset_type":"Cash","current_value":"250","existing_assets_id":"13190","is_new":"","user_id":"1218","networth_user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Real Estate","asset_type":"Real Estate","current_value":"20000000","existing_assets_id":"14608","is_new":"","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Mutual Funds - Debt","asset_type":"Debt","current_value":"14080881","existing_assets_id":"25814","is_new":"1","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Mutual Funds - Equity","asset_type":"Equity","current_value":"159172094","existing_assets_id":"25815","is_new":"1","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Mutual Funds - Alternate","asset_type":"Alternate","current_value":"29996458","existing_assets_id":"25816","is_new":"1","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Mutual Funds - Hybrid","asset_type":"Hybrid","current_value":"1096608","existing_assets_id":"25817","is_new":"1","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"},{"investment_type":"Bank Balance - Debt","asset_type":"Debt","current_value":"381429","existing_assets_id":"25818","is_new":"1","user_id":"1218","user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL"}]
/// total : {"current_value":"224727720"}

Networth networthFromJson(String str) => Networth.fromJson(json.decode(str));
String networthToJson(Networth data) => json.encode(data.toJson());
class Networth {
  Networth({
      List<NetworthList>? networthList, 
      NetworthTotal? networthTotal,}){
    _networthList = networthList;
    _networthTotal = networthTotal;
}

  Networth.fromJson(dynamic json) {
    if (json['list'] != null) {
      _networthList = [];
      json['list'].forEach((v) {
        _networthList?.add(NetworthList.fromJson(v));
      });
    }
    _networthTotal = json['total'] != null ? NetworthTotal.fromJson(json['total']) : null;
  }
  List<NetworthList>? _networthList;
  NetworthTotal? _networthTotal;
Networth copyWith({  List<NetworthList>? networthList,
  NetworthTotal? networthTotal,
}) => Networth(  networthList: networthList ?? _networthList,
  networthTotal: networthTotal ?? _networthTotal,
);
  List<NetworthList>? get networthList => _networthList;
  NetworthTotal? get networthTotal => _networthTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_networthList != null) {
      map['list'] = _networthList?.map((v) => v.toJson()).toList();
    }
    if (_networthTotal != null) {
      map['total'] = _networthTotal?.toJson();
    }
    return map;
  }

}

/// current_value : "224727720"

NetworthTotal networthTotalFromJson(String str) => NetworthTotal.fromJson(json.decode(str));
String networthTotalToJson(NetworthTotal data) => json.encode(data.toJson());
class NetworthTotal {
  NetworthTotal({
      String? currentValue,}){
    _currentValue = currentValue;
}

  NetworthTotal.fromJson(dynamic json) {
    _currentValue = json['current_value'];
  }
  String? _currentValue;
NetworthTotal copyWith({  String? currentValue,
}) => NetworthTotal(  currentValue: currentValue ?? _currentValue,
);
  String? get currentValue => _currentValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_value'] = _currentValue;
    return map;
  }

}

/// investment_type : "Bank Balance"
/// asset_type : "Cash"
/// current_value : "250"
/// existing_assets_id : "13190"
/// is_new : ""
/// user_id : "1218"
/// networth_user : {"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""}
/// name : "MUKESH JINDAL"

NetworthList networthListFromJson(String str) => NetworthList.fromJson(json.decode(str));
String networthListToJson(NetworthList data) => json.encode(data.toJson());
class NetworthList {
  NetworthList({
      String? investmentType, 
      String? assetType, 
      String? currentValue, 
      String? existingAssetsId, 
      String? isNew, 
      String? userId, 
      NetworthUser? networthUser, 
      String? name,}){
    _investmentType = investmentType;
    _assetType = assetType;
    _currentValue = currentValue;
    _existingAssetsId = existingAssetsId;
    _isNew = isNew;
    _userId = userId;
    _networthUser = networthUser;
    _name = name;
}

  NetworthList.fromJson(dynamic json) {
    _investmentType = json['investment_type'];
    _assetType = json['asset_type'];
    _currentValue = json['current_value'];
    _existingAssetsId = json['existing_assets_id'];
    _isNew = json['is_new'];
    _userId = json['user_id'];
    _networthUser = json['networth_user'] != null ? NetworthUser.fromJson(json['networth_user']) : null;
    _name = json['name'];
  }
  String? _investmentType;
  String? _assetType;
  String? _currentValue;
  String? _existingAssetsId;
  String? _isNew;
  String? _userId;
  NetworthUser? _networthUser;
  String? _name;
NetworthList copyWith({  String? investmentType,
  String? assetType,
  String? currentValue,
  String? existingAssetsId,
  String? isNew,
  String? userId,
  NetworthUser? networthUser,
  String? name,
}) => NetworthList(  investmentType: investmentType ?? _investmentType,
  assetType: assetType ?? _assetType,
  currentValue: currentValue ?? _currentValue,
  existingAssetsId: existingAssetsId ?? _existingAssetsId,
  isNew: isNew ?? _isNew,
  userId: userId ?? _userId,
  networthUser: networthUser ?? _networthUser,
  name: name ?? _name,
);
  String? get investmentType => _investmentType;
  String? get assetType => _assetType;
  String? get currentValue => _currentValue;
  String? get existingAssetsId => _existingAssetsId;
  String? get isNew => _isNew;
  String? get userId => _userId;
  NetworthUser? get networthUser => _networthUser;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['investment_type'] = _investmentType;
    map['asset_type'] = _assetType;
    map['current_value'] = _currentValue;
    map['existing_assets_id'] = _existingAssetsId;
    map['is_new'] = _isNew;
    map['user_id'] = _userId;
    if (_networthUser != null) {
      map['networth_user'] = _networthUser?.toJson();
    }
    map['name'] = _name;
    return map;
  }

}

/// user_id : "1218"
/// first_name : "MUKESH JINDAL"
/// last_name : ""
/// email : "jindalmukesh@gmail.com"
/// mobile : ""
/// dob : ""
/// age : ""
/// retirement_age : ""
/// life_expectancy : ""
/// tax_slab : ""
/// risk_profile : "Highly Aggressive"
/// time_horizon : ""
/// amount_invested : ""
/// is_active : "1"
/// timestamp : ""
/// username : "MUKESH81"
/// name : "MUKESH JINDAL"
/// success : 1
/// message : ""

NetworthUser networthUserFromJson(String str) => NetworthUser.fromJson(json.decode(str));
String networthUserToJson(NetworthUser data) => json.encode(data.toJson());
class NetworthUser {
  NetworthUser({
      String? userId, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? mobile, 
      String? dob, 
      String? age, 
      String? retirementAge, 
      String? lifeExpectancy, 
      String? taxSlab, 
      String? riskProfile, 
      String? timeHorizon, 
      String? amountInvested, 
      String? isActive, 
      String? timestamp, 
      String? username, 
      String? name, 
      num? success, 
      String? message,}){
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _mobile = mobile;
    _dob = dob;
    _age = age;
    _retirementAge = retirementAge;
    _lifeExpectancy = lifeExpectancy;
    _taxSlab = taxSlab;
    _riskProfile = riskProfile;
    _timeHorizon = timeHorizon;
    _amountInvested = amountInvested;
    _isActive = isActive;
    _timestamp = timestamp;
    _username = username;
    _name = name;
    _success = success;
    _message = message;
}

  NetworthUser.fromJson(dynamic json) {
    _userId = json['user_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _dob = json['dob'];
    _age = json['age'];
    _retirementAge = json['retirement_age'];
    _lifeExpectancy = json['life_expectancy'];
    _taxSlab = json['tax_slab'];
    _riskProfile = json['risk_profile'];
    _timeHorizon = json['time_horizon'];
    _amountInvested = json['amount_invested'];
    _isActive = json['is_active'];
    _timestamp = json['timestamp'];
    _username = json['username'];
    _name = json['name'];
    _success = json['success'];
    _message = json['message'];
  }
  String? _userId;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _mobile;
  String? _dob;
  String? _age;
  String? _retirementAge;
  String? _lifeExpectancy;
  String? _taxSlab;
  String? _riskProfile;
  String? _timeHorizon;
  String? _amountInvested;
  String? _isActive;
  String? _timestamp;
  String? _username;
  String? _name;
  num? _success;
  String? _message;
NetworthUser copyWith({  String? userId,
  String? firstName,
  String? lastName,
  String? email,
  String? mobile,
  String? dob,
  String? age,
  String? retirementAge,
  String? lifeExpectancy,
  String? taxSlab,
  String? riskProfile,
  String? timeHorizon,
  String? amountInvested,
  String? isActive,
  String? timestamp,
  String? username,
  String? name,
  num? success,
  String? message,
}) => NetworthUser(  userId: userId ?? _userId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  dob: dob ?? _dob,
  age: age ?? _age,
  retirementAge: retirementAge ?? _retirementAge,
  lifeExpectancy: lifeExpectancy ?? _lifeExpectancy,
  taxSlab: taxSlab ?? _taxSlab,
  riskProfile: riskProfile ?? _riskProfile,
  timeHorizon: timeHorizon ?? _timeHorizon,
  amountInvested: amountInvested ?? _amountInvested,
  isActive: isActive ?? _isActive,
  timestamp: timestamp ?? _timestamp,
  username: username ?? _username,
  name: name ?? _name,
  success: success ?? _success,
  message: message ?? _message,
);
  String? get userId => _userId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get dob => _dob;
  String? get age => _age;
  String? get retirementAge => _retirementAge;
  String? get lifeExpectancy => _lifeExpectancy;
  String? get taxSlab => _taxSlab;
  String? get riskProfile => _riskProfile;
  String? get timeHorizon => _timeHorizon;
  String? get amountInvested => _amountInvested;
  String? get isActive => _isActive;
  String? get timestamp => _timestamp;
  String? get username => _username;
  String? get name => _name;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['dob'] = _dob;
    map['age'] = _age;
    map['retirement_age'] = _retirementAge;
    map['life_expectancy'] = _lifeExpectancy;
    map['tax_slab'] = _taxSlab;
    map['risk_profile'] = _riskProfile;
    map['time_horizon'] = _timeHorizon;
    map['amount_invested'] = _amountInvested;
    map['is_active'] = _isActive;
    map['timestamp'] = _timestamp;
    map['username'] = _username;
    map['name'] = _name;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// list : [{"aspirations_summary_user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"302","user_id":"1218","start_year":"2026","end_year":"2080","periodicity":"5","amount":"7500000","aspiration_type":"Automobile","classification":"Lifestyle","other_aspiration":"","total_outflow":"90000000","total_inflation_adjusted_expense":"669162879","wealth_required_today_total":"21350996","volatile_component":"75%","target_return":"12%","required_sip":213849},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"310","user_id":"1218","start_year":"2026","end_year":"2080","periodicity":"1","amount":"10000000","aspiration_type":"Retirement","classification":"Living","other_aspiration":"","total_outflow":"560000000","total_inflation_adjusted_expense":"3951154230","wealth_required_today_total":"125146617","volatile_component":"92%","target_return":"13%","required_sip":1357015},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"325","user_id":"1218","start_year":"2030","end_year":"2035","periodicity":"1","amount":"10000000","aspiration_type":"Child Education - Post Graduation","classification":"Parental Aspiration","other_aspiration":"","total_outflow":"60000000","total_inflation_adjusted_expense":"88061791","wealth_required_today_total":"38029324","volatile_component":"95%","target_return":"14%","required_sip":621160},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"326","user_id":"1218","start_year":"2034","end_year":"2039","periodicity":"1","amount":"10000000","aspiration_type":"Child Education - Post Graduation","classification":"Parental Aspiration","other_aspiration":"","total_outflow":"60000000","total_inflation_adjusted_expense":"111175982","wealth_required_today_total":"23270940","volatile_component":"100%","target_return":"16%","required_sip":355278},{"user":{"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""},"name":"MUKESH JINDAL","aspiration_id":"327","user_id":"1218","start_year":"2030","end_year":"2030","periodicity":"1","amount":"150000000","aspiration_type":"Lifestyle Villa","classification":"Real Estate","other_aspiration":"","total_outflow":"150000000","total_inflation_adjusted_expense":"189371544","wealth_required_today_total":"115326474","volatile_component":"90%","target_return":"13%","required_sip":3093921}]
/// total : {"aspiration_type":"Total","total_outflow":"920000000","total_inflation_adjusted_expense":"5008926426","wealth_required_today_total":"323124351","volatile_component":"91%","target_return":"13%","required_sip":5641223}

AspirationsSummary aspirationsSummaryFromJson(String str) => AspirationsSummary.fromJson(json.decode(str));
String aspirationsSummaryToJson(AspirationsSummary data) => json.encode(data.toJson());
class AspirationsSummary {
  AspirationsSummary({
      List<AspirationsSummaryList>? aspirationsSummaryList, 
      AspirationsSummaryTotal? aspirationsSummaryTotal,}){
    _aspirationsSummaryList = aspirationsSummaryList;
    _aspirationsSummaryTotal = aspirationsSummaryTotal;
}

  AspirationsSummary.fromJson(dynamic json) {
    if (json['list'] != null) {
      _aspirationsSummaryList = [];
      json['list'].forEach((v) {
        _aspirationsSummaryList?.add(AspirationsSummaryList.fromJson(v));
      });
    }
    _aspirationsSummaryTotal = json['total'] != null ? AspirationsSummaryTotal.fromJson(json['total']) : null;
  }
  List<AspirationsSummaryList>? _aspirationsSummaryList;
  AspirationsSummaryTotal? _aspirationsSummaryTotal;
AspirationsSummary copyWith({  List<AspirationsSummaryList>? aspirationsSummaryList,
  AspirationsSummaryTotal? aspirationsSummaryTotal,
}) => AspirationsSummary(  aspirationsSummaryList: aspirationsSummaryList ?? _aspirationsSummaryList,
  aspirationsSummaryTotal: aspirationsSummaryTotal ?? _aspirationsSummaryTotal,
);
  List<AspirationsSummaryList>? get aspirationsSummaryList => _aspirationsSummaryList;
  AspirationsSummaryTotal? get aspirationsSummaryTotal => _aspirationsSummaryTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_aspirationsSummaryList != null) {
      map['list'] = _aspirationsSummaryList?.map((v) => v.toJson()).toList();
    }
    if (_aspirationsSummaryTotal != null) {
      map['total'] = _aspirationsSummaryTotal?.toJson();
    }
    return map;
  }

}

/// aspiration_type : "Total"
/// total_outflow : "920000000"
/// total_inflation_adjusted_expense : "5008926426"
/// wealth_required_today_total : "323124351"
/// volatile_component : "91%"
/// target_return : "13%"
/// required_sip : 5641223

AspirationsSummaryTotal aspirationsSummaryTotalFromJson(String str) => AspirationsSummaryTotal.fromJson(json.decode(str));
String aspirationsSummaryTotalToJson(AspirationsSummaryTotal data) => json.encode(data.toJson());
class AspirationsSummaryTotal {
  AspirationsSummaryTotal({
      String? aspirationType, 
      String? totalOutflow, 
      String? totalInflationAdjustedExpense, 
      String? wealthRequiredTodayTotal, 
      String? volatileComponent, 
      String? targetReturn, 
      num? requiredSip,}){
    _aspirationType = aspirationType;
    _totalOutflow = totalOutflow;
    _totalInflationAdjustedExpense = totalInflationAdjustedExpense;
    _wealthRequiredTodayTotal = wealthRequiredTodayTotal;
    _volatileComponent = volatileComponent;
    _targetReturn = targetReturn;
    _requiredSip = requiredSip;
}

  AspirationsSummaryTotal.fromJson(dynamic json) {
    _aspirationType = json['aspiration_type'];
    _totalOutflow = json['total_outflow'];
    _totalInflationAdjustedExpense = json['total_inflation_adjusted_expense'];
    _wealthRequiredTodayTotal = json['wealth_required_today_total'];
    _volatileComponent = json['volatile_component'];
    _targetReturn = json['target_return'];
    _requiredSip = json['required_sip'];
  }
  String? _aspirationType;
  String? _totalOutflow;
  String? _totalInflationAdjustedExpense;
  String? _wealthRequiredTodayTotal;
  String? _volatileComponent;
  String? _targetReturn;
  num? _requiredSip;
AspirationsSummaryTotal copyWith({  String? aspirationType,
  String? totalOutflow,
  String? totalInflationAdjustedExpense,
  String? wealthRequiredTodayTotal,
  String? volatileComponent,
  String? targetReturn,
  num? requiredSip,
}) => AspirationsSummaryTotal(  aspirationType: aspirationType ?? _aspirationType,
  totalOutflow: totalOutflow ?? _totalOutflow,
  totalInflationAdjustedExpense: totalInflationAdjustedExpense ?? _totalInflationAdjustedExpense,
  wealthRequiredTodayTotal: wealthRequiredTodayTotal ?? _wealthRequiredTodayTotal,
  volatileComponent: volatileComponent ?? _volatileComponent,
  targetReturn: targetReturn ?? _targetReturn,
  requiredSip: requiredSip ?? _requiredSip,
);
  String? get aspirationType => _aspirationType;
  String? get totalOutflow => _totalOutflow;
  String? get totalInflationAdjustedExpense => _totalInflationAdjustedExpense;
  String? get wealthRequiredTodayTotal => _wealthRequiredTodayTotal;
  String? get volatileComponent => _volatileComponent;
  String? get targetReturn => _targetReturn;
  num? get requiredSip => _requiredSip;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aspiration_type'] = _aspirationType;
    map['total_outflow'] = _totalOutflow;
    map['total_inflation_adjusted_expense'] = _totalInflationAdjustedExpense;
    map['wealth_required_today_total'] = _wealthRequiredTodayTotal;
    map['volatile_component'] = _volatileComponent;
    map['target_return'] = _targetReturn;
    map['required_sip'] = _requiredSip;
    return map;
  }

}

/// aspirations_summary_user : {"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""}
/// name : "MUKESH JINDAL"
/// aspiration_id : "302"
/// user_id : "1218"
/// start_year : "2026"
/// end_year : "2080"
/// periodicity : "5"
/// amount : "7500000"
/// aspiration_type : "Automobile"
/// classification : "Lifestyle"
/// other_aspiration : ""
/// total_outflow : "90000000"
/// total_inflation_adjusted_expense : "669162879"
/// wealth_required_today_total : "21350996"
/// volatile_component : "75%"
/// target_return : "12%"
/// required_sip : 213849

AspirationsSummaryList aspirationsSummaryListFromJson(String str) => AspirationsSummaryList.fromJson(json.decode(str));
String aspirationsSummaryListToJson(AspirationsSummaryList data) => json.encode(data.toJson());
class AspirationsSummaryList {
  AspirationsSummaryList({
      AspirationsSummaryUser? aspirationsSummaryUser, 
      String? name, 
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
      String? targetReturn, 
      num? requiredSip,}){
    _aspirationsSummaryUser = aspirationsSummaryUser;
    _name = name;
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
    _requiredSip = requiredSip;
}

  AspirationsSummaryList.fromJson(dynamic json) {
    _aspirationsSummaryUser = json['user'] != null ? AspirationsSummaryUser.fromJson(json['user']) : null;
    _name = json['name'];
    _aspirationId = json['aspiration_id'];
    _userId = json['user_id'];
    _startYear = json['start_year'];
    _endYear = json['end_year'];
    _periodicity = json['periodicity'] is int ? json['periodicity'].toString() : json['periodicity'];
    _amount = json['amount'];
    _aspirationType = json['aspiration_type'];
    _classification = json['classification'];
    _otherAspiration = json['other_aspiration'];
    _totalOutflow = json['total_outflow'];
    _totalInflationAdjustedExpense = json['total_inflation_adjusted_expense'];
    _wealthRequiredTodayTotal = json['wealth_required_today_total'];
    _volatileComponent = json['volatile_component'];
    _targetReturn = json['target_return'];
    _requiredSip = json['required_sip'];
  }
  AspirationsSummaryUser? _aspirationsSummaryUser;
  String? _name;
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
  num? _requiredSip;
AspirationsSummaryList copyWith({  AspirationsSummaryUser? aspirationsSummaryUser,
  String? name,
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
  String? targetReturn,
  num? requiredSip,
}) => AspirationsSummaryList(  aspirationsSummaryUser: aspirationsSummaryUser ?? _aspirationsSummaryUser,
  name: name ?? _name,
  aspirationId: aspirationId ?? _aspirationId,
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
  requiredSip: requiredSip ?? _requiredSip,
);
  AspirationsSummaryUser? get aspirationsSummaryUser => _aspirationsSummaryUser;
  String? get name => _name;
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
  num? get requiredSip => _requiredSip;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_aspirationsSummaryUser != null) {
      map['user'] = _aspirationsSummaryUser?.toJson();
    }
    map['name'] = _name;
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
    map['required_sip'] = _requiredSip;
    return map;
  }

}

/// user_id : "1218"
/// first_name : "MUKESH JINDAL"
/// last_name : ""
/// email : "jindalmukesh@gmail.com"
/// mobile : ""
/// dob : ""
/// age : ""
/// retirement_age : ""
/// life_expectancy : ""
/// tax_slab : ""
/// risk_profile : "Highly Aggressive"
/// time_horizon : ""
/// amount_invested : ""
/// is_active : "1"
/// timestamp : ""
/// username : "MUKESH81"
/// name : "MUKESH JINDAL"
/// success : 1
/// message : ""

AspirationsSummaryUser aspirationsSummaryUserFromJson(String str) => AspirationsSummaryUser.fromJson(json.decode(str));
String aspirationsSummaryUserToJson(AspirationsSummaryUser data) => json.encode(data.toJson());
class AspirationsSummaryUser {
  AspirationsSummaryUser({
      String? userId, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? mobile, 
      String? dob, 
      String? age, 
      String? retirementAge, 
      String? lifeExpectancy, 
      String? taxSlab, 
      String? riskProfile, 
      String? timeHorizon, 
      String? amountInvested, 
      String? isActive, 
      String? timestamp, 
      String? username, 
      String? name, 
      num? success, 
      String? message,}){
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _mobile = mobile;
    _dob = dob;
    _age = age;
    _retirementAge = retirementAge;
    _lifeExpectancy = lifeExpectancy;
    _taxSlab = taxSlab;
    _riskProfile = riskProfile;
    _timeHorizon = timeHorizon;
    _amountInvested = amountInvested;
    _isActive = isActive;
    _timestamp = timestamp;
    _username = username;
    _name = name;
    _success = success;
    _message = message;
}

  AspirationsSummaryUser.fromJson(dynamic json) {
    _userId = json['user_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _dob = json['dob'];
    _age = json['age'];
    _retirementAge = json['retirement_age'];
    _lifeExpectancy = json['life_expectancy'];
    _taxSlab = json['tax_slab'];
    _riskProfile = json['risk_profile'];
    _timeHorizon = json['time_horizon'];
    _amountInvested = json['amount_invested'];
    _isActive = json['is_active'];
    _timestamp = json['timestamp'];
    _username = json['username'];
    _name = json['name'];
    _success = json['success'];
    _message = json['message'];
  }
  String? _userId;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _mobile;
  String? _dob;
  String? _age;
  String? _retirementAge;
  String? _lifeExpectancy;
  String? _taxSlab;
  String? _riskProfile;
  String? _timeHorizon;
  String? _amountInvested;
  String? _isActive;
  String? _timestamp;
  String? _username;
  String? _name;
  num? _success;
  String? _message;
AspirationsSummaryUser copyWith({  String? userId,
  String? firstName,
  String? lastName,
  String? email,
  String? mobile,
  String? dob,
  String? age,
  String? retirementAge,
  String? lifeExpectancy,
  String? taxSlab,
  String? riskProfile,
  String? timeHorizon,
  String? amountInvested,
  String? isActive,
  String? timestamp,
  String? username,
  String? name,
  num? success,
  String? message,
}) => AspirationsSummaryUser(  userId: userId ?? _userId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  dob: dob ?? _dob,
  age: age ?? _age,
  retirementAge: retirementAge ?? _retirementAge,
  lifeExpectancy: lifeExpectancy ?? _lifeExpectancy,
  taxSlab: taxSlab ?? _taxSlab,
  riskProfile: riskProfile ?? _riskProfile,
  timeHorizon: timeHorizon ?? _timeHorizon,
  amountInvested: amountInvested ?? _amountInvested,
  isActive: isActive ?? _isActive,
  timestamp: timestamp ?? _timestamp,
  username: username ?? _username,
  name: name ?? _name,
  success: success ?? _success,
  message: message ?? _message,
);
  String? get userId => _userId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get dob => _dob;
  String? get age => _age;
  String? get retirementAge => _retirementAge;
  String? get lifeExpectancy => _lifeExpectancy;
  String? get taxSlab => _taxSlab;
  String? get riskProfile => _riskProfile;
  String? get timeHorizon => _timeHorizon;
  String? get amountInvested => _amountInvested;
  String? get isActive => _isActive;
  String? get timestamp => _timestamp;
  String? get username => _username;
  String? get name => _name;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['dob'] = _dob;
    map['age'] = _age;
    map['retirement_age'] = _retirementAge;
    map['life_expectancy'] = _lifeExpectancy;
    map['tax_slab'] = _taxSlab;
    map['risk_profile'] = _riskProfile;
    map['time_horizon'] = _timeHorizon;
    map['amount_invested'] = _amountInvested;
    map['is_active'] = _isActive;
    map['timestamp'] = _timestamp;
    map['username'] = _username;
    map['name'] = _name;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// user : {"user_id":"1218","first_name":"MUKESH JINDAL","last_name":"","email":"jindalmukesh@gmail.com","mobile":"","dob":"","age":"","retirement_age":"","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"","is_active":"1","timestamp":"","username":"MUKESH81","name":"MUKESH JINDAL","success":1,"message":""}
/// name : "MUKESH JINDAL"
/// aspiration_id : "302"
/// user_id : "1218"
/// start_year : "2026"
/// end_year : "2080"
/// periodicity : "5"
/// amount : "7500000"
/// aspiration_type : "Automobile"
/// classification : "Lifestyle"
/// other_aspiration : ""
/// total_outflow : "90000000"
/// total_inflation_adjusted_expense : "669162879"
/// wealth_required_today_total : "21350996"
/// volatile_component : "75%"
/// target_return : "12%"
/// required_sip : 213849

AspirationsClassified aspirationsClassifiedFromJson(String str) => AspirationsClassified.fromJson(json.decode(str));
String aspirationsClassifiedToJson(AspirationsClassified data) => json.encode(data.toJson());
class AspirationsClassified {
  AspirationsClassified({
      AspirationsClassifiedUser? aspirationsClassifiedUser, 
      String? name, 
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
      String? targetReturn, 
      num? requiredSip,}){
    _aspirationsClassifiedUser = aspirationsClassifiedUser;
    _name = name;
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
    _requiredSip = requiredSip;
}

  AspirationsClassified.fromJson(dynamic json) {
    _aspirationsClassifiedUser = json['user'] != null ? AspirationsClassifiedUser.fromJson(json['user']) : null;
    _name = json['name'];
    _aspirationId = json['aspiration_id'];
    _userId = json['user_id'];
    _startYear = json['start_year'];
    _endYear = json['end_year'];
    _periodicity = json['periodicity'] is int ? json['periodicity'].toString() : json['periodicity'];
    _amount = json['amount'];
    _aspirationType = json['aspiration_type'];
    _classification = json['classification'];
    _otherAspiration = json['other_aspiration'];
    _totalOutflow = json['total_outflow'];
    _totalInflationAdjustedExpense = json['total_inflation_adjusted_expense'];
    _wealthRequiredTodayTotal = json['wealth_required_today_total'];
    _volatileComponent = json['volatile_component'];
    _targetReturn = json['target_return'];
    _requiredSip = json['required_sip'];
  }
  AspirationsClassifiedUser? _aspirationsClassifiedUser;
  String? _name;
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
  num? _requiredSip;
AspirationsClassified copyWith({  AspirationsClassifiedUser? aspirationsClassifiedUser,
  String? name,
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
  String? targetReturn,
  num? requiredSip,
}) => AspirationsClassified(  aspirationsClassifiedUser: aspirationsClassifiedUser ?? _aspirationsClassifiedUser,
  name: name ?? _name,
  aspirationId: aspirationId ?? _aspirationId,
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
  requiredSip: requiredSip ?? _requiredSip,
);
  AspirationsClassifiedUser? get aspirationsClassifiedUser => _aspirationsClassifiedUser;
  String? get name => _name;
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
  num? get requiredSip => _requiredSip;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_aspirationsClassifiedUser != null) {
      map['user'] = _aspirationsClassifiedUser?.toJson();
    }
    map['name'] = _name;
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
    map['required_sip'] = _requiredSip;
    return map;
  }

}

/// user_id : "1218"
/// first_name : "MUKESH JINDAL"
/// last_name : ""
/// email : "jindalmukesh@gmail.com"
/// mobile : ""
/// dob : ""
/// age : ""
/// retirement_age : ""
/// life_expectancy : ""
/// tax_slab : ""
/// risk_profile : "Highly Aggressive"
/// time_horizon : ""
/// amount_invested : ""
/// is_active : "1"
/// timestamp : ""
/// username : "MUKESH81"
/// name : "MUKESH JINDAL"
/// success : 1
/// message : ""

AspirationsClassifiedUser aspirationsClassifiedUserFromJson(String str) => AspirationsClassifiedUser.fromJson(json.decode(str));
String aspirationsClassifiedUserToJson(AspirationsClassifiedUser data) => json.encode(data.toJson());
class AspirationsClassifiedUser {
  AspirationsClassifiedUser({
      String? userId, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? mobile, 
      String? dob, 
      String? age, 
      String? retirementAge, 
      String? lifeExpectancy, 
      String? taxSlab, 
      String? riskProfile, 
      String? timeHorizon, 
      String? amountInvested, 
      String? isActive, 
      String? timestamp, 
      String? username, 
      String? name, 
      num? success, 
      String? message,}){
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _mobile = mobile;
    _dob = dob;
    _age = age;
    _retirementAge = retirementAge;
    _lifeExpectancy = lifeExpectancy;
    _taxSlab = taxSlab;
    _riskProfile = riskProfile;
    _timeHorizon = timeHorizon;
    _amountInvested = amountInvested;
    _isActive = isActive;
    _timestamp = timestamp;
    _username = username;
    _name = name;
    _success = success;
    _message = message;
}

  AspirationsClassifiedUser.fromJson(dynamic json) {
    _userId = json['user_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _mobile = json['mobile'];
    _dob = json['dob'];
    _age = json['age'];
    _retirementAge = json['retirement_age'];
    _lifeExpectancy = json['life_expectancy'];
    _taxSlab = json['tax_slab'];
    _riskProfile = json['risk_profile'];
    _timeHorizon = json['time_horizon'];
    _amountInvested = json['amount_invested'];
    _isActive = json['is_active'];
    _timestamp = json['timestamp'];
    _username = json['username'];
    _name = json['name'];
    _success = json['success'];
    _message = json['message'];
  }
  String? _userId;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _mobile;
  String? _dob;
  String? _age;
  String? _retirementAge;
  String? _lifeExpectancy;
  String? _taxSlab;
  String? _riskProfile;
  String? _timeHorizon;
  String? _amountInvested;
  String? _isActive;
  String? _timestamp;
  String? _username;
  String? _name;
  num? _success;
  String? _message;
AspirationsClassifiedUser copyWith({  String? userId,
  String? firstName,
  String? lastName,
  String? email,
  String? mobile,
  String? dob,
  String? age,
  String? retirementAge,
  String? lifeExpectancy,
  String? taxSlab,
  String? riskProfile,
  String? timeHorizon,
  String? amountInvested,
  String? isActive,
  String? timestamp,
  String? username,
  String? name,
  num? success,
  String? message,
}) => AspirationsClassifiedUser(  userId: userId ?? _userId,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  dob: dob ?? _dob,
  age: age ?? _age,
  retirementAge: retirementAge ?? _retirementAge,
  lifeExpectancy: lifeExpectancy ?? _lifeExpectancy,
  taxSlab: taxSlab ?? _taxSlab,
  riskProfile: riskProfile ?? _riskProfile,
  timeHorizon: timeHorizon ?? _timeHorizon,
  amountInvested: amountInvested ?? _amountInvested,
  isActive: isActive ?? _isActive,
  timestamp: timestamp ?? _timestamp,
  username: username ?? _username,
  name: name ?? _name,
  success: success ?? _success,
  message: message ?? _message,
);
  String? get userId => _userId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get dob => _dob;
  String? get age => _age;
  String? get retirementAge => _retirementAge;
  String? get lifeExpectancy => _lifeExpectancy;
  String? get taxSlab => _taxSlab;
  String? get riskProfile => _riskProfile;
  String? get timeHorizon => _timeHorizon;
  String? get amountInvested => _amountInvested;
  String? get isActive => _isActive;
  String? get timestamp => _timestamp;
  String? get username => _username;
  String? get name => _name;
  num? get success => _success;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['dob'] = _dob;
    map['age'] = _age;
    map['retirement_age'] = _retirementAge;
    map['life_expectancy'] = _lifeExpectancy;
    map['tax_slab'] = _taxSlab;
    map['risk_profile'] = _riskProfile;
    map['time_horizon'] = _timeHorizon;
    map['amount_invested'] = _amountInvested;
    map['is_active'] = _isActive;
    map['timestamp'] = _timestamp;
    map['username'] = _username;
    map['name'] = _name;
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }

}

/// asset_class : "Volatile"
/// allocation : "90"
/// expected_return : "14"

RiskProfileAllocation riskProfileAllocationFromJson(String str) => RiskProfileAllocation.fromJson(json.decode(str));
String riskProfileAllocationToJson(RiskProfileAllocation data) => json.encode(data.toJson());
class RiskProfileAllocation {
  RiskProfileAllocation({
      String? assetClass, 
      String? allocation, 
      String? expectedReturn,}){
    _assetClass = assetClass;
    _allocation = allocation;
    _expectedReturn = expectedReturn;
}

  RiskProfileAllocation.fromJson(dynamic json) {
    _assetClass = json['asset_class'];
    _allocation = json['allocation'];
    _expectedReturn = json['expected_return'];
  }
  String? _assetClass;
  String? _allocation;
  String? _expectedReturn;
RiskProfileAllocation copyWith({  String? assetClass,
  String? allocation,
  String? expectedReturn,
}) => RiskProfileAllocation(  assetClass: assetClass ?? _assetClass,
  allocation: allocation ?? _allocation,
  expectedReturn: expectedReturn ?? _expectedReturn,
);
  String? get assetClass => _assetClass;
  String? get allocation => _allocation;
  String? get expectedReturn => _expectedReturn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['asset_class'] = _assetClass;
    map['allocation'] = _allocation;
    map['expected_return'] = _expectedReturn;
    return map;
  }

}

/// user_name : "MUKESH JINDAL "
/// first_name : "MUKESH JINDAL"
/// action_points : null
/// last_name : ""
/// life_expectancy : null
/// risk_profile : "Highly Aggressive"
/// time_horizon : ""
/// asset_allocation : null
/// expected_return : 7
/// objective : "Comfortable Lifestyle"
/// success : 1

LinkedUser linkedUserFromJson(String str) => LinkedUser.fromJson(json.decode(str));
String linkedUserToJson(LinkedUser data) => json.encode(data.toJson());
class LinkedUser {
  LinkedUser({
      String? userName, 
      String? firstName, 
      dynamic actionPoints, 
      String? lastName, 
      dynamic lifeExpectancy, 
      String? riskProfile, 
      String? timeHorizon, 
      dynamic assetAllocation, 
      num? expectedReturn, 
      String? objective, 
      num? success,}){
    _userName = userName;
    _firstName = firstName;
    _actionPoints = actionPoints;
    _lastName = lastName;
    _lifeExpectancy = lifeExpectancy;
    _riskProfile = riskProfile;
    _timeHorizon = timeHorizon;
    _assetAllocation = assetAllocation;
    _expectedReturn = expectedReturn;
    _objective = objective;
    _success = success;
}

  LinkedUser.fromJson(dynamic json) {
    _userName = json['user_name'];
    _firstName = json['first_name'];
    _actionPoints = json['action_points'];
    _lastName = json['last_name'];
    _lifeExpectancy = json['life_expectancy'];
    _riskProfile = json['risk_profile'];
    _timeHorizon = json['time_horizon'];
    _assetAllocation = json['asset_allocation'];
    _expectedReturn = json['expected_return'];
    _objective = json['objective'];
    _success = json['success'];
  }
  String? _userName;
  String? _firstName;
  dynamic _actionPoints;
  String? _lastName;
  dynamic _lifeExpectancy;
  String? _riskProfile;
  String? _timeHorizon;
  dynamic _assetAllocation;
  num? _expectedReturn;
  String? _objective;
  num? _success;
LinkedUser copyWith({  String? userName,
  String? firstName,
  dynamic actionPoints,
  String? lastName,
  dynamic lifeExpectancy,
  String? riskProfile,
  String? timeHorizon,
  dynamic assetAllocation,
  num? expectedReturn,
  String? objective,
  num? success,
}) => LinkedUser(  userName: userName ?? _userName,
  firstName: firstName ?? _firstName,
  actionPoints: actionPoints ?? _actionPoints,
  lastName: lastName ?? _lastName,
  lifeExpectancy: lifeExpectancy ?? _lifeExpectancy,
  riskProfile: riskProfile ?? _riskProfile,
  timeHorizon: timeHorizon ?? _timeHorizon,
  assetAllocation: assetAllocation ?? _assetAllocation,
  expectedReturn: expectedReturn ?? _expectedReturn,
  objective: objective ?? _objective,
  success: success ?? _success,
);
  String? get userName => _userName;
  String? get firstName => _firstName;
  dynamic get actionPoints => _actionPoints;
  String? get lastName => _lastName;
  dynamic get lifeExpectancy => _lifeExpectancy;
  String? get riskProfile => _riskProfile;
  String? get timeHorizon => _timeHorizon;
  dynamic get assetAllocation => _assetAllocation;
  num? get expectedReturn => _expectedReturn;
  String? get objective => _objective;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = _userName;
    map['first_name'] = _firstName;
    map['action_points'] = _actionPoints;
    map['last_name'] = _lastName;
    map['life_expectancy'] = _lifeExpectancy;
    map['risk_profile'] = _riskProfile;
    map['time_horizon'] = _timeHorizon;
    map['asset_allocation'] = _assetAllocation;
    map['expected_return'] = _expectedReturn;
    map['objective'] = _objective;
    map['success'] = _success;
    return map;
  }

}

/// user_name : "MUKESH JINDAL "
/// first_name : "MUKESH JINDAL"
/// action_points : null
/// last_name : ""
/// life_expectancy : null
/// risk_profile : "Highly Aggressive"
/// time_horizon : ""
/// asset_allocation : null
/// expected_return : 7
/// objective : "Comfortable Lifestyle"
/// success : 1

UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));
String userDetailsToJson(UserDetails data) => json.encode(data.toJson());
class UserDetails {
  UserDetails({
    String? userName,
    String? firstName,
    dynamic actionPoints,
    String? lastName,
    dynamic lifeExpectancy,
    String? riskProfile,
    String? timeHorizon,
    dynamic assetAllocation,
    num? expectedReturn,
    String? objective,
    num? success,}) {
    _userName = userName;
    _firstName = firstName;
    _actionPoints = actionPoints;
    _lastName = lastName;
    _lifeExpectancy = lifeExpectancy;
    _riskProfile = riskProfile;
    _timeHorizon = timeHorizon;
    _assetAllocation = assetAllocation;
    _expectedReturn = expectedReturn;
    _objective = objective;
    _success = success;
  }

  UserDetails.fromJson(dynamic json) {
    _userName = json['user_name'];
    _firstName = json['first_name'];
    _actionPoints = json['action_points'];
    _lastName = json['last_name'];
    _lifeExpectancy = json['life_expectancy'];
    _riskProfile = json['risk_profile'];
    _timeHorizon = json['time_horizon'];
    _assetAllocation = json['asset_allocation'];
    _expectedReturn = json['expected_return'];
    _objective = json['objective'];
    _success = json['success'];
  }

  String? _userName;
  String? _firstName;
  dynamic _actionPoints;
  String? _lastName;
  dynamic _lifeExpectancy;
  String? _riskProfile;
  String? _timeHorizon;
  dynamic _assetAllocation;
  num? _expectedReturn;
  String? _objective;
  num? _success;

  UserDetails copyWith({ String? userName,
    String? firstName,
    dynamic actionPoints,
    String? lastName,
    dynamic lifeExpectancy,
    String? riskProfile,
    String? timeHorizon,
    dynamic assetAllocation,
    num? expectedReturn,
    String? objective,
    num? success,
  }) =>
      UserDetails(userName: userName ?? _userName,
        firstName: firstName ?? _firstName,
        actionPoints: actionPoints ?? _actionPoints,
        lastName: lastName ?? _lastName,
        lifeExpectancy: lifeExpectancy ?? _lifeExpectancy,
        riskProfile: riskProfile ?? _riskProfile,
        timeHorizon: timeHorizon ?? _timeHorizon,
        assetAllocation: assetAllocation ?? _assetAllocation,
        expectedReturn: expectedReturn ?? _expectedReturn,
        objective: objective ?? _objective,
        success: success ?? _success,
      );

  String? get userName => _userName;

  String? get firstName => _firstName;

  dynamic get actionPoints => _actionPoints;

  String? get lastName => _lastName;

  dynamic get lifeExpectancy => _lifeExpectancy;

  String? get riskProfile => _riskProfile;

  String? get timeHorizon => _timeHorizon;

  dynamic get assetAllocation => _assetAllocation;

  num? get expectedReturn => _expectedReturn;

  String? get objective => _objective;

  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = _userName;
    map['first_name'] = _firstName;
    map['action_points'] = _actionPoints;
    map['last_name'] = _lastName;
    map['life_expectancy'] = _lifeExpectancy;
    map['risk_profile'] = _riskProfile;
    map['time_horizon'] = _timeHorizon;
    map['asset_allocation'] = _assetAllocation;
    map['expected_return'] = _expectedReturn;
    map['objective'] = _objective;
    map['success'] = _success;
    return map;
  }
}