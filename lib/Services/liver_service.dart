import 'package:http/http.dart' as http;
import 'package:patient_tracking/Models/liverInfo.dart';
import '../global.dart';
import 'http_service.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LiverService {
  static String url = dotenv.env['API_URL'] + '/faqs';

  static Future<LiverInfo> getLiverInfo() async {
    LiverInfo liver = new LiverInfo("i1", "i2");
    await HTTPService.httpGET(url, appendToken: true)
        .then((http.Response response) {
      print(response.body);
      if (Global.successList.contains(response.statusCode)) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        var jsonData =
            new List<Map<String, dynamic>>.from(jsonResponse['data']);
        jsonData.forEach((data) {
          if (data['id'] == 1) {
            liver.i1 = data['description'];
          } else if (data['id'] == 2) {
            liver.i2 = data['description'];
          }
        });
      }
    });
    return liver;
  }
}
