import 'package:flutter/material.dart';

class CropSurveyScreen extends StatelessWidget {
  const CropSurveyScreen({super.key});

  Widget _buildTextField(String label, String hint, {bool isReadOnly = false}) {
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
          TextField(
            readOnly: isReadOnly,
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String hint, List<String> items) {
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
          DropdownButtonFormField<String>(
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
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (_) {},
          ),
        ],
      ),
    );
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
      body: SingleChildScrollView(
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
              _buildDropdown('Village / گاؤں', 'Select Village', []),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField('Canal / نہر', 'Enter Canal'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField('Outlet / موگیہ', 'Enter Outlet'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                        'Season Year / فصل کا سال', 'Type Crop Year'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdown('Crop / فصل', 'Select Crop', []),
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
              _buildTextField('1. Khasra Assessment Number / نمبر خسرہ بندوبست',
                  'Type Khasra Assessment Number'),
              _buildTextField('2. Irrigator Name / نام مالک بقید ولدیت و قومیت',
                  'Type Irrigator Name'),
              _buildTextField(
                  '3. Khata Number /کھاتہ نمبر', 'Type Khata Number'),
              _buildTextField(
                  '4. Entry Date / تاریخ اندراج', 'Type Entry Date'),
              _buildTextField('5. Tenant Name / نام مالگزار بقید ولدیت',
                  'Type Tenant Name and Father Name'),
              _buildTextField(
                  "6. Cultivator's Information / نام کاشتکار بقید ولدیت وقومیت وسکونت",
                  'Type Cultivator Information'),
              _buildTextField(
                  '7. Sowing Date /تاریخ تخمریزی', 'Type Sowing Date'),
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
              _buildTextField('8. Marla / مرلہ', 'Type Marla'),
              _buildTextField('9. Kanal / کنال', 'Type Kanal'),
              _buildTextField(
                  '10. Previous Crop Name with Grade / نام جنس جو پہلے بوئی گئی',
                  'Type Previous Crop Name with Grade'),
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
              _buildTextField('11. Date / تاریخ', 'Select Date'),
              _buildTextField('12. Length / طول', 'Type Length'),
              _buildTextField('13. Width / عرض', 'Type Width'),
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
              _buildTextField('14. Marla / مرلہ', 'Type Marla'),
              _buildTextField('15. Kanal / کنال', 'Type Kanal'),
              _buildTextField('16. Final Crop Name /فصل کا نام', 'Type Marla'),
              _buildTextField('17. Rate', 'Type Kanal'),
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
              _buildTextField('18. Marla / مرلہ', 'Type Marla'),
              _buildTextField('19. Kanal / کنال', 'Type Kanal'),
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
              _buildTextField('20. Marla / مرلہ', 'Type Marla'),
              _buildTextField('21. Kanal / کنال', 'Type Kanal'),
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
              _buildTextField('22. Marla / مرلہ', 'Type Marla'),
              _buildTextField('23. Kanal / کنال', 'Type Kanal'),
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
              _buildTextField('24. Marla / مرلہ', 'Type Marla'),
              _buildTextField('25. Kanal / کنال', 'Type Kanal'),
              const SizedBox(height: 24),
              const Text(
                'Land Quality / کیفیت',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4285F4),
                ),
              ),
              _buildTextField('', 'Type Land Quality'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4880FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text('Submit',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
