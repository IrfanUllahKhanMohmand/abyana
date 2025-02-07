class Survey {
  final int cropSurveyId;
  final String irrigatorName;
  final String irrigatorKhataNumber;
  final String cultivatorsInfo;
  final String finalCrop;
  final String cropPrice;
  final String date;
  final double width;
  final double length;
  final int areaMarla;
  final int areaKanal;
  final String sessionDate;
  final String khasraNumber;
  final String tenantName;
  final String registrationDate;
  final String snowingDate;
  final int landAssessmentMarla;
  final int landAssessmentKanal;
  final String previousCrop;
  final double doubleCropMarla;
  final double doubleCropKanal;
  final double identifiableAreaMarla;
  final double identifiableAreaKanal;
  final double irrigatedAreaMarla;
  final double irrigatedAreaKanal;
  final String landQuality;
  final String villageName;
  final String halqaName;
  final String canalName;
  final String cropName;
  final String outletName;

  Survey({
    required this.cropSurveyId,
    required this.irrigatorName,
    required this.irrigatorKhataNumber,
    required this.cultivatorsInfo,
    required this.finalCrop,
    required this.cropPrice,
    required this.date,
    required this.width,
    required this.length,
    required this.areaMarla,
    required this.areaKanal,
    required this.sessionDate,
    required this.khasraNumber,
    required this.tenantName,
    required this.registrationDate,
    required this.snowingDate,
    required this.landAssessmentMarla,
    required this.landAssessmentKanal,
    required this.previousCrop,
    required this.doubleCropMarla,
    required this.doubleCropKanal,
    required this.identifiableAreaMarla,
    required this.identifiableAreaKanal,
    required this.irrigatedAreaMarla,
    required this.irrigatedAreaKanal,
    required this.landQuality,
    required this.villageName,
    required this.halqaName,
    required this.canalName,
    required this.cropName,
    required this.outletName,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      cropSurveyId: json['crop_survey_id'],
      irrigatorName: json['irrigator_name'],
      irrigatorKhataNumber: json['irrigator_khata_number'],
      cultivatorsInfo: json['cultivators_info'],
      finalCrop: json['final_crop'],
      cropPrice: json['crop_price'],
      date: json['date'],
      width: double.parse(json['width'].toString()),
      length: double.parse(json['length'].toString()),
      areaMarla: json['area_marla'],
      areaKanal: json['area_kanal'],
      sessionDate: json['session_date'],
      khasraNumber: json['khasra_number'],
      tenantName: json['tenant_name'],
      registrationDate: json['registration_date'],
      snowingDate: json['snowing_date'],
      landAssessmentMarla: int.parse(json['land_assessment_marla'].toString()),
      landAssessmentKanal: int.parse(json['land_assessment_kanal'].toString()),
      previousCrop: json['previous_crop'],
      doubleCropMarla: double.parse(json['double_crop_marla'].toString()),
      doubleCropKanal: double.parse(json['double_crop_kanal'].toString()),
      identifiableAreaMarla:
          double.parse(json['identifable_area_marla'].toString()),
      identifiableAreaKanal:
          double.parse(json['identifable_area_kanal'].toString()),
      irrigatedAreaMarla: double.parse(json['irrigated_area_marla'].toString()),
      irrigatedAreaKanal: double.parse(json['irrigated_area_kanal'].toString()),
      landQuality: json['land_quality'],
      villageName: json['village_name'],
      halqaName: json['halqa_name'],
      canalName: json['canal_name'],
      cropName: json['crop_name'],
      outletName: json['outlet_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'crop_survey_id': cropSurveyId,
      'irrigator_name': irrigatorName,
      'irrigator_khata_number': irrigatorKhataNumber,
      'cultivators_info': cultivatorsInfo,
      'final_crop': finalCrop,
      'crop_price': cropPrice,
      'date': date,
      'width': width,
      'length': length,
      'area_marla': areaMarla,
      'area_kanal': areaKanal,
      'session_date': sessionDate,
      'khasra_number': khasraNumber,
      'tenant_name': tenantName,
      'registration_date': registrationDate,
      'snowing_date': snowingDate,
      'land_assessment_marla': landAssessmentMarla,
      'land_assessment_kanal': landAssessmentKanal,
      'previous_crop': previousCrop,
      'double_crop_marla': doubleCropMarla,
      'double_crop_kanal': doubleCropKanal,
      'identifable_area_marla': identifiableAreaMarla,
      'identifable_area_kanal': identifiableAreaKanal,
      'irrigated_area_marla': irrigatedAreaMarla,
      'irrigated_area_kanal': irrigatedAreaKanal,
      'land_quality': landQuality,
      'village_name': villageName,
      'halqa_name': halqaName,
      'canal_name': canalName,
      'crop_name': cropName,
      'outlet_name': outletName,
    };
  }
}
