import 'package:abyana/app_repository.dart';
import 'package:abyana/models/survey_summary.dart';
import 'package:abyana/screens/survey_list_details_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SurveyList extends StatefulWidget {
  const SurveyList({super.key});

  @override
  State<SurveyList> createState() => _SurveyListState();
}

class _SurveyListState extends State<SurveyList> {
  AppRepository appRepository = AppRepository();
  List<SurveySummary> surveys = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSurveys();
  }

  Future<void> loadSurveys() async {
    try {
      final result = await appRepository.getCropSurveys();
      setState(() {
        surveys = result;
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
        title: const Text('Survey List', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF4880FF),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor:
                          WidgetStateProperty.all(Color(0xFF4880FF)),
                      border: TableBorder.all(color: Colors.grey[400]!),
                      columns: const [
                        DataColumn(
                            label: Text('ID',
                                style: TextStyle(color: Colors.white))),
                        DataColumn(
                            label: Text('Irrigator Name',
                                style: TextStyle(color: Colors.white))),
                        DataColumn(
                            label: Text('Khata No.',
                                style: TextStyle(color: Colors.white))),
                        DataColumn(
                            label: Text('Village',
                                style: TextStyle(color: Colors.white))),
                        DataColumn(
                            label: Text('Action',
                                style: TextStyle(color: Colors.white))),
                      ],
                      rows: List.generate(
                        surveys.length,
                        (index) => DataRow(
                          cells: [
                            DataCell(Text('${surveys[index].cropSurveyId}')),
                            DataCell(Text(surveys[index].irrigatorName)),
                            DataCell(Text(surveys[index].irrigatorKhataNumber)),
                            DataCell(Text("Village")),
                            DataCell(
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SurveyListDetailsScreen(
                                            surveyId:
                                                surveys[index].cropSurveyId,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF007EF2),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Icon(Icons.visibility,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
