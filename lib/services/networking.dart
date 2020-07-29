import 'package:http/http.dart' as http;
import 'dart:convert';
import 'location.dart';

class Network {
  Network(this.url);

  final String url;

  Location location = Location();

  Future<dynamic> response() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return data;
    } else {
      print(response.statusCode);
    }
  }
}
