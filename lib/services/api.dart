import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  static final _baseUrl = '186.207.238.21:8006';
  String _sessionid;
  Services(this._sessionid);

  Future<Map> callAPI(String method, String url, params) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response;

    var headers = {
      'Content-Type':'application/json'
    };
    
    if(this._sessionid != '')headers['Cookie'] = 'sessionid=${this._sessionid}';
    print(json.encode(params));
    prefs.setString('url_api', Uri.http(_baseUrl,'').toString());
    try {
      if (method == 'post')response = await http.post(new Uri.http(_baseUrl, url), headers: headers, body: json.encode(params)).timeout(new Duration(minutes: 1));
      if (method == 'put')response = await http.put(new Uri.http(_baseUrl, url), headers: headers, body: json.encode(params)).timeout(new Duration(minutes: 1));
      if (method == 'get')response = await http.get(new Uri.http(_baseUrl, url, params != '' ? params : {}), headers: headers).timeout(new Duration(minutes: 1));
      if (method == 'delete')response = await http.delete(new Uri.http(_baseUrl, url, params != '' ? params : {}), headers: headers).timeout(new Duration(minutes: 1));
    
      switch (response.statusCode) {
        case 200:
          return {...json.decode(response.body), 'status_api': true };
          break;
        case 500:
          Map res = {}; 
          try {
            res  = json.decode(response.body);
          } catch (e) {
            res = {'error': e.toString()};
          }
          return {'msg': res['error'], 'status_api': false};
        case 403:
          return {...json.decode(response.body), 'status_api': false };
          break;
        case 404:
          return {'msg': 'Status 404', 'status_api': false};
          break;
        default:
      }
    } catch (e) {
      return {'msg': e, 'status_api': false};
    }
  }
}