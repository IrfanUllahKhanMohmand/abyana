import 'package:abyana/app_repository.dart';
import 'package:abyana/models/survey.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SurveyListDetailsScreen extends StatefulWidget {
  const SurveyListDetailsScreen({super.key, required this.surveyId});
  final int surveyId;

  @override
  State<SurveyListDetailsScreen> createState() =>
      _SurveyListDetailsScreenState();
}

class _SurveyListDetailsScreenState extends State<SurveyListDetailsScreen> {
  AppRepository appRepository = AppRepository();
  Survey? survey;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadSurveyDetails();
  }

  Future<void> loadSurveyDetails() async {
    try {
      final result = await appRepository.getCropSurvey(widget.surveyId);
      setState(() {
        survey = result;
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error loading surveys: $e');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Survey List',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF4285F4),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : survey == null
              ? Center(
                  child: Text('Survey Details not found'),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSection(
                        'Land Survey / زمین کی سروے',
                        [
                          _buildInfoRow('Canal / نہر :', survey!.canalName),
                          _buildInfoRow(
                              'Outlet / آؤٹ لیٹ:', survey!.outletName),
                          _buildInfoRow('Season Year / فصل کا سال:', "2025"),
                          _buildInfoRow('Crop / فصل:', survey!.cropName),
                        ],
                      ),
                      _buildSection(
                        'Farmer and Land Registration Form',
                        [
                          _buildInfoRow('Khasra Assessment Number / نمبر:',
                              survey!.khasraNumber),
                          _buildInfoRow(
                              'Irrigator Name / نام:', survey!.irrigatorName),
                          _buildInfoRow('Khata Number / کھاتہ نمبر:',
                              survey!.irrigatorKhataNumber),
                          _buildInfoRow('Entry Date / داخلہ تاریخ:',
                              survey!.registrationDate),
                          _buildInfoRow(
                              'Tenant Name / کاشتکار:', survey!.tenantName),
                          _buildInfoRow('Cultivator\'s Information:',
                              survey!.cultivatorsInfo),
                          _buildInfoRow(
                              'Sowing Date / تاریخ:', survey!.snowingDate),
                        ],
                      ),
                      _buildSection(
                        'Crop Type Registration / اندراج فصل کی قسم',
                        [
                          _buildInfoRow('Land Assessment / اراضی:', ''),
                          _buildInfoRow('Marla / مرلہ:',
                              survey!.landAssessmentMarla.toString()),
                          _buildInfoRow('Kanal / کنال:',
                              survey!.landAssessmentKanal.toString()),
                          _buildInfoRow(
                              'Previous Crop Name:', survey!.previousCrop),
                        ],
                      ),
                      _buildSection(
                        'Final Measurement / پیمائش',
                        [
                          _buildInfoRow('Date / تاریخ:', survey!.date),
                          _buildInfoRow(
                              'Length / طول:', survey!.length.toString()),
                          _buildInfoRow(
                              'Width / عرض:', survey!.width.toString()),
                        ],
                      ),
                      _buildSection(
                        'Area / رقبہ',
                        [
                          _buildInfoRow(
                              'Marla / مرلہ:', survey!.areaMarla.toString()),
                          _buildInfoRow(
                              'Kanal / کنال:', survey!.areaKanal.toString()),
                          _buildInfoRow('Final Crop Name:', survey!.finalCrop),
                          _buildInfoRow('Rate:', "Rs. 5000"),
                        ],
                      ),
                      _buildSection(
                        'Land Replanting / اراضی دوبارہ کاشت',
                        [
                          _buildInfoRow('Marla / مرلہ:', '60'),
                          _buildInfoRow('Kanal / کنال:', '3'),
                        ],
                      ),
                      _buildSection(
                        'Double Crop Land / اراضی دو فصلی',
                        [
                          _buildInfoRow('Marla / مرلہ:',
                              survey!.doubleCropMarla.toString()),
                          _buildInfoRow('Kanal / کنال:',
                              survey!.doubleCropKanal.toString()),
                        ],
                      ),
                      _buildSection(
                        'Irrigated Area / سیراب رقبہ',
                        [
                          _buildInfoRow('Marla / مرلہ:',
                              survey!.irrigatedAreaMarla.toString()),
                          _buildInfoRow('Kanal / کنال:',
                              survey!.irrigatedAreaKanal.toString()),
                        ],
                      ),
                      _buildSection(
                        'Identifiable Area / رقبہ قابل شناخت',
                        [
                          _buildInfoRow('Marla / مرلہ:',
                              survey!.identifiableAreaMarla.toString()),
                          _buildInfoRow('Kanal / کنال:',
                              survey!.identifiableAreaKanal.toString()),
                        ],
                      ),
                      _buildSection(
                        'Land Quality / کیفیت',
                        [
                          _buildInfoRow(
                              'Land Quality / کیفیت:', survey!.landQuality),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.blue[600],
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
