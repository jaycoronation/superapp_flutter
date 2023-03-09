import 'dart:convert';
/// uid : "shahista"
/// flag : "Y"
/// logopath : "https://www.my-portfolio.in/SubDomainLogos/alphacapital.png"
/// bid : "10250"
/// headeline : "R"
/// cid : "01C03609"

InvestWellResponse investWellResponseFromJson(String str) => InvestWellResponse.fromJson(json.decode(str));
String investWellResponseToJson(InvestWellResponse data) => json.encode(data.toJson());
class InvestWellResponse {
  InvestWellResponse({
      String? uid, 
      String? flag, 
      String? logopath, 
      String? bid, 
      String? headeline, 
      String? cid,}){
    _uid = uid;
    _flag = flag;
    _logopath = logopath;
    _bid = bid;
    _headeline = headeline;
    _cid = cid;
}

  InvestWellResponse.fromJson(dynamic json) {
    _uid = json['uid'];
    _flag = json['flag'];
    _logopath = json['logopath'];
    _bid = json['bid'];
    _headeline = json['headeline'];
    _cid = json['cid'];
  }
  String? _uid;
  String? _flag;
  String? _logopath;
  String? _bid;
  String? _headeline;
  String? _cid;
InvestWellResponse copyWith({  String? uid,
  String? flag,
  String? logopath,
  String? bid,
  String? headeline,
  String? cid,
}) => InvestWellResponse(  uid: uid ?? _uid,
  flag: flag ?? _flag,
  logopath: logopath ?? _logopath,
  bid: bid ?? _bid,
  headeline: headeline ?? _headeline,
  cid: cid ?? _cid,
);
  String? get uid => _uid;
  String? get flag => _flag;
  String? get logopath => _logopath;
  String? get bid => _bid;
  String? get headeline => _headeline;
  String? get cid => _cid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = _uid;
    map['flag'] = _flag;
    map['logopath'] = _logopath;
    map['bid'] = _bid;
    map['headeline'] = _headeline;
    map['cid'] = _cid;
    return map;
  }

}