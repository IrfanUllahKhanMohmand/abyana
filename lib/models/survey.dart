class Survey {
  final String id;
  final String irrigatorName;
  final String khataNumber;
  final String village;
  final String canal;
  final String outlet;
  final String seasonYear;
  final String crop;
  final String tenantName;
  final String cultivatorInfo;
  final String sowingDate;
  final double landAssessment;
  final int marla;
  final int kanal;
  final String previousCrop;
  final String finalCropName;
  final double rate;

  Survey({
    required this.id,
    required this.irrigatorName,
    required this.khataNumber,
    required this.village,
    required this.canal,
    required this.outlet,
    required this.seasonYear,
    required this.crop,
    required this.tenantName,
    required this.cultivatorInfo,
    required this.sowingDate,
    required this.landAssessment,
    required this.marla,
    required this.kanal,
    required this.previousCrop,
    required this.finalCropName,
    required this.rate,
  });
}
