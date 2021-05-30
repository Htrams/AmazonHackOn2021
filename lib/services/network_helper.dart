import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<dynamic> getData() async{
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    }
    else {
      print(response.statusCode);
    }
  }
  Future<dynamic> postData(Map<dynamic,dynamic> body) async{
    http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body)
    );
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }
    else {
      print(response.statusCode);
    }
  }
}