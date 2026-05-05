import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../../core/utils/api_constants.dart';
class SkinAIService {
  final String baseUrl = "${ApiConstants.baseUrl}/ai";

  Future<Map<String, dynamic>> analyzeImage(File imageFile) async {
    final url = Uri.parse('$baseUrl/skin/analyze');

    print("REQUEST URL: $url");

    var request = http.MultipartRequest('POST', url);

    request.files.add(
      await http.MultipartFile.fromPath('image', imageFile.path),
    );

    final response = await request.send();
    final resBody = await http.Response.fromStream(response);

    print("STATUS: ${response.statusCode}");
    print("BODY: ${resBody.body}");

    if (resBody.body.isEmpty) {
      throw Exception("Empty response");
    }

    return jsonDecode(resBody.body);
  }
}