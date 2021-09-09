import 'dart:convert';

import 'package:json_feed/Models/Youtubes.dart';
import 'package:http/http.dart' as http;
import 'package:json_feed/Models/testjson.dart';


class Network{
  static Future<List<Youtube>> fetchYoutube({final type = "superhero"}) async {

    final url = Uri.parse('https://codemobiles.com/adhoc/youtubes/index_new.php?username=admin&password=password&type=${type}');

    final response = await http.get(url);



    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      final jsonResponse = json.decode(response.body);

      // final List jsonResponse = json.decode(response.body);

      List<JsonTest> result = jsonResponse.map((i)=>JsonTest.fromJson(i)).toList();
      Youtubes youtubeList = Youtubes.fromJson(jsonResponse);




     return youtubeList.youtubes;

      // return youtubeList.youtubes;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
