import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

import '../../../../core/utils/api_constants.dart';

class FeedingAIService {
  final String baseUrl = "${ApiConstants.baseUrl}/ai/food/analyze";

  Future<String> sendImage(File imageFile, String modelType) async {
    final url = Uri.parse(baseUrl);

    var request = http.MultipartRequest('POST', url);

    request.fields['modelType'] = modelType;

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print("STATUS = ${response.statusCode}");
    print("BODY = ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return "${data['label']} (${data['confidence']})\n${data['description']}";
    } else {
      final data = jsonDecode(response.body);

      // 👇 نرجع نفس رسالة الباكند
      throw Exception(data['message'] ?? response.body);
    }

    throw Exception(response.body);
  }
}
