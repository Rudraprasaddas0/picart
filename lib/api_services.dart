import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:picart/api_key.dart';

class Api {
  static final url = Uri.parse("https://api.openai.com/v1/images/generations");
  static const apikey ="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";

  static final headers = {"Content-Type": "application/json","Authorization": "Bearer $apikey"};

  // static generateImage(String text,String size) async {
  //   var res = await http.post(
  //     url,
  //     headers: headers,
  //     body: jsonEncode({"prompt":text,"n": 1,"size": size}),
  //   );
  //
  //   if(res.statusCode==200){
  //     var data = jsonDecode(res.body.toString());
  //     return data ['data'][0]['url'].toString();
  //   }else{
  //     print("Failed to fatch images");
  //   }
  // }

  static Future<String> generateImage(String text, String size) async {
    var res = await http.post(
      url,
      headers: headers,
      body: jsonEncode({"prompt":text,"n": 1,"size": size}),
    );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body.toString());
      return data['data'][0]['url'].toString();
    } else {
      throw Exception("Failed to fetch image");
    }
  }


}