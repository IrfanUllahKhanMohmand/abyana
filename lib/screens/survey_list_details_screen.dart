import 'package:flutter/material.dart';

class SurveyListDetailsScreen extends StatelessWidget {
  const SurveyListDetailsScreen({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Land Survey / زمین کی سروے',
              [
                _buildInfoRow('Canal / نہر :', 'Peshawar'),
                _buildInfoRow('Outlet / آؤٹ لیٹ:', 'Tarujabba'),
                _buildInfoRow('Season Year / فصل کا سال:', '2024'),
                _buildInfoRow('Crop / فصل:', 'Rice'),
              ],
            ),
            _buildSection(
              'Farmer and Land Registration Form',
              [
                _buildInfoRow('Khasra Assessment Number / نمبر:', '37812'),
                _buildInfoRow('Irrigator Name / نام:', 'Fahad Sheikh'),
                _buildInfoRow('Khata Number / کھاتہ نمبر:', '8231'),
                _buildInfoRow('Entry Date / داخلہ تاریخ:', '24-01-2025'),
                _buildInfoRow('Tenant Name / کاشتکار:', 'Abbas Niazi'),
                _buildInfoRow('Cultivator\'s Information:', 'Zahid Khan'),
                _buildInfoRow('Sowing Date / تاریخ:', '24-01-2025'),
              ],
            ),
            _buildSection(
              'Crop Type Registration / اندراج فصل کی قسم',
              [
                _buildInfoRow('Land Assessment / اراضی:', ''),
                _buildInfoRow('Marla / مرلہ:', '40'),
                _buildInfoRow('Kanal / کنال:', '2'),
                _buildInfoRow('Previous Crop Name:', 'Maize'),
              ],
            ),
            _buildSection(
              'Final Measurement / پیمائش',
              [
                _buildInfoRow('Date / تاریخ:', '25-01-2025'),
                _buildInfoRow('Length / طول:', '4'),
                _buildInfoRow('Width / عرض:', '2'),
              ],
            ),
            _buildSection(
              'Area / رقبہ',
              [
                _buildInfoRow('Marla / مرلہ:', '60'),
                _buildInfoRow('Kanal / کنال:', '2'),
                _buildInfoRow('Final Crop Name:', '2'),
                _buildInfoRow('Rate:', '50'),
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
                _buildInfoRow('Marla / مرلہ:', '80'),
                _buildInfoRow('Kanal / کنال:', '4'),
              ],
            ),
            _buildSection(
              'Irrigated Area / سیراب رقبہ',
              [
                _buildInfoRow('Marla / مرلہ:', '60'),
                _buildInfoRow('Kanal / کنال:', '3'),
              ],
            ),
            _buildSection(
              'Identifiable Area / رقبہ قابل شناخت',
              [
                _buildInfoRow('Marla / مرلہ:', '60'),
                _buildInfoRow('Kanal / کنال:', '3'),
              ],
            ),
            _buildSection(
              'Land Quality / کیفیت',
              [
                _buildInfoRow('Land Quality / کیفیت:', 'Good'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
