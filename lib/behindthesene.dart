import 'package:http/http.dart';
import 'dart:convert';

class Behindthesene {
  var urL;
  Future extramethod(urL) async {
    Response response = await get(Uri.parse(urL));
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
