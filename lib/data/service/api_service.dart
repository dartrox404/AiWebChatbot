import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<String> aimessage(String message) async {
    final apikey = dotenv.env["APIKEY"];
    final apiurl = dotenv.env["URL"];
    if (apikey == null || apikey.isEmpty) {
      throw Exception("No API found in .env file");
    }
    if (apiurl == null || apiurl.isEmpty) {
      throw Exception("No APIURL found in .env file");
    }

    final headers = {
      "Authorization": "Bearer $apikey",
      "content-Type": "application/json",
    };
    final Map<String, dynamic> bodyparameter = {
      "model": "openai/gpt-4o-mini",
      "messages": [
        {"role": "user", "content": message},
      ],
    };

    try {
      final response = await http.post(
        Uri.parse(apiurl),
        body: jsonEncode(bodyparameter),
        headers: headers,
      );
      if (response.statusCode != 200) {
        throw Exception("Api Error  :${response.statusCode}-${response.body}");
      }
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final choices = data["choices"] as List?;
      if (choices == null || choices.isEmpty) {
        throw Exception("API Error : Invlaid Api No chocies found");
      }
      final content = choices[0]["message"]["content"];
      if (content == null) {
        throw Exception("Invalid API : no content found");
      }
      return content as String;
    } catch (e) {
      rethrow;
    }
  }
}
