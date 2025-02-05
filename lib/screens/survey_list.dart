import 'package:abyana/screens/crop_survey_screen.dart';
import 'package:abyana/screens/survey_list_details_screen.dart';
import 'package:flutter/material.dart';

class SurveyList extends StatelessWidget {
  const SurveyList({super.key});

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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(Color(0xFF4880FF)),
                border: TableBorder.all(color: Colors.grey[400]!),
                columns: const [
                  DataColumn(
                      label: Text('ID', style: TextStyle(color: Colors.white))),
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
                  3,
                  (index) => DataRow(
                    cells: [
                      DataCell(Text('${index + 1}')),
                      const DataCell(Text('Qazi Abbas')),
                      const DataCell(Text('1561')),
                      const DataCell(Text('Attock')),
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
                                        const SurveyListDetailsScreen(),
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
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CropSurveyScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Color(0xFF47CC61),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(Icons.arrow_forward,
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
