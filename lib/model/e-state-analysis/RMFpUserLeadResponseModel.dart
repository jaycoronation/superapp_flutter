import 'dart:convert';
/// success : 1
/// user_lead_data : [{"user_id":"2100","first_name":"Akshay Aneja","last_name":"","email":"","mobile":"","dob":"","age":"31","retirement_age":"0","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"0","password":"","verification_key":"","reset_token":"","is_active":"1","timestamp":"1774856423","action_points":null,"asset_allocation":null,"cash_flow_graph":null,"username":null,"direct_user":"1","portfolio_rm_id":"15","portfolio_rm_name":"Manjeet Singh","city":"New Delhi","linked_portfolio_username":null,"linked_portfolio_name":null,"is_linked":null,"deleted_at":null,"spouse_name":"Mehak","spouse_age":"31","child_details":"[{\"name\":\"Gaurish\",\"age\":\"4\"},{\"name\":\"Child -2\",\"age\":\"0\"}]","name":"Akshay Aneja","last_access":"30th March, 2026","linked_user_id":null},{"user_id":"2076","first_name":"Manoj Hirpara","last_name":"","email":"","mobile":"","dob":null,"age":"40","retirement_age":"0","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"0","password":null,"verification_key":null,"reset_token":null,"is_active":"1","timestamp":"1774677028","action_points":null,"asset_allocation":null,"cash_flow_graph":null,"username":null,"direct_user":"1","portfolio_rm_id":"15","portfolio_rm_name":"Manjeet Singh","city":"Surat","linked_portfolio_username":null,"linked_portfolio_name":null,"is_linked":null,"deleted_at":null,"spouse_name":"","spouse_age":"","child_details":"[{\"name\":\"\",\"age\":\"\"}]","name":"Manoj Hirpara","last_access":"28th March, 2026","linked_user_id":null},{"user_id":"2065","first_name":"Ayush Singh","last_name":"","email":"","mobile":"","dob":null,"age":"25","retirement_age":"0","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"0","password":null,"verification_key":null,"reset_token":null,"is_active":"1","timestamp":"1774605778","action_points":null,"asset_allocation":null,"cash_flow_graph":null,"username":null,"direct_user":"1","portfolio_rm_id":"15","portfolio_rm_name":"Manjeet Singh","city":"Gurgaon","linked_portfolio_username":null,"linked_portfolio_name":null,"is_linked":null,"deleted_at":null,"spouse_name":"XYZ","spouse_age":"28","child_details":"[{\"name\":\"ABC\",\"age\":\"2\"}]","name":"Ayush Singh","last_access":"27th March, 2026","linked_user_id":null},{"user_id":"2062","first_name":"Rohit Khurana","last_name":"","email":"","mobile":"","dob":null,"age":"49","retirement_age":"0","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"0","password":null,"verification_key":null,"reset_token":null,"is_active":"1","timestamp":"1774597590","action_points":null,"asset_allocation":null,"cash_flow_graph":null,"username":null,"direct_user":"1","portfolio_rm_id":"15","portfolio_rm_name":"Manjeet Singh","city":"Rohtak","linked_portfolio_username":null,"linked_portfolio_name":null,"is_linked":null,"deleted_at":null,"spouse_name":"Kirti Khurana","spouse_age":"43","child_details":"[{\"name\":\"vanya Khurana\",\"age\":\"19\"},{\"name\":\"Kebin Khurana\",\"age\":\"9\"}]","name":"Rohit Khurana","last_access":"27th March, 2026","linked_user_id":null},{"user_id":"2048","first_name":"Paras","last_name":"","email":"","mobile":"","dob":null,"age":"27","retirement_age":"0","life_expectancy":"","tax_slab":"","risk_profile":"Aggressive","time_horizon":"","amount_invested":"0","password":null,"verification_key":null,"reset_token":null,"is_active":"1","timestamp":"1774519724","action_points":null,"asset_allocation":null,"cash_flow_graph":null,"username":null,"direct_user":"1","portfolio_rm_id":"15","portfolio_rm_name":"Manjeet Singh","city":"mathura","linked_portfolio_username":null,"linked_portfolio_name":null,"is_linked":null,"deleted_at":null,"spouse_name":"NA","spouse_age":"","child_details":"[{\"name\":\"\",\"age\":\"\"}]","name":"Paras","last_access":"26th March, 2026","linked_user_id":null},{"user_id":"2031","first_name":"Amrit Khater","last_name":"","email":"","mobile":"","dob":null,"age":"38","retirement_age":"0","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"0","password":null,"verification_key":null,"reset_token":null,"is_active":"1","timestamp":"1774501702","action_points":null,"asset_allocation":"[{\"asset_class\":\"Volatile\",\"allocation_pct\":40,\"expected_return\":14},{\"asset_class\":\"Fixed Income\",\"allocation_pct\":10,\"expected_return\":7},{\"asset_class\":\"Real Estate\",\"allocation_pct\":50,\"expected_return\":10}]","cash_flow_graph":null,"username":null,"direct_user":"1","portfolio_rm_id":"15","portfolio_rm_name":"Manjeet Singh","city":"Delhi","linked_portfolio_username":null,"linked_portfolio_name":null,"is_linked":null,"deleted_at":null,"spouse_name":"Jyotsna ","spouse_age":"38","child_details":"[{\"name\":\"Tathagat\",\"age\":\"7\"},{\"name\":\"Nitara\",\"age\":\"3\"}]","name":"Amrit Khater","last_access":"26th March, 2026","linked_user_id":null},{"user_id":"2013","first_name":"Amandeep Kaur","last_name":"","email":"","mobile":"","dob":null,"age":"37","retirement_age":"0","life_expectancy":"","tax_slab":"","risk_profile":"Aggressive","time_horizon":"","amount_invested":"0","password":null,"verification_key":null,"reset_token":null,"is_active":"1","timestamp":"1774438483","action_points":null,"asset_allocation":null,"cash_flow_graph":null,"username":null,"direct_user":"1","portfolio_rm_id":"15","portfolio_rm_name":"Manjeet Singh","city":"UP","linked_portfolio_username":null,"linked_portfolio_name":null,"is_linked":null,"deleted_at":null,"spouse_name":"varun Kohli","spouse_age":"39","child_details":"[{\"name\":\"ayansh Kohli\",\"age\":\"9\"}]","name":"Amandeep Kaur","last_access":"25th March, 2026","linked_user_id":null},{"user_id":"2009","first_name":"Deepak Goel","last_name":"","email":"","mobile":"","dob":null,"age":"47","retirement_age":"0","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"0","password":null,"verification_key":null,"reset_token":null,"is_active":"1","timestamp":"1774434974","action_points":null,"asset_allocation":null,"cash_flow_graph":null,"username":null,"direct_user":"1","portfolio_rm_id":"15","portfolio_rm_name":"Manjeet Singh","city":"Agra","linked_portfolio_username":null,"linked_portfolio_name":null,"is_linked":null,"deleted_at":null,"spouse_name":"Shivani Goel","spouse_age":"44","child_details":"[{\"name\":\"Tejas Goel\",\"age\":\"22\"},{\"name\":\"Piyush Goel\",\"age\":\"17\"}]","name":"Deepak Goel","last_access":"25th March, 2026","linked_user_id":null},{"user_id":"2006","first_name":"Shivang Agarwal","last_name":"","email":"","mobile":"","dob":null,"age":"35","retirement_age":"0","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"0","password":null,"verification_key":null,"reset_token":null,"is_active":"1","timestamp":"1774431769","action_points":null,"asset_allocation":null,"cash_flow_graph":null,"username":null,"direct_user":"1","portfolio_rm_id":"15","portfolio_rm_name":"Manjeet Singh","city":"Agra","linked_portfolio_username":null,"linked_portfolio_name":null,"is_linked":null,"deleted_at":null,"spouse_name":"Sonia Agarwal","spouse_age":"35","child_details":"[{\"name\":\"Vedaaksh Agarwal\",\"age\":\"1\"}]","name":"Shivang Agarwal","last_access":"25th March, 2026","linked_user_id":null},{"user_id":"1910","first_name":"Dhruv Bhatia","last_name":"","email":"","mobile":"","dob":"840738600","age":"30","retirement_age":"0","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"0","password":null,"verification_key":null,"reset_token":null,"is_active":"1","timestamp":"1774151291","action_points":null,"asset_allocation":null,"cash_flow_graph":null,"username":null,"direct_user":"1","portfolio_rm_id":"15","portfolio_rm_name":"Manjeet Singh","city":"Dehradun","linked_portfolio_username":null,"linked_portfolio_name":null,"is_linked":null,"deleted_at":null,"spouse_name":"","spouse_age":"","child_details":"","name":"Dhruv Bhatia","last_access":"22nd March, 2026","linked_user_id":null},{"user_id":"1906","first_name":"Rohit Arya","last_name":"","email":"","mobile":"","dob":"154031400","age":"52","retirement_age":"0","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"0","password":null,"verification_key":null,"reset_token":null,"is_active":"1","timestamp":"1774090306","action_points":null,"asset_allocation":null,"cash_flow_graph":null,"username":null,"direct_user":"1","portfolio_rm_id":"15","portfolio_rm_name":"Manjeet Singh","city":"Sonipat","linked_portfolio_username":null,"linked_portfolio_name":null,"is_linked":null,"deleted_at":null,"spouse_name":"","spouse_age":"","child_details":"","name":"Rohit Arya","last_access":"21st March, 2026","linked_user_id":null},{"user_id":"1897","first_name":"Rohan Sharma","last_name":"","email":"","mobile":"","dob":"521663400","age":"40","retirement_age":"0","life_expectancy":"","tax_slab":"","risk_profile":"","time_horizon":"","amount_invested":"0","password":null,"verification_key":null,"reset_token":null,"is_active":"1","timestamp":"1774082648","action_points":null,"asset_allocation":null,"cash_flow_graph":null,"username":null,"direct_user":"1","portfolio_rm_id":"15","portfolio_rm_name":"Manjeet Singh","city":"New Delhi","linked_portfolio_username":null,"linked_portfolio_name":null,"is_linked":null,"deleted_at":null,"spouse_name":"","spouse_age":"","child_details":"","name":"Rohan Sharma","last_access":"23rd March, 2026","linked_user_id":null},{"user_id":"1895","first_name":"Rajesh Agarwal","last_name":"","email":"","mobile":"","dob":"122409000","age":"53","retirement_age":"0","life_expectancy":"","tax_slab":"","risk_profile":"Highly Aggressive","time_horizon":"","amount_invested":"0","password":null,"verification_key":null,"reset_token":null,"is_active":"1","timestamp":"1774079264","action_points":null,"asset_allocation":null,"cash_flow_graph":null,"username":null,"direct_user":"1","portfolio_rm_id":"15","portfolio_rm_name":"Manjeet Singh","city":"Delhi","linked_portfolio_username":null,"linked_portfolio_name":null,"is_linked":null,"deleted_at":null,"spouse_name":"","spouse_age":"","child_details":"","name":"Rajesh Agarwal","last_access":"21st March, 2026","linked_user_id":null},{"user_id":"1802","first_name":"Satwant Singh","last_name":"","email":"","mobile":"","dob":"-117523800","age":"60","retirement_age":"0","life_expectancy":"","tax_slab":"","risk_profile":"","time_horizon":"","amount_invested":"0","password":null,"verification_key":null,"reset_token":null,"is_active":"1","timestamp":"1772796805","action_points":null,"asset_allocation":null,"cash_flow_graph":null,"username":null,"direct_user":"1","portfolio_rm_id":"15","portfolio_rm_name":"Manjeet Singh","city":"Delhi","linked_portfolio_username":null,"linked_portfolio_name":null,"is_linked":null,"deleted_at":null,"spouse_name":"","spouse_age":"","child_details":"","name":"Satwant Singh","last_access":"14th March, 2026","linked_user_id":null}]
/// total_records : 14
/// message : "Users fetched successfully"

RmFpUserLeadResponseModel rmFpUserLeadResponseModelFromJson(String str) => RmFpUserLeadResponseModel.fromJson(json.decode(str));
String rmFpUserLeadResponseModelToJson(RmFpUserLeadResponseModel data) => json.encode(data.toJson());
class RmFpUserLeadResponseModel {
  RmFpUserLeadResponseModel({
      num? success, 
      List<UserLeadData>? userLeadData, 
      num? totalRecords, 
      String? message,}){
    _success = success;
    _userLeadData = userLeadData;
    _totalRecords = totalRecords;
    _message = message;
}

  RmFpUserLeadResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _userLeadData = [];
      json['data'].forEach((v) {
        _userLeadData?.add(UserLeadData.fromJson(v));
      });
    }
    _totalRecords = json['total_records'];
    _message = json['message'];
  }
  num? _success;
  List<UserLeadData>? _userLeadData;
  num? _totalRecords;
  String? _message;
RmFpUserLeadResponseModel copyWith({  num? success,
  List<UserLeadData>? userLeadData,
  num? totalRecords,
  String? message,
}) => RmFpUserLeadResponseModel(  success: success ?? _success,
  userLeadData: userLeadData ?? _userLeadData,
  totalRecords: totalRecords ?? _totalRecords,
  message: message ?? _message,
);
  num? get success => _success;
  List<UserLeadData>? get userLeadData => _userLeadData;
  num? get totalRecords => _totalRecords;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_userLeadData != null) {
      map['data'] = _userLeadData?.map((v) => v.toJson()).toList();
    }
    map['total_records'] = _totalRecords;
    map['message'] = _message;
    return map;
  }

}

/// user_id : "2100"
/// first_name : "Akshay Aneja"
/// last_name : ""
/// email : ""
/// mobile : ""
/// dob : ""
/// age : "31"
/// retirement_age : "0"
/// life_expectancy : ""
/// tax_slab : ""
/// risk_profile : "Highly Aggressive"
/// time_horizon : ""
/// amount_invested : "0"
/// password : ""
/// verification_key : ""
/// reset_token : ""
/// is_active : "1"
/// timestamp : "1774856423"
/// action_points : null
/// asset_allocation : null
/// cash_flow_graph : null
/// username : null
/// direct_user : "1"
/// portfolio_rm_id : "15"
/// portfolio_rm_name : "Manjeet Singh"
/// city : "New Delhi"
/// linked_portfolio_username : null
/// linked_portfolio_name : null
/// is_linked : null
/// deleted_at : null
/// spouse_name : "Mehak"
/// spouse_age : "31"
/// child_details : "[{\"name\":\"Gaurish\",\"age\":\"4\"},{\"name\":\"Child -2\",\"age\":\"0\"}]"
/// name : "Akshay Aneja"
/// last_access : "30th March, 2026"
/// linked_user_id : null

UserLeadData userLeadDataFromJson(String str) => UserLeadData.fromJson(json.decode(str));
String userLeadDataToJson(UserLeadData data) => json.encode(data.toJson());
class UserLeadData {
  UserLeadData({
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
      String? password, 
      String? verificationKey, 
      String? resetToken, 
      String? isActive, 
      String? timestamp, 
      dynamic actionPoints, 
      dynamic assetAllocation, 
      dynamic cashFlowGraph,
      String? username,
      String? directUser, 
      String? portfolioRmId, 
      String? portfolioRmName, 
      String? city, 
      String? linkedPortfolioUsername,
      String? linkedPortfolioName,
      String? isLinked,
      String? deletedAt,
      String? spouseName, 
      String? spouseAge, 
      String? childDetails, 
      String? name, 
      String? lastAccess,
      String? linkedUserId,}){
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
    _password = password;
    _verificationKey = verificationKey;
    _resetToken = resetToken;
    _isActive = isActive;
    _timestamp = timestamp;
    _actionPoints = actionPoints;
    _assetAllocation = assetAllocation;
    _cashFlowGraph = cashFlowGraph;
    _username = username;
    _directUser = directUser;
    _portfolioRmId = portfolioRmId;
    _portfolioRmName = portfolioRmName;
    _city = city;
    _linkedPortfolioUsername = linkedPortfolioUsername;
    _linkedPortfolioName = linkedPortfolioName;
    _isLinked = isLinked;
    _deletedAt = deletedAt;
    _spouseName = spouseName;
    _spouseAge = spouseAge;
    _childDetails = childDetails;
    _name = name;
    _lastAccess = lastAccess;
    _linkedUserId = linkedUserId;
}

  UserLeadData.fromJson(dynamic json) {
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
    _password = json['password'];
    _verificationKey = json['verification_key'];
    _resetToken = json['reset_token'];
    _isActive = json['is_active'];
    _timestamp = json['timestamp'];
    _actionPoints = json['action_points'];
    _assetAllocation = json['asset_allocation'];
    _cashFlowGraph = json['cash_flow_graph'];
    _username = json['username'];
    _directUser = json['direct_user'];
    _portfolioRmId = json['portfolio_rm_id'];
    _portfolioRmName = json['portfolio_rm_name'];
    _city = json['city'];
    _linkedPortfolioUsername = json['linked_portfolio_username'];
    _linkedPortfolioName = json['linked_portfolio_name'];
    _isLinked = json['is_linked'];
    _deletedAt = json['deleted_at'];
    _spouseName = json['spouse_name'];
    _spouseAge = json['spouse_age'];
    _childDetails = json['child_details'];
    _name = json['name'];
    _lastAccess = json['last_access'];
    _linkedUserId = json['linked_user_id'];
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
  String? _password;
  String? _verificationKey;
  String? _resetToken;
  String? _isActive;
  String? _timestamp;
  dynamic _actionPoints;
  dynamic _assetAllocation;
  dynamic _cashFlowGraph;
  String? _username;
  String? _directUser;
  String? _portfolioRmId;
  String? _portfolioRmName;
  String? _city;
  String? _linkedPortfolioUsername;
  String? _linkedPortfolioName;
  String? _isLinked;
  String? _deletedAt;
  String? _spouseName;
  String? _spouseAge;
  String? _childDetails;
  String? _name;
  String? _lastAccess;
  String? _linkedUserId;
UserLeadData copyWith({  String? userId,
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
  String? password,
  String? verificationKey,
  String? resetToken,
  String? isActive,
  String? timestamp,
  dynamic actionPoints,
  dynamic assetAllocation,
  dynamic cashFlowGraph,
  String? username,
  String? directUser,
  String? portfolioRmId,
  String? portfolioRmName,
  String? city,
  String? linkedPortfolioUsername,
  String? linkedPortfolioName,
  String? isLinked,
  String? deletedAt,
  String? spouseName,
  String? spouseAge,
  String? childDetails,
  String? name,
  String? lastAccess,
  String? linkedUserId,
}) => UserLeadData(  userId: userId ?? _userId,
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
  password: password ?? _password,
  verificationKey: verificationKey ?? _verificationKey,
  resetToken: resetToken ?? _resetToken,
  isActive: isActive ?? _isActive,
  timestamp: timestamp ?? _timestamp,
  actionPoints: actionPoints ?? _actionPoints,
  assetAllocation: assetAllocation ?? _assetAllocation,
  cashFlowGraph: cashFlowGraph ?? _cashFlowGraph,
  username: username ?? _username,
  directUser: directUser ?? _directUser,
  portfolioRmId: portfolioRmId ?? _portfolioRmId,
  portfolioRmName: portfolioRmName ?? _portfolioRmName,
  city: city ?? _city,
  linkedPortfolioUsername: linkedPortfolioUsername ?? _linkedPortfolioUsername,
  linkedPortfolioName: linkedPortfolioName ?? _linkedPortfolioName,
  isLinked: isLinked ?? _isLinked,
  deletedAt: deletedAt ?? _deletedAt,
  spouseName: spouseName ?? _spouseName,
  spouseAge: spouseAge ?? _spouseAge,
  childDetails: childDetails ?? _childDetails,
  name: name ?? _name,
  lastAccess: lastAccess ?? _lastAccess,
  linkedUserId: linkedUserId ?? _linkedUserId,
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
  String? get password => _password;
  String? get verificationKey => _verificationKey;
  String? get resetToken => _resetToken;
  String? get isActive => _isActive;
  String? get timestamp => _timestamp;
  dynamic get actionPoints => _actionPoints;
  dynamic get assetAllocation => _assetAllocation;
  dynamic get cashFlowGraph => _cashFlowGraph;
  String? get username => _username;
  String? get directUser => _directUser;
  String? get portfolioRmId => _portfolioRmId;
  String? get portfolioRmName => _portfolioRmName;
  String? get city => _city;
  String? get linkedPortfolioUsername => _linkedPortfolioUsername;
  String? get linkedPortfolioName => _linkedPortfolioName;
  String? get isLinked => _isLinked;
  String? get deletedAt => _deletedAt;
  String? get spouseName => _spouseName;
  String? get spouseAge => _spouseAge;
  String? get childDetails => _childDetails;
  String? get name => _name;
  String? get lastAccess => _lastAccess;
  String? get linkedUserId => _linkedUserId;

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
    map['password'] = _password;
    map['verification_key'] = _verificationKey;
    map['reset_token'] = _resetToken;
    map['is_active'] = _isActive;
    map['timestamp'] = _timestamp;
    map['action_points'] = _actionPoints;
    map['asset_allocation'] = _assetAllocation;
    map['cash_flow_graph'] = _cashFlowGraph;
    map['username'] = _username;
    map['direct_user'] = _directUser;
    map['portfolio_rm_id'] = _portfolioRmId;
    map['portfolio_rm_name'] = _portfolioRmName;
    map['city'] = _city;
    map['linked_portfolio_username'] = _linkedPortfolioUsername;
    map['linked_portfolio_name'] = _linkedPortfolioName;
    map['is_linked'] = _isLinked;
    map['deleted_at'] = _deletedAt;
    map['spouse_name'] = _spouseName;
    map['spouse_age'] = _spouseAge;
    map['child_details'] = _childDetails;
    map['name'] = _name;
    map['last_access'] = _lastAccess;
    map['linked_user_id'] = _linkedUserId;
    return map;
  }

}