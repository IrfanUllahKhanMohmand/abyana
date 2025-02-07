import 'package:abyana/app_repository.dart';
import 'package:abyana/models/canal.dart';
import 'package:abyana/models/halqa.dart';
import 'package:abyana/models/user.dart';
import 'package:abyana/models/village.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddIrrigatorScreen extends StatefulWidget {
  const AddIrrigatorScreen({super.key});

  @override
  State<AddIrrigatorScreen> createState() => _AddIrrigatorScreenState();
}

class _AddIrrigatorScreenState extends State<AddIrrigatorScreen> {
  bool isLoading = true;
  AppRepository appRepository = AppRepository();
  List<Village> villages = [];
  List<Canal> canals = [];

  Halqa? selectedHalqa;
  Village? selectedVillage;
  Canal? selectedCanal;

  final _formKey = GlobalKey<FormState>();
  final _irrigatorNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _khataNumberController = TextEditingController();
  final _mobileNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final fetchedVillages = await appRepository.getVillages();
      final fetchedCanals = await appRepository.getCanals();

      setState(() {
        villages = fetchedVillages;
        canals = fetchedCanals;
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
        User user = await appRepository.getUser();
        await appRepository.createIrrigator({
          'halqa_id': user.halqaId,
          'village_id': selectedVillage?.villageId,
          'canal_id': selectedCanal?.id,
          'irrigator_name': _irrigatorNameController.text,
          'irrigator_father_name': _fatherNameController.text,
          'irrigator_khata_number': _khataNumberController.text,
          'irrigator_mobile_number': _mobileNumberController.text,
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Irrigator added successfully')),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error submitting form: $e');
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add irrigator')),
          );
        }
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
              'Add Irrigator',
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
                        dropdownColor: Colors.white,
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
                        dropdownColor: Colors.white,
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
                          child: Text('Submit',
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
