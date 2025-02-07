class SurveySummary {
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

  SurveySummary({
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
  });

  factory SurveySummary.fromJson(Map<String, dynamic> json) {
    return SurveySummary(
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
    };
  }
}
