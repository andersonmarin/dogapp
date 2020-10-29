import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smartmei_app/models/breed_response.dart';

const baseURL = 'https://dog.ceo/api';

class BreedsService {
  Future<List<String>> findAll() async {
    var result = await http.get('$baseURL/breeds/list/all');
    var response =
        BreedsResponse<Map<String, dynamic>>.fromJson(jsonDecode(result.body));

    if (response.status != 'success') {
      throw Exception('api error');
    }

    return response.message.keys.toList();
  }

  Future<List<String>> findImagesByBreed(String breed) async {
    var p = breed.toLowerCase();
    var result = await http.get('$baseURL/breed/$p/images');
    return jsonDecode(result.body)["message"].cast<String>();
  }
}
