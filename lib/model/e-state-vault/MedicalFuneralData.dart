import 'dart:convert';
/// generally_id : "37"
/// user_id : "164"
/// directions_about_medical_and_nursing : "ty"
/// organ_donor_transplantation_wishes : "yy"
/// instructions_about_funeral : "yyk"
/// timestamp : "1678794589"

MedicalFuneralData generallyTempDataFromJson(String str) => MedicalFuneralData.fromJson(json.decode(str));
String generallyTempDataToJson(MedicalFuneralData data) => json.encode(data.toJson());
class MedicalFuneralData {
  MedicalFuneralData({
      String? generallyId, 
      String? userId, 
      String? directionsAboutMedicalAndNursing, 
      String? organDonorTransplantationWishes, 
      String? instructionsAboutFuneral, 
      String? timestamp,}){
    _generallyId = generallyId;
    _userId = userId;
    _directionsAboutMedicalAndNursing = directionsAboutMedicalAndNursing;
    _organDonorTransplantationWishes = organDonorTransplantationWishes;
    _instructionsAboutFuneral = instructionsAboutFuneral;
    _timestamp = timestamp;
}

  MedicalFuneralData.fromJson(dynamic json) {
    _generallyId = json['generally_id'];
    _userId = json['user_id'];
    _directionsAboutMedicalAndNursing = json['directions_about_medical_and_nursing'];
    _organDonorTransplantationWishes = json['organ_donor_transplantation_wishes'];
    _instructionsAboutFuneral = json['instructions_about_funeral'];
    _timestamp = json['timestamp'];
  }
  String? _generallyId;
  String? _userId;
  String? _directionsAboutMedicalAndNursing;
  String? _organDonorTransplantationWishes;
  String? _instructionsAboutFuneral;
  String? _timestamp;
MedicalFuneralData copyWith({  String? generallyId,
  String? userId,
  String? directionsAboutMedicalAndNursing,
  String? organDonorTransplantationWishes,
  String? instructionsAboutFuneral,
  String? timestamp,
}) => MedicalFuneralData(  generallyId: generallyId ?? _generallyId,
  userId: userId ?? _userId,
  directionsAboutMedicalAndNursing: directionsAboutMedicalAndNursing ?? _directionsAboutMedicalAndNursing,
  organDonorTransplantationWishes: organDonorTransplantationWishes ?? _organDonorTransplantationWishes,
  instructionsAboutFuneral: instructionsAboutFuneral ?? _instructionsAboutFuneral,
  timestamp: timestamp ?? _timestamp,
);
  String? get generallyId => _generallyId;
  String? get userId => _userId;
  String? get directionsAboutMedicalAndNursing => _directionsAboutMedicalAndNursing;
  String? get organDonorTransplantationWishes => _organDonorTransplantationWishes;
  String? get instructionsAboutFuneral => _instructionsAboutFuneral;
  String? get timestamp => _timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['generally_id'] = _generallyId;
    map['user_id'] = _userId;
    map['directions_about_medical_and_nursing'] = _directionsAboutMedicalAndNursing;
    map['organ_donor_transplantation_wishes'] = _organDonorTransplantationWishes;
    map['instructions_about_funeral'] = _instructionsAboutFuneral;
    map['timestamp'] = _timestamp;
    return map;
  }

}