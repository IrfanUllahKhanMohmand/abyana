import 'package:abyana/app_repository.dart';
import 'package:abyana/models/canal.dart';
import 'package:abyana/models/crop.dart';
import 'package:abyana/models/irrigator.dart';
import 'package:abyana/models/outlet.dart';
import 'package:abyana/models/village.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CropSurveyScreen extends StatefulWidget {
  const CropSurveyScreen({super.key, required this.irrigator});
  final Irrigator irrigator;

  @override
  State<CropSurveyScreen> createState() => _CropSurveyScreenState();
}

class _CropSurveyScreenState extends State<CropSurveyScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;
  AppRepository appRepository = AppRepository();
  List<Village> villages = [];
  List<Canal> canals = [];
  List<Outlet> outlets = [];
  List<Crop> crops = [];

  // Controllers for text fields
  final _khasraNumberController = TextEditingController();
  final _tenantNameController = TextEditingController();
  final _irrigatorNameController = TextEditingController();
  final _registrationDateController = TextEditingController();
  final _sessionDateController = TextEditingController();
  final _cultivatorsInfoController = TextEditingController();
  final _snowingDateController = TextEditingController();
  final _landAssessmentMarlaController = TextEditingController();
  final _landAssessmentKanalController = TextEditingController();
  final _previousCropController = TextEditingController();
  final _dateController = TextEditingController();
  final _widthController = TextEditingController();
  final _lengthController = TextEditingController();
  final _areaMarlaController = TextEditingController();
  final _areaKanalController = TextEditingController();
  final _cropPriceController = TextEditingController();
  final _landReplantingMarlaController = TextEditingController();
  final _landReplantingKanalController = TextEditingController();
  final _doubleCropMarlaController = TextEditingController();
  final _doubleCropKanalController = TextEditingController();
  final _identifiableAreaMarlaController = TextEditingController();
  final _identifiableAreaKanalController = TextEditingController();
  final _irrigatedAreaMarlaController = TextEditingController();
  final _irrigatedAreaKanalController = TextEditingController();
  final _landQualityController = TextEditingController();
  final _irrigatorKhataNumberController = TextEditingController();

  // Variables for dropdown selections
  String? _selectedVillage;
  String? _selectedCrop;
  int? _selectedCanalId;
  int? _selectedOutletId;
  int? _selectedFinalCropId;

  @override
  void initState() {
    super.initState();
    _irrigatorNameController.text = widget.irrigator.irrigatorName;
    _irrigatorKhataNumberController.text =
        widget.irrigator.irrigatorKhataNumber;
    _selectedVillage = widget.irrigator.villageId.toString();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final fetchedVillages = await appRepository.getVillages();
      final fetchedCanals = await appRepository.getCanals();
      final fetchedOutlets = await appRepository.getOutlets();
      final fetchedCrops = await appRepository.getCrops();

      setState(() {
        villages = fetchedVillages;
        canals = fetchedCanals;
        outlets = fetchedOutlets;
        crops = fetchedCrops;
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

  @override
  void dispose() {
    // Dispose all controllers
    _khasraNumberController.dispose();
    _tenantNameController.dispose();
    _irrigatorNameController.dispose();
    _registrationDateController.dispose();
    _sessionDateController.dispose();
    _cultivatorsInfoController.dispose();
    _snowingDateController.dispose();
    _landAssessmentMarlaController.dispose();
    _landAssessmentKanalController.dispose();
    _previousCropController.dispose();
    _dateController.dispose();
    _widthController.dispose();
    _lengthController.dispose();
    _areaMarlaController.dispose();
    _areaKanalController.dispose();
    _cropPriceController.dispose();
    _landReplantingMarlaController.dispose();
    _landReplantingKanalController.dispose();
    _doubleCropMarlaController.dispose();
    _doubleCropKanalController.dispose();
    _identifiableAreaMarlaController.dispose();
    _identifiableAreaKanalController.dispose();
    _irrigatedAreaMarlaController.dispose();
    _irrigatedAreaKanalController.dispose();
    _landQualityController.dispose();
    _irrigatorKhataNumberController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        // Create a Map with all the form data
        final surveyData = {
          "khasra_number": _khasraNumberController.text,
          "tenant_name": _tenantNameController.text,
          "registration_date": _registrationDateController.text,
          "session_date": _sessionDateController.text,
          "cultivators_info": _cultivatorsInfoController.text,
          "snowing_date": _snowingDateController.text,
          "land_assessment_marla": _landAssessmentMarlaController.text,
          "land_assessment_kanal": _landAssessmentKanalController.text,
          "previous_crop": _previousCropController.text,
          "date": _dateController.text,
          "width": double.tryParse(_widthController.text) ?? 0,
          "length": double.tryParse(_lengthController.text) ?? 0,
          "area_marla": double.tryParse(_areaMarlaController.text) ?? 0,
          "area_kanal": double.tryParse(_areaKanalController.text) ?? 0,
          "crop_price": _cropPriceController.text,
          "double_crop_marla": _doubleCropMarlaController.text,
          "double_crop_kanal": _doubleCropKanalController.text,
          "identifable_area_marla": _identifiableAreaMarlaController.text,
          "identifable_area_kanal": _identifiableAreaKanalController.text,
          "irrigated_area_marla":
              double.tryParse(_irrigatedAreaMarlaController.text) ?? 0,
          "irrigated_area_kanal":
              double.tryParse(_irrigatedAreaKanalController.text) ?? 0,
          "land_quality": _landQualityController.text,
          "irrigator_khata_number": _irrigatorKhataNumberController.text,
          "village_id":
              _selectedVillage != null ? int.tryParse(_selectedVillage!) : null,
          "irrigator_id": widget.irrigator
              .id, // This should be dynamically set based on the logged-in user or selected irrigator
          "canal_id": _selectedCanalId,
          "crop_id":
              _selectedCrop != null ? int.tryParse(_selectedCrop!) : null,
          "outlet_id": _selectedOutletId,
          "finalcrop_id": _selectedFinalCropId,
        };

        // Call the addSurvey method from appRepository
        await appRepository.createCropSurvey(surveyData);

        setState(() {
          isLoading = false;
        });

        // Show a success message or navigate to a new screen
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Survey submitted successfully')),
          );
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        if (kDebugMode) {
          print('Error submitting survey: $e');
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to submit survey')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4285F4),
        centerTitle: true,
        title: const Text('Crop Survey',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Land Survey /خسرہ گرداوری',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4285F4),
                        ),
                      ),
                      const SizedBox(height: 16),
                      IgnorePointer(
                        child: _buildDropdownWithInitialValue(
                            'Village / گاؤں', 'Select Village', villages,
                            (value) {
                          Village val = value as Village;
                          setState(() =>
                              _selectedVillage = val.villageId.toString());
                        },
                            villages
                                .where((v) =>
                                    v.villageId.toString() == _selectedVillage)
                                .firstOrNull),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdown(
                                'Canal / نہر', 'Select Canal', canals, (value) {
                              Canal val = value as Canal;
                              setState(() => _selectedCanalId =
                                  int.tryParse(val.id.toString()));
                            }),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildDropdown(
                                'Outlet / موگیہ', 'Select Outlet', outlets,
                                (value) {
                              Outlet val = value as Outlet;
                              setState(() => _selectedOutletId =
                                  int.tryParse(val.id.toString()));
                            }),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDateTextField(
                                'Season Year / فصل کا سال',
                                'Type Crop Year',
                                _sessionDateController,
                                isReadOnly: true,
                                context: context),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildDropdown(
                                'Crop / فصل', 'Select Crop', crops, (value) {
                              Crop val = value as Crop;
                              setState(() => _selectedCrop = val.id.toString());
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Farmer and Land Registration Form',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4285F4),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                          '1. Khasra Assessment Number / نمبر خسرہ بندوبست',
                          'Type Khasra Assessment Number',
                          _khasraNumberController),
                      _buildTextField(
                          '2. Irrigator Name / نام مالک بقید ولدیت و قومیت',
                          'Type Irrigator Name',
                          _irrigatorNameController,
                          isReadOnly: true),
                      _buildTextField('3. Khata Number /کھاتہ نمبر',
                          'Type Khata Number', _irrigatorKhataNumberController,
                          isReadOnly: true),
                      _buildDateTextField('4. Entry Date / تاریخ اندراج',
                          'Type Entry Date', _registrationDateController,
                          isReadOnly: true, context: context),
                      _buildTextField(
                          '5. Tenant Name / نام مالگزار بقید ولدیت',
                          'Type Tenant Name and Father Name',
                          _tenantNameController),
                      _buildTextField(
                          "6. Cultivator's Information / نام کاشتکار بقید ولدیت وقومیت وسکونت",
                          'Type Cultivator Information',
                          _cultivatorsInfoController),
                      _buildDateTextField('7. Sowing Date /تاریخ تخمریزی',
                          'Type Sowing Date', _snowingDateController,
                          isReadOnly: true, context: context),
                      const SizedBox(height: 24),
                      const Text(
                        'Crop Type Registration / انداراج جنس شدکار',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4285F4),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Land Assessment / اراضی تخمینہ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField('8. Marla / مرلہ', 'Type Marla',
                          _landAssessmentMarlaController),
                      _buildTextField('9. Kanal / کنال', 'Type Kanal',
                          _landAssessmentKanalController),
                      _buildTextField(
                          '10. Previous Crop Name with Grade / نام جنس جو پہلے بوئی گئی',
                          'Type Previous Crop Name with Grade',
                          _previousCropController),
                      const SizedBox(height: 24),
                      const Text(
                        'Final Measurement / پیمائش پختہ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4285F4),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildDateTextField(
                          '11. Date / تاریخ', 'Select Date', _dateController,
                          isReadOnly: true, context: context),
                      _buildTextField(
                          '12. Length / طول', 'Type Length', _lengthController),
                      _buildTextField(
                          '13. Width / عرض', 'Type Width', _widthController),
                      const SizedBox(height: 24),
                      const Text(
                        'Area / رقبہ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4285F4),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField('14. Marla / مرلہ', 'Type Marla',
                          _areaMarlaController),
                      _buildTextField('15. Kanal / کنال', 'Type Kanal',
                          _areaKanalController),
                      _buildDropdown('16. Final Crop Name /فصل کا نام',
                          'Select Final Crop', crops, (value) {
                        Crop val = value as Crop;
                        setState(() => _selectedFinalCropId =
                            int.tryParse(val.id.toString()));
                      }),
                      _buildTextField(
                          '17. Rate', 'Type Rate', _cropPriceController),
                      const SizedBox(height: 24),
                      const Text(
                        'Land Replanting / اراضی دوبارہ کاشت',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4285F4),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField('18. Marla / مرلہ', 'Type Marla',
                          _landReplantingMarlaController),
                      _buildTextField('19. Kanal / کنال', 'Type Kanal',
                          _landReplantingKanalController),
                      const SizedBox(height: 24),
                      const Text(
                        'Double Crop Land / اراضی دو فصلی',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4285F4),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField('20. Marla / مرلہ', 'Type Marla',
                          _doubleCropMarlaController),
                      _buildTextField('21. Kanal / کنال', 'Type Kanal',
                          _doubleCropKanalController),
                      const SizedBox(height: 24),
                      const Text(
                        'Irrigated Area / مجرائی رقبہ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4285F4),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField('22. Marla / مرلہ', 'Type Marla',
                          _irrigatedAreaMarlaController),
                      _buildTextField('23. Kanal / کنال', 'Type Kanal',
                          _irrigatedAreaKanalController),
                      const SizedBox(height: 24),
                      const Text(
                        'Identifiable Area / رقبہ قابل تشخیص`',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4285F4),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField('24. Marla / مرلہ', 'Type Marla',
                          _identifiableAreaMarlaController),
                      _buildTextField('25. Kanal / کنال', 'Type Kanal',
                          _identifiableAreaKanalController),
                      const SizedBox(height: 24),
                      const Text(
                        'Land Quality / کیفیت',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4285F4),
                        ),
                      ),
                      _buildTextField(
                          '', 'Type Land Quality', _landQualityController),
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

  Widget _buildTextField(
      String label, String hint, TextEditingController controller,
      {bool isReadOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          TextFormField(
            controller: controller,
            readOnly: isReadOnly,
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $hint';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateTextField(
      String label, String hint, TextEditingController controller,
      {bool isReadOnly = false, BuildContext? context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          TextFormField(
            controller: controller,
            readOnly: isReadOnly,
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $hint';
              }
              return null;
            },
            onTap: isReadOnly
                ? () async {
                    if (context != null) {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        controller.text = formattedDate;
                      }
                    }
                  }
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String hint, List<dynamic> items,
      Function(dynamic) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          DropdownButtonFormField<dynamic>(
            itemHeight: 48,
            dropdownColor: Colors.white,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis),
              border: const OutlineInputBorder(),
            ),
            items: items.map((dynamic value) {
              return DropdownMenuItem<dynamic>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: onChanged,
            validator: (value) {
              if (value == null) {
                return 'Please select $hint';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  //build dropdown with initial value
  Widget _buildDropdownWithInitialValue(String label, String hint,
      List<dynamic> items, Function(dynamic) onChanged, dynamic initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          DropdownButtonFormField<dynamic>(
            itemHeight: 48,
            dropdownColor: Colors.white,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis),
              border: const OutlineInputBorder(),
            ),
            items: items.map((dynamic value) {
              return DropdownMenuItem<dynamic>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: onChanged,
            validator: (value) {
              if (value == null) {
                return 'Please select $hint';
              }
              return null;
            },
            value: initialValue,
          ),
        ],
      ),
    );
  }
}
