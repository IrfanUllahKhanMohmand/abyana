import 'package:abyana/app_repository.dart';
import 'package:abyana/models/canal.dart';
import 'package:abyana/models/halqa.dart';
import 'package:abyana/models/irrigator.dart';
import 'package:abyana/models/village.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EditIrrigatorScreen extends StatefulWidget {
  final Irrigator irrigator;

  const EditIrrigatorScreen({super.key, required this.irrigator});

  @override
  State<EditIrrigatorScreen> createState() => _EditIrrigatorScreenState();
}

class _EditIrrigatorScreenState extends State<EditIrrigatorScreen> {
  bool isLoading = true;
  AppRepository appRepository = AppRepository();

  List<Village> villages = [];
  List<Canal> canals = [];

  Halqa? selectedHalqa;
  Village? selectedVillage;
  Canal? selectedCanal;

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _irrigatorNameController;
  late final TextEditingController _fatherNameController;
  late final TextEditingController _khataNumberController;
  late final TextEditingController _mobileNumberController;

  @override
  void initState() {
    super.initState();
    _irrigatorNameController =
        TextEditingController(text: widget.irrigator.irrigatorName);
    _fatherNameController = TextEditingController();
    _khataNumberController =
        TextEditingController(text: widget.irrigator.irrigatorKhataNumber);
    _mobileNumberController =
        TextEditingController(text: widget.irrigator.irrigatorMobileNumber);
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final fetchedVillages = await appRepository.getVillages();
      final fetchedCanals = await appRepository.getCanals();

      setState(() {
        villages = fetchedVillages;
        canals = fetchedCanals;
        selectedVillage = villages
            .firstWhere((v) => v.villageId == widget.irrigator.villageId);
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        // User user = await appRepository.getUser();
        // await appRepository.updateIrrigator(
        //   widget.irrigator.id,
        //   {
        //     'halqa_id': user.halqaId,
        //     'village': selectedVillage?.villageId,
        //     'canal': selectedCanal?.id,
        //     'irrigatorName': _irrigatorNameController.text,
        //     'fatherName': _fatherNameController.text,
        //     'khataNumber': _khataNumberController.text,
        //     'mobileNumber': _mobileNumberController.text,
        //   },
        // );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Irrigator updated successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        if (kDebugMode) {
          print('Error updating irrigator: $e');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update irrigator')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4880FF),
        leading: const SizedBox(),
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Edit Irrigator',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      Text('Village / گاؤں',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      DropdownButtonFormField<Village>(
                        decoration: const InputDecoration(
                          hintText: 'Village / گاؤں',
                          border: OutlineInputBorder(),
                        ),
                        value: selectedVillage,
                        items: villages.map((village) {
                          return DropdownMenuItem(
                            value: village,
                            child: Text(village.villageName),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedVillage = value;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select a Village' : null,
                      ),
                      const SizedBox(height: 16),
                      Text("Canal / نہر",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      DropdownButtonFormField<Canal>(
                        decoration: const InputDecoration(
                          hintText: 'Canal / نہر',
                          border: OutlineInputBorder(),
                        ),
                        value: selectedCanal,
                        items: canals.map((canal) {
                          return DropdownMenuItem(
                            value: canal,
                            child: Text(canal.canalName),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCanal = value;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select a Canal' : null,
                      ),
                      const SizedBox(height: 16),
                      Text('Irrigator Name / نام مالک قبضہ دار یا مزارع',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: _irrigatorNameController,
                        decoration: const InputDecoration(
                          hintText:
                              'Irrigator Name / نام مالک قبضہ دار یا مزارع',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter Irrigator Name'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text('Father Name / والد کا نام',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: _fatherNameController,
                        decoration: const InputDecoration(
                          hintText: 'Father Name / والد کا نام',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter Father Name' : null,
                      ),
                      const SizedBox(height: 16),
                      Text('Khata Number / نمبر خسرہ کھاتہ (کھتونی)',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: _khataNumberController,
                        decoration: const InputDecoration(
                          hintText: 'Khata Number / نمبر خسرہ کھاتہ (کھتونی)',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter Khata Number' : null,
                      ),
                      const SizedBox(height: 16),
                      Text('Mobile Number / موبائل نمبر',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: _mobileNumberController,
                        decoration: const InputDecoration(
                          hintText: 'Mobile Number / موبائل نمبر',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter Mobile Number'
                            : null,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4880FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text('Update',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _irrigatorNameController.dispose();
    _fatherNameController.dispose();
    _khataNumberController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }
}
