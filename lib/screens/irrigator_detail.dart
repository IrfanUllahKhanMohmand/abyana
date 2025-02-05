import 'package:abyana/models/irrigator.dart';
import 'package:flutter/material.dart';

class IrrigatorDetail extends StatelessWidget {
  const IrrigatorDetail({super.key, required this.irrigator});
  final Irrigator irrigator;

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          Expanded(
            child: Text(value),
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
        backgroundColor: Color(0xFF4285F4),
        title: const Text('Irrigator Detail',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      _buildDetailItem('Father Name /والد کا نام',
                          "Irrigator's Father Name"),
                      _buildDetailItem('Mobile Number / موبائل نمبر',
                          irrigator.irrigatorMobileNumber),
                      _buildDetailItem('Halqa / حلقہ', irrigator.halqaName),
                      _buildDetailItem('Village / موضع', irrigator.villageName),
                      _buildDetailItem('Canal / نہر', "Irrigator's Canal"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
