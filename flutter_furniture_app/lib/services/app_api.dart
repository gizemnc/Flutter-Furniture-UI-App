import 'dart:convert';
import 'package:flutter/services.dart'; // For rootBundle
import '../model/model.dart'; // Adjust this import based on your file structure

class ApiService {
    Future<AppModel> loadData() async {
    try {
      // Load the JSON file from assets
      final String response = await rootBundle.loadString('assets/model.json');
      
      // Parse the JSON data
      final data = json.decode(response);
      // Convert JSON data to AppModel
      return AppModel.fromJson(data);
      
      
    } catch (e) {
      throw Exception('Veri yüklenirken hata oluştu: $e');
    }
  }
}