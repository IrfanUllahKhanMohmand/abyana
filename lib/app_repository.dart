import 'dart:convert';
import 'package:abyana/models/canal.dart';
import 'package:abyana/models/halqa.dart';
import 'package:abyana/models/irrigator.dart';
import 'package:abyana/models/village.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppRepository {
  final String baseUrl =
      'https://testproject.famzhost.com/public/abyana/public/api/';

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${baseUrl}login'),
      body: {
        'email': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', json.decode(response.body)['token']);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  //Logout
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  //Get Villages
  Future<List<Village>> getVillages() async {
    final response = await http.get(Uri.parse('${baseUrl}villages'));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return (result as List).map((e) => Village.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load villages');
    }
  }

  //Get Canals
  Future<List<Canal>> getCanals() async {
    final response = await http.get(Uri.parse('${baseUrl}canals'));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return (result['data'] as List).map((e) => Canal.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load canals');
    }
  }

  //Get Halqas
  Future<List<Halqa>> getHalqas() async {
    final response = await http.get(Uri.parse('${baseUrl}getHalqaData'));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return (result['halqas'] as List).map((e) => Halqa.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load halqas');
    }
  }

  // CRUD operations for Irrigators
  Future<List<Irrigator>> getIrrigators() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response =
        await http.get(Uri.parse('${baseUrl}irrigators'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return (result['irrigators'] as List)
          .map((e) => Irrigator.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load irrigators');
    }
  }

  Future<Map<String, dynamic>> getIrrigator(int id) async {
    final response = await http.get(Uri.parse('${baseUrl}irrigators/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load irrigator');
    }
  }

  Future<Map<String, dynamic>> createIrrigator(
      Map<String, dynamic> irrigator) async {
    final response = await http.post(
      Uri.parse('${baseUrl}AddIrragtor'),
      body: json.encode(irrigator),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create irrigator');
    }
  }

  Future<Map<String, dynamic>> updateIrrigator(
      int id, Map<String, dynamic> irrigator) async {
    final response = await http.put(
      Uri.parse('${baseUrl}irrigators/$id'),
      body: json.encode(irrigator),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update irrigator');
    }
  }

  Future<void> deleteIrrigator(int id) async {
    final response = await http.delete(Uri.parse('${baseUrl}irrigators/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete irrigator');
    }
  }

  // CRUD operations for Crop Survey
  Future<List<dynamic>> getCropSurveys() async {
    final response = await http.get(Uri.parse('${baseUrl}crop-surveys'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load crop surveys');
    }
  }

  Future<Map<String, dynamic>> getCropSurvey(int id) async {
    final response = await http.get(Uri.parse('${baseUrl}crop-surveys/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load crop survey');
    }
  }

  Future<Map<String, dynamic>> createCropSurvey(
      Map<String, dynamic> cropSurvey) async {
    final response = await http.post(
      Uri.parse('${baseUrl}crop-surveys'),
      body: json.encode(cropSurvey),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create crop survey');
    }
  }

  Future<Map<String, dynamic>> updateCropSurvey(
      int id, Map<String, dynamic> cropSurvey) async {
    final response = await http.put(
      Uri.parse('${baseUrl}crop-surveys/$id'),
      body: json.encode(cropSurvey),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update crop survey');
    }
  }

  Future<void> deleteCropSurvey(int id) async {
    final response = await http.delete(Uri.parse('${baseUrl}crop-surveys/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete crop survey');
    }
  }
}
