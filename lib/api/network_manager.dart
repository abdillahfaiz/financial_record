import 'dart:convert';

import 'package:financial_record/models/finance_models.dart';
import 'package:financial_record/models/finance_total_models.dart';
import 'package:http/http.dart' as http;

class NetworkManager {
  final baseUrl = 'http://127.0.0.1:8000/api';

  Future<FinanceData> getAllData() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/data'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      FinanceData result = FinanceData.fromJson(data);
      return result;
    } else {
      throw Exception('Failed to Load Data');
    }
  }

  Future<FinanceTotalModel> getTotal() async {
    final response = await http.get(Uri.parse('$baseUrl/total'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      FinanceTotalModel result = FinanceTotalModel.fromJson(data);
      return result;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<FinanceData> createData(
      String title, int counted, String category) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        "title": title,
        "counted": counted,
        "category": category,
      }),
    );

    if (response.statusCode == 201) {
      return FinanceData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create data');
    }
  }

  Future deleteData(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/data/delete/$id'),
    );

    if (response.statusCode == 200) {
      print('Berhasil');
    } else {
      print('Tidak berhasil');
    }

    return response;
  }
}
