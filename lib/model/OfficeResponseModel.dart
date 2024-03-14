import 'dart:convert';
/// address : [{"city":"Mumbai","address":"205, 2nd Floor, Ratan Central, Dr.B.A.Road, Parel Mumbai - 400012 Maharastra","phone":"","fax":"","map_link":"https://www.google.com/maps/place/Alpha+Capital/@19.006637,72.841047,17z/data=!3m1!4b1!4m5!3m4!1s0x3be7cf3b0f100001:0xb50f4f9b174e590!8m2!3d19.006637!4d72.841047?shorturl=1"},{"city":"Gurgaon","address":"804, 805, 8th Floor, Tower B4, Spaze I Tech Park, Sohna Road, Gurgaon-122018 , Haryana, India.","phone":"0124-4246036/37/38","fax":" 0124-4246037","map_link":"https://www.google.co.in/maps/place/Spazedge/@28.4201835,77.0402822,17z/data=!3m1!4b1!4m5!3m4!1s0x390d229c4a61db17:0x877fd1e1cd668cac!8m2!3d28.4201835!4d77.0402822?hl=en"},{"city":"Kolkata","address":"Chanden Niketan, 2nd floor unit 211,52A Shakespeare Sarani, Kolkata 700017","phone":"","fax":"","map_link":"https://www.google.co.in/maps/place/Shakespeare+Sarani+Rd,+Kolkata,+West+Bengal+700017/@22.5445665,88.3550181,17z/data=!3m1!4b1!4m5!3m4!1s0x3a027719ef9a0d39:0xb03604e7a0077c19!8m2!3d22.5445616!4d88.3572068?shorturl=1"},{"city":"Coimbatore","address":"195, Ground Floor, Tulsi Chambers, West TV Swamy Road, RS Puram, Coimbatore-641002, Tamil Nadu, India. ","phone":"+91 422 4367 309","fax":"","map_link":"https://www.google.com/maps/place/KUMAR+BROTHERS+-+COIMBATORE/@11.0101096,76.9493714,17z/data=!3m1!4b1!4m6!3m5!1s0x3ba8590a8c075ee7:0xa3b83c3a29fb17ca!8m2!3d11.0101096!4d76.9493714!16s%2Fg%2F11h1z2t6zv?entry=ttu"},{"city":"Siliguri","address":"Sevoke Road, Silliguri - 734401 West Bengal","phone":"","fax":"","map_link":"https://www.google.co.in/maps/place/Sevoke+Rd,+Siliguri,+West+Bengal/@26.7497093,88.437736,18z/data=!3m1!4b1!4m5!3m4!1s0x39e44104d4cdb0fd:0xa25bc3007c53987c!8m2!3d26.7497093!4d88.4388303?hl=en"},{"city":"Bangalore","address":"21, 80 Feet Rd, 4th Block, S.T. Bed, Cauvery Colony, Koramangala, Bengaluru, Karnataka 560095","phone":"","fax":"","map_link":"https://www.google.com/maps/place/21,+80+Feet+Rd,+4th+Block,+S.T.+Bed,+Cauvery+Colony,+Koramangala,+Bengaluru,+Karnataka+560095/@12.9324752,77.6296805,17z/data=!3m1!4b1!4m6!3m5!1s0x3bae14679ef2a761:0xdf480709d792cec1!8m2!3d12.9324752!4d77.6318692!16s%2Fg%2F11fklg_hdy?entry=tts&shorturl=1"}]

OfficeResponseModel officeResponseModelFromJson(String str) => OfficeResponseModel.fromJson(json.decode(str));
String officeResponseModelToJson(OfficeResponseModel data) => json.encode(data.toJson());
class OfficeResponseModel {
  OfficeResponseModel({
      List<Address>? address,}){
    _address = address;
}

  OfficeResponseModel.fromJson(dynamic json) {
    if (json['address'] != null) {
      _address = [];
      json['address'].forEach((v) {
        _address?.add(Address.fromJson(v));
      });
    }
  }
  List<Address>? _address;
OfficeResponseModel copyWith({  List<Address>? address,
}) => OfficeResponseModel(  address: address ?? _address,
);
  List<Address>? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_address != null) {
      map['address'] = _address?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// city : "Mumbai"
/// address : "205, 2nd Floor, Ratan Central, Dr.B.A.Road, Parel Mumbai - 400012 Maharastra"
/// phone : ""
/// fax : ""
/// map_link : "https://www.google.com/maps/place/Alpha+Capital/@19.006637,72.841047,17z/data=!3m1!4b1!4m5!3m4!1s0x3be7cf3b0f100001:0xb50f4f9b174e590!8m2!3d19.006637!4d72.841047?shorturl=1"

Address addressFromJson(String str) => Address.fromJson(json.decode(str));
String addressToJson(Address data) => json.encode(data.toJson());
class Address {
  Address({
      String? city, 
      String? address, 
      String? phone, 
      String? fax, 
      String? mapLink,}){
    _city = city;
    _address = address;
    _phone = phone;
    _fax = fax;
    _mapLink = mapLink;
}

  Address.fromJson(dynamic json) {
    _city = json['city'];
    _address = json['address'];
    _phone = json['phone'];
    _fax = json['fax'];
    _mapLink = json['map_link'];
  }
  String? _city;
  String? _address;
  String? _phone;
  String? _fax;
  String? _mapLink;
Address copyWith({  String? city,
  String? address,
  String? phone,
  String? fax,
  String? mapLink,
}) => Address(  city: city ?? _city,
  address: address ?? _address,
  phone: phone ?? _phone,
  fax: fax ?? _fax,
  mapLink: mapLink ?? _mapLink,
);
  String? get city => _city;
  String? get address => _address;
  String? get phone => _phone;
  String? get fax => _fax;
  String? get mapLink => _mapLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = _city;
    map['address'] = _address;
    map['phone'] = _phone;
    map['fax'] = _fax;
    map['map_link'] = _mapLink;
    return map;
  }

}