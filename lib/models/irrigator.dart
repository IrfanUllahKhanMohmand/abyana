class Irrigator {
  final int id;
  final String irrigatorName;
  final String irrigatorKhataNumber;
  final String irrigatorMobileNumber;
  final int villageId;
  final String villageName;
  final int halqaId;
  final String halqaName;
  final int tehsilId;
  final String tehsilName;
  final int districtId;
  final String districtName;
  final int divId;
  final String divisionName;

  Irrigator({
    required this.id,
    required this.irrigatorName,
    required this.irrigatorKhataNumber,
    required this.irrigatorMobileNumber,
    required this.villageId,
    required this.villageName,
    required this.halqaId,
    required this.halqaName,
    required this.tehsilId,
    required this.tehsilName,
    required this.districtId,
    required this.districtName,
    required this.divId,
    required this.divisionName,
  });

  factory Irrigator.fromJson(Map<String, dynamic> json) {
    return Irrigator(
      id: json['id'],
      irrigatorName: json['irrigator_name'],
      irrigatorKhataNumber: json['irrigator_khata_number'],
      irrigatorMobileNumber: json['irrigator_mobile_number'],
      villageId: json['village_id'],
      villageName: json['village_name'],
      halqaId: json['halqa_id'],
      halqaName: json['halqa_name'],
      tehsilId: json['tehsil_id'],
      tehsilName: json['tehsil_name'],
      districtId: json['district_id'],
      districtName: json['district_name'],
      divId: json['div_id'],
      divisionName: json['divsion_name'], // Note the typo in "divsion_name"
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'irrigator_name': irrigatorName,
      'irrigator_khata_number': irrigatorKhataNumber,
      'irrigator_mobile_number': irrigatorMobileNumber,
      'village_id': villageId,
      'village_name': villageName,
      'halqa_id': halqaId,
      'halqa_name': halqaName,
      'tehsil_id': tehsilId,
      'tehsil_name': tehsilName,
      'district_id': districtId,
      'district_name': districtName,
      'div_id': divId,
      'divsion_name': divisionName, // Note the typo in "divsion_name"
    };
  }
}
