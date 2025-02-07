import 'dart:convert';
import 'package:abyana/models/canal.dart';
import 'package:abyana/models/crop.dart';
import 'package:abyana/models/crop_price.dart';
import 'package:abyana/models/halqa.dart';
import 'package:abyana/models/irrigator.dart';
import 'package:abyana/models/outlet.dart';
import 'package:abyana/models/survey.dart';
import 'package:abyana/models/user.dart';
import 'package:abyana/models/village.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'models/survey_summary.dart';

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
      final result = json.decode(response.body);
      final user = User.fromRemoteJson(result);
      saveUser(user.toJson());
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  // Save User Locally
  Future<void> saveUser(Map<String, dynamic> user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.encode(user));
  }

  // Get User Locally
  Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('user') ?? '';
    return User.fromJson(json.decode(user));
  }

  //Logout
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  //Get Villages
  Future<List<Village>> getVillages() async {
    final response = await http.get(Uri.parse('${baseUrl}villages'));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final villages =
          (result as List).map((e) => Village.fromJson(e)).toList();
      User user = await getUser();
      // Filter villages based on user halqa
      return villages
          .where((village) => village.halqaId == user.halqaId)
          .toList();
    } else {
      throw Exception('Failed to load villages');
    }
  }

  //Get Canals
  // Future<List<Canal>> getCanals() async {
  //   // Get the filtered villages
  //   List<Village> villages = await getVillages();
  //   List<int> villageIds = villages.map((v) => v.villageId).toList();

  //   final response = await http.get(Uri.parse('${baseUrl}canals'));

  //   if (response.statusCode == 200) {
  //     final result = json.decode(response.body);
  //     List<Canal> canals =
  //         (result['data'] as List).map((e) => Canal.fromJson(e)).toList();

  //     // Filter canals based on villageId
  //     return canals
  //         .where((canal) => villageIds.contains(canal.villageId))
  //         .toList();
  //   } else {
  //     throw Exception('Failed to load canals');
  //   }
  // }

  Future<List<Canal>> getCanals() async {
    final response = await http.get(Uri.parse('${baseUrl}canals'));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      List<Canal> canals =
          (result['data'] as List).map((e) => Canal.fromJson(e)).toList();
      return canals;
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

  //get crops
  Future<List<Crop>> getCrops() async {
    final response = await http.get(Uri.parse('${baseUrl}crops'));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return (result['data'] as List).map((e) => Crop.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load crops');
    }
  }

  //cropprices
  Future<List<CropPrice>> getCropPrices() async {
    final response = await http.get(Uri.parse('${baseUrl}cropprice'));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return (result['data'] as List)
          .map((e) => CropPrice.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load crop prices:');
    }
  }

  //outlets
  Future<List<Outlet>> getOutlets() async {
    final response = await http.get(Uri.parse('${baseUrl}outlet'));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return (result['data'] as List).map((e) => Outlet.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load outlets');
    }
  }

  // CRUD operations for Irrigators
  Future<List<Irrigator>> getIrrigators() async {
    final token = (await getUser()).token;
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
  Future<List<SurveySummary>> getCropSurveys() async {
    final token = (await getUser()).token;
    final response =
        await http.get(Uri.parse('${baseUrl}land-surveys'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return (result['data'] as List)
          .map((e) => SurveySummary.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load crop surveys');
    }
  }

  Future<Survey> getCropSurvey(int id) async {
    final token = (await getUser()).token;
    final response =
        await http.get(Uri.parse('${baseUrl}surveys/$id'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return Survey.fromJson(result['data']);
    } else {
      throw Exception('Failed to load crop survey');
    }
  }

  Future<Map<String, dynamic>> createCropSurvey(
      Map<String, dynamic> cropSurvey) async {
    final token = (await getUser()).token;
    final response = await http.post(Uri.parse('${baseUrl}storesurvey'),
        body: json.encode(cropSurvey),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create crop survey: ${response.body}');
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
