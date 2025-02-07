import 'package:abyana/app_repository.dart';
import 'package:abyana/models/irrigator.dart';
import 'package:abyana/screens/add_irrigator_screen.dart';
import 'package:abyana/screens/edit_irrigator_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'crop_survey_screen.dart';
import 'irrigator_detail.dart';

class IrrigatorList extends StatefulWidget {
  const IrrigatorList({super.key});

  @override
  State<IrrigatorList> createState() => _IrrigatorListState();
}

class _IrrigatorListState extends State<IrrigatorList> {
  AppRepository appRepository = AppRepository();
  List<Irrigator> irrigators = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchIrrigators();
  }

  Future<void> fetchIrrigators() async {
    setState(() {
      isLoading = true;
    });
    try {
      final fetchedIrrigators = await appRepository.getIrrigators();
      setState(() {
        irrigators = fetchedIrrigators;
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching irrigators: $e');
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
        title:
            const Text('Irrigator List', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF4880FF),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[400]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[400]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[400]!),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[400]!),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddIrrigatorScreen(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF4880FF),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    backgroundColor: Colors.white,
                    onRefresh: fetchIrrigators,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowColor:
                              WidgetStateProperty.all(Color(0xFF4880FF)),
                          border: TableBorder.all(color: Colors.grey[400]!),
                          columns: const [
                            DataColumn(
                              label: Text('ID',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            DataColumn(
                              label: Text('Irrigator Name',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            DataColumn(
                              label: Text('Khata No.',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            DataColumn(
                              label: Text('Action',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                          rows: irrigators.map((irrigator) {
                            return DataRow(
                              cells: [
                                DataCell(Text(irrigator.id.toString())),
                                DataCell(Text(irrigator.irrigatorName)),
                                DataCell(Text(irrigator.irrigatorKhataNumber)),
                                DataCell(
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CropSurveyScreen(
                                                irrigator: irrigator,
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                        child: const Text('Add Survey',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                      const SizedBox(width: 8),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  IrrigatorDetail(
                                                      irrigator: irrigator),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF717174),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(4),
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
                                                  EditIrrigatorScreen(
                                                      irrigator: irrigator),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF4880FF),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: const Icon(Icons.edit,
                                              color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: const Icon(Icons.delete_forever,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
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
