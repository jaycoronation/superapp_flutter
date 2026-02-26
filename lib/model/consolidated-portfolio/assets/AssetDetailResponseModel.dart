import 'dart:convert';
/// assets_details : {"investment_type":"34","category":"","asset_class":"Hybrid","scheme_name":"","transaction_type":"","transaction_date":"","amount_invested":"5000","quantity":1,"purchase_price":"","current_price":"250","current_value":250,"folio_no_account_no":"","interest_rate":"","payout_cumulative":"","maturity_date":"","property_name":"","area":"","total_value":"","loan_outstanding":"","leased_not_leased":"","monthly_rental":"","isin_no":"","first_holder":"MUKESH JINDAL","second_holder":"","nominee":"","broker_advisor":"No","bank_details":"Bob bank ","notes":"Testing by developer ","property_address":"","premium":"","premium_start_date":"","number_of_premiums_paid":"","total_premiums_paid":"","premium_end_date":"","sum_assured":"","premium_frequency":"","policy_number":"","policy_holder":"","given_to_whom":"","company_name":"Stock plazza","date":"02-26-2026","loan_amount":"","number_of_shares":"2500","vested_unvested":"No","amount_pending":"","transactions":[],"update_history":"","history":[{"message":"Added by   on 26-02-2026 02:47 PM"}]}
/// success : 1

AssetDetailResponseModel assetDetailResponseModelFromJson(String str) => AssetDetailResponseModel.fromJson(json.decode(str));
String assetDetailResponseModelToJson(AssetDetailResponseModel data) => json.encode(data.toJson());
class AssetDetailResponseModel {
  AssetDetailResponseModel({
      AssetsDetails? assetsDetails, 
      num? success,}){
    _assetsDetails = assetsDetails;
    _success = success;
}

  AssetDetailResponseModel.fromJson(dynamic json) {
    _assetsDetails = json['assets_details'] != null ? AssetsDetails.fromJson(json['assets_details']) : null;
    _success = json['success'];
  }
  AssetsDetails? _assetsDetails;
  num? _success;
AssetDetailResponseModel copyWith({  AssetsDetails? assetsDetails,
  num? success,
}) => AssetDetailResponseModel(  assetsDetails: assetsDetails ?? _assetsDetails,
  success: success ?? _success,
);
  AssetsDetails? get assetsDetails => _assetsDetails;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_assetsDetails != null) {
      map['assets_details'] = _assetsDetails?.toJson();
    }
    map['success'] = _success;
    return map;
  }

}

/// investment_type : "34"
/// category : ""
/// asset_class : "Hybrid"
/// scheme_name : ""
/// transaction_type : ""
/// transaction_date : ""
/// amount_invested : "5000"
/// quantity : 1
/// purchase_price : ""
/// current_price : "250"
/// current_value : 250
/// folio_no_account_no : ""
/// interest_rate : ""
/// payout_cumulative : ""
/// maturity_date : ""
/// property_name : ""
/// area : ""
/// total_value : ""
/// loan_outstanding : ""
/// leased_not_leased : ""
/// monthly_rental : ""
/// isin_no : ""
/// first_holder : "MUKESH JINDAL"
/// second_holder : ""
/// nominee : ""
/// broker_advisor : "No"
/// bank_details : "Bob bank "
/// notes : "Testing by developer "
/// property_address : ""
/// premium : ""
/// premium_start_date : ""
/// number_of_premiums_paid : ""
/// total_premiums_paid : ""
/// premium_end_date : ""
/// sum_assured : ""
/// premium_frequency : ""
/// policy_number : ""
/// policy_holder : ""
/// given_to_whom : ""
/// company_name : "Stock plazza"
/// date : "02-26-2026"
/// loan_amount : ""
/// number_of_shares : "2500"
/// vested_unvested : "No"
/// amount_pending : ""
/// transactions : []
/// update_history : ""
/// history : [{"message":"Added by   on 26-02-2026 02:47 PM"}]

AssetsDetails assetsDetailsFromJson(String str) => AssetsDetails.fromJson(json.decode(str));
String assetsDetailsToJson(AssetsDetails data) => json.encode(data.toJson());
class AssetsDetails {
  AssetsDetails({
      String? investmentType, 
      String? category, 
      String? assetClass, 
      String? schemeName, 
      String? transactionType, 
      String? transactionDate, 
      String? amountInvested, 
      String? quantity,
      String? purchasePrice, 
      String? currentPrice, 
      String? currentValue,
      String? folioNoAccountNo, 
      String? interestRate, 
      String? payoutCumulative, 
      String? maturityDate, 
      String? propertyName, 
      String? area, 
      String? totalValue, 
      String? loanOutstanding, 
      String? leasedNotLeased, 
      String? monthlyRental, 
      String? isinNo, 
      String? firstHolder, 
      String? secondHolder, 
      String? nominee, 
      String? brokerAdvisor, 
      String? bankDetails, 
      String? notes, 
      String? propertyAddress, 
      String? premium, 
      String? premiumStartDate, 
      String? numberOfPremiumsPaid, 
      String? totalPremiumsPaid, 
      String? premiumEndDate, 
      String? sumAssured, 
      String? premiumFrequency, 
      String? policyNumber, 
      String? policyHolder, 
      String? givenToWhom, 
      String? companyName, 
      String? date, 
      String? loanAmount, 
      String? numberOfShares, 
      String? vestedUnvested, 
      String? amountPending, 
      List<dynamic>? transactions, 
      String? updateHistory, 
      List<History>? history,}){
    _investmentType = investmentType;
    _category = category;
    _assetClass = assetClass;
    _schemeName = schemeName;
    _transactionType = transactionType;
    _transactionDate = transactionDate;
    _amountInvested = amountInvested;
    _quantity = quantity;
    _purchasePrice = purchasePrice;
    _currentPrice = currentPrice;
    _currentValue = currentValue;
    _folioNoAccountNo = folioNoAccountNo;
    _interestRate = interestRate;
    _payoutCumulative = payoutCumulative;
    _maturityDate = maturityDate;
    _propertyName = propertyName;
    _area = area;
    _totalValue = totalValue;
    _loanOutstanding = loanOutstanding;
    _leasedNotLeased = leasedNotLeased;
    _monthlyRental = monthlyRental;
    _isinNo = isinNo;
    _firstHolder = firstHolder;
    _secondHolder = secondHolder;
    _nominee = nominee;
    _brokerAdvisor = brokerAdvisor;
    _bankDetails = bankDetails;
    _notes = notes;
    _propertyAddress = propertyAddress;
    _premium = premium;
    _premiumStartDate = premiumStartDate;
    _numberOfPremiumsPaid = numberOfPremiumsPaid;
    _totalPremiumsPaid = totalPremiumsPaid;
    _premiumEndDate = premiumEndDate;
    _sumAssured = sumAssured;
    _premiumFrequency = premiumFrequency;
    _policyNumber = policyNumber;
    _policyHolder = policyHolder;
    _givenToWhom = givenToWhom;
    _companyName = companyName;
    _date = date;
    _loanAmount = loanAmount;
    _numberOfShares = numberOfShares;
    _vestedUnvested = vestedUnvested;
    _amountPending = amountPending;
    _transactions = transactions;
    _updateHistory = updateHistory;
    _history = history;
}

  AssetsDetails.fromJson(dynamic json) {
    _investmentType = json['investment_type'];
    _category = json['category'];
    _assetClass = json['asset_class'];
    _schemeName = json['scheme_name'];
    _transactionType = json['transaction_type'];
    _transactionDate = json['transaction_date'];
    _amountInvested = json['amount_invested'];
    _quantity = json['quantity'] is int ? json['quantity'].toString() : json['quantity'];
    _purchasePrice = json['purchase_price'];
    _currentPrice = json['current_price'];
    _currentValue = json['current_value']is int ? json['current_value'].toString() : json['current_value'];
    _folioNoAccountNo = json['folio_no_account_no'];
    _interestRate = json['interest_rate'];
    _payoutCumulative = json['payout_cumulative'];
    _maturityDate = json['maturity_date'];
    _propertyName = json['property_name'];
    _area = json['area'];
    _totalValue = json['total_value'];
    _loanOutstanding = json['loan_outstanding'];
    _leasedNotLeased = json['leased_not_leased'];
    _monthlyRental = json['monthly_rental'];
    _isinNo = json['isin_no'];
    _firstHolder = json['first_holder'];
    _secondHolder = json['second_holder'];
    _nominee = json['nominee'];
    _brokerAdvisor = json['broker_advisor'];
    _bankDetails = json['bank_details'];
    _notes = json['notes'];
    _propertyAddress = json['property_address'];
    _premium = json['premium'];
    _premiumStartDate = json['premium_start_date'];
    _numberOfPremiumsPaid = json['number_of_premiums_paid'];
    _totalPremiumsPaid = json['total_premiums_paid'];
    _premiumEndDate = json['premium_end_date'];
    _sumAssured = json['sum_assured'];
    _premiumFrequency = json['premium_frequency'];
    _policyNumber = json['policy_number'];
    _policyHolder = json['policy_holder'];
    _givenToWhom = json['given_to_whom'];
    _companyName = json['company_name'];
    _date = json['date'];
    _loanAmount = json['loan_amount'];
    _numberOfShares = json['number_of_shares'];
    _vestedUnvested = json['vested_unvested'];
    _amountPending = json['amount_pending'];
    if (json['transactions'] != null) {
      _transactions = [];
      json['transactions'].forEach((v) {
        //_transactions?.add(Dynamic.fromJson(v));
      });
    }
    _updateHistory = json['update_history'];
    if (json['history'] != null) {
      _history = [];
      json['history'].forEach((v) {
        _history?.add(History.fromJson(v));
      });
    }
  }
  String? _investmentType;
  String? _category;
  String? _assetClass;
  String? _schemeName;
  String? _transactionType;
  String? _transactionDate;
  String? _amountInvested;
  String? _quantity;
  String? _purchasePrice;
  String? _currentPrice;
  String? _currentValue;
  String? _folioNoAccountNo;
  String? _interestRate;
  String? _payoutCumulative;
  String? _maturityDate;
  String? _propertyName;
  String? _area;
  String? _totalValue;
  String? _loanOutstanding;
  String? _leasedNotLeased;
  String? _monthlyRental;
  String? _isinNo;
  String? _firstHolder;
  String? _secondHolder;
  String? _nominee;
  String? _brokerAdvisor;
  String? _bankDetails;
  String? _notes;
  String? _propertyAddress;
  String? _premium;
  String? _premiumStartDate;
  String? _numberOfPremiumsPaid;
  String? _totalPremiumsPaid;
  String? _premiumEndDate;
  String? _sumAssured;
  String? _premiumFrequency;
  String? _policyNumber;
  String? _policyHolder;
  String? _givenToWhom;
  String? _companyName;
  String? _date;
  String? _loanAmount;
  String? _numberOfShares;
  String? _vestedUnvested;
  String? _amountPending;
  List<dynamic>? _transactions;
  String? _updateHistory;
  List<History>? _history;
AssetsDetails copyWith({  String? investmentType,
  String? category,
  String? assetClass,
  String? schemeName,
  String? transactionType,
  String? transactionDate,
  String? amountInvested,
  String? quantity,
  String? purchasePrice,
  String? currentPrice,
  String? currentValue,
  String? folioNoAccountNo,
  String? interestRate,
  String? payoutCumulative,
  String? maturityDate,
  String? propertyName,
  String? area,
  String? totalValue,
  String? loanOutstanding,
  String? leasedNotLeased,
  String? monthlyRental,
  String? isinNo,
  String? firstHolder,
  String? secondHolder,
  String? nominee,
  String? brokerAdvisor,
  String? bankDetails,
  String? notes,
  String? propertyAddress,
  String? premium,
  String? premiumStartDate,
  String? numberOfPremiumsPaid,
  String? totalPremiumsPaid,
  String? premiumEndDate,
  String? sumAssured,
  String? premiumFrequency,
  String? policyNumber,
  String? policyHolder,
  String? givenToWhom,
  String? companyName,
  String? date,
  String? loanAmount,
  String? numberOfShares,
  String? vestedUnvested,
  String? amountPending,
  List<dynamic>? transactions,
  String? updateHistory,
  List<History>? history,
}) => AssetsDetails(  investmentType: investmentType ?? _investmentType,
  category: category ?? _category,
  assetClass: assetClass ?? _assetClass,
  schemeName: schemeName ?? _schemeName,
  transactionType: transactionType ?? _transactionType,
  transactionDate: transactionDate ?? _transactionDate,
  amountInvested: amountInvested ?? _amountInvested,
  quantity: quantity ?? _quantity,
  purchasePrice: purchasePrice ?? _purchasePrice,
  currentPrice: currentPrice ?? _currentPrice,
  currentValue: currentValue ?? _currentValue,
  folioNoAccountNo: folioNoAccountNo ?? _folioNoAccountNo,
  interestRate: interestRate ?? _interestRate,
  payoutCumulative: payoutCumulative ?? _payoutCumulative,
  maturityDate: maturityDate ?? _maturityDate,
  propertyName: propertyName ?? _propertyName,
  area: area ?? _area,
  totalValue: totalValue ?? _totalValue,
  loanOutstanding: loanOutstanding ?? _loanOutstanding,
  leasedNotLeased: leasedNotLeased ?? _leasedNotLeased,
  monthlyRental: monthlyRental ?? _monthlyRental,
  isinNo: isinNo ?? _isinNo,
  firstHolder: firstHolder ?? _firstHolder,
  secondHolder: secondHolder ?? _secondHolder,
  nominee: nominee ?? _nominee,
  brokerAdvisor: brokerAdvisor ?? _brokerAdvisor,
  bankDetails: bankDetails ?? _bankDetails,
  notes: notes ?? _notes,
  propertyAddress: propertyAddress ?? _propertyAddress,
  premium: premium ?? _premium,
  premiumStartDate: premiumStartDate ?? _premiumStartDate,
  numberOfPremiumsPaid: numberOfPremiumsPaid ?? _numberOfPremiumsPaid,
  totalPremiumsPaid: totalPremiumsPaid ?? _totalPremiumsPaid,
  premiumEndDate: premiumEndDate ?? _premiumEndDate,
  sumAssured: sumAssured ?? _sumAssured,
  premiumFrequency: premiumFrequency ?? _premiumFrequency,
  policyNumber: policyNumber ?? _policyNumber,
  policyHolder: policyHolder ?? _policyHolder,
  givenToWhom: givenToWhom ?? _givenToWhom,
  companyName: companyName ?? _companyName,
  date: date ?? _date,
  loanAmount: loanAmount ?? _loanAmount,
  numberOfShares: numberOfShares ?? _numberOfShares,
  vestedUnvested: vestedUnvested ?? _vestedUnvested,
  amountPending: amountPending ?? _amountPending,
  transactions: transactions ?? _transactions,
  updateHistory: updateHistory ?? _updateHistory,
  history: history ?? _history,
);
  String? get investmentType => _investmentType;
  String? get category => _category;
  String? get assetClass => _assetClass;
  String? get schemeName => _schemeName;
  String? get transactionType => _transactionType;
  String? get transactionDate => _transactionDate;
  String? get amountInvested => _amountInvested;
  String? get quantity => _quantity;
  String? get purchasePrice => _purchasePrice;
  String? get currentPrice => _currentPrice;
  String? get currentValue => _currentValue;
  String? get folioNoAccountNo => _folioNoAccountNo;
  String? get interestRate => _interestRate;
  String? get payoutCumulative => _payoutCumulative;
  String? get maturityDate => _maturityDate;
  String? get propertyName => _propertyName;
  String? get area => _area;
  String? get totalValue => _totalValue;
  String? get loanOutstanding => _loanOutstanding;
  String? get leasedNotLeased => _leasedNotLeased;
  String? get monthlyRental => _monthlyRental;
  String? get isinNo => _isinNo;
  String? get firstHolder => _firstHolder;
  String? get secondHolder => _secondHolder;
  String? get nominee => _nominee;
  String? get brokerAdvisor => _brokerAdvisor;
  String? get bankDetails => _bankDetails;
  String? get notes => _notes;
  String? get propertyAddress => _propertyAddress;
  String? get premium => _premium;
  String? get premiumStartDate => _premiumStartDate;
  String? get numberOfPremiumsPaid => _numberOfPremiumsPaid;
  String? get totalPremiumsPaid => _totalPremiumsPaid;
  String? get premiumEndDate => _premiumEndDate;
  String? get sumAssured => _sumAssured;
  String? get premiumFrequency => _premiumFrequency;
  String? get policyNumber => _policyNumber;
  String? get policyHolder => _policyHolder;
  String? get givenToWhom => _givenToWhom;
  String? get companyName => _companyName;
  String? get date => _date;
  String? get loanAmount => _loanAmount;
  String? get numberOfShares => _numberOfShares;
  String? get vestedUnvested => _vestedUnvested;
  String? get amountPending => _amountPending;
  List<dynamic>? get transactions => _transactions;
  String? get updateHistory => _updateHistory;
  List<History>? get history => _history;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['investment_type'] = _investmentType;
    map['category'] = _category;
    map['asset_class'] = _assetClass;
    map['scheme_name'] = _schemeName;
    map['transaction_type'] = _transactionType;
    map['transaction_date'] = _transactionDate;
    map['amount_invested'] = _amountInvested;
    map['quantity'] = _quantity;
    map['purchase_price'] = _purchasePrice;
    map['current_price'] = _currentPrice;
    map['current_value'] = _currentValue;
    map['folio_no_account_no'] = _folioNoAccountNo;
    map['interest_rate'] = _interestRate;
    map['payout_cumulative'] = _payoutCumulative;
    map['maturity_date'] = _maturityDate;
    map['property_name'] = _propertyName;
    map['area'] = _area;
    map['total_value'] = _totalValue;
    map['loan_outstanding'] = _loanOutstanding;
    map['leased_not_leased'] = _leasedNotLeased;
    map['monthly_rental'] = _monthlyRental;
    map['isin_no'] = _isinNo;
    map['first_holder'] = _firstHolder;
    map['second_holder'] = _secondHolder;
    map['nominee'] = _nominee;
    map['broker_advisor'] = _brokerAdvisor;
    map['bank_details'] = _bankDetails;
    map['notes'] = _notes;
    map['property_address'] = _propertyAddress;
    map['premium'] = _premium;
    map['premium_start_date'] = _premiumStartDate;
    map['number_of_premiums_paid'] = _numberOfPremiumsPaid;
    map['total_premiums_paid'] = _totalPremiumsPaid;
    map['premium_end_date'] = _premiumEndDate;
    map['sum_assured'] = _sumAssured;
    map['premium_frequency'] = _premiumFrequency;
    map['policy_number'] = _policyNumber;
    map['policy_holder'] = _policyHolder;
    map['given_to_whom'] = _givenToWhom;
    map['company_name'] = _companyName;
    map['date'] = _date;
    map['loan_amount'] = _loanAmount;
    map['number_of_shares'] = _numberOfShares;
    map['vested_unvested'] = _vestedUnvested;
    map['amount_pending'] = _amountPending;
    if (_transactions != null) {
      map['transactions'] = _transactions?.map((v) => v.toJson()).toList();
    }
    map['update_history'] = _updateHistory;
    if (_history != null) {
      map['history'] = _history?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// message : "Added by   on 26-02-2026 02:47 PM"

History historyFromJson(String str) => History.fromJson(json.decode(str));
String historyToJson(History data) => json.encode(data.toJson());
class History {
  History({
      String? message,}){
    _message = message;
}

  History.fromJson(dynamic json) {
    _message = json['message'];
  }
  String? _message;
History copyWith({  String? message,
}) => History(  message: message ?? _message,
);
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    return map;
  }

}