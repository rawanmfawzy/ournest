import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import '../../../../core/utils/api_constants.dart';

class SkinAIService {
  final String baseUrl = "${ApiConstants.baseUrl}/ai";

  Future<String> sendImage(File imageFile, String modelType) async {
    final url = Uri.parse('$baseUrl/skin/analyze');
    var request = http.MultipartRequest('POST', url);
    request.fields['modelType'] = modelType;

    final ext = imageFile.path.split('.').last.toLowerCase();
    final contentType = (ext == 'png')
        ? MediaType('image', 'png')
        : MediaType('image', 'jpeg');

    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      contentType: contentType,
    ));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return "${data['label']} (${data['confidence']})\n${data['description']}";
    } else {
      return "Error: ${response.body}";
    }
  }
}
