library networkjson;

import 'dart:core';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class JsonObject {
  Map<String, dynamic> jsonMap;

  static Future<JsonObject> get(url,
      {Map<String, dynamic> parameters, dynamic headers}) async {
    if (parameters != null) {
      int i = 0;
      parameters.forEach((String key, dynamic value) {
        if (i == 0) {
          url += "?";
        } else {
          url += "&";
        }
        url += "$key=$value";
        i++;
      });
    }
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      JsonObject jsn = JsonObject();
      jsn.jsonMap = json.decode(response.body);
      return jsn;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<JsonObject> post(url,
      {PostCoding coding = PostCoding.UrlEncoded,
      Map<String, dynamic> parameters,
      dynamic headers}) async {
    var body = "";
    if (parameters != null) {
      if (coding == PostCoding.UrlEncoded) {
        headers["Content-Type"] = "application/x-www-form-urlencoded";
        parameters.forEach((String key, dynamic value) {
          body += "$key:$value\n";
        });
      } else if (coding == PostCoding.Json) {
        headers["Content-Type"] = "application/json";
        body = json.encode(parameters);
      }
    }
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      JsonObject jsn = JsonObject();
      jsn.jsonMap = json.decode(response.body);
      return jsn;
    } else {
      throw Exception('Failed to load data');
    }
  }

  operator [](String key) => jsonMap[key];

  value(key) {
    if (jsonMap.containsKey(key)) {
      return jsonMap[key];
    }
    return null;
  }

  array(key) {
    if (jsonMap.containsKey(key)) {
      JsonArray array = JsonArray();
      array.jsonArray = jsonMap[key] as List<dynamic>;
      return array;
    }
    return null;
  }
}

class JsonArray {
  List<dynamic> jsonArray;

  int get length {
    return jsonArray.length;
  }

  operator [](int i) => jsonArray[i];

  static Future<JsonArray> get(url,
      {Map<String, dynamic> parameters, dynamic headers}) async {
    if (parameters != null) {
      int i = 0;
      parameters.forEach((String key, dynamic value) {
        if (i == 0) {
          url += "?";
        } else {
          url += "&";
        }
        url += "$key=$value";
        i++;
      });
    }
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      JsonArray jsn = JsonArray();
      jsn.jsonArray = json.decode(response.body);
      return jsn;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<JsonArray> post(url,
      {PostCoding coding = PostCoding.UrlEncoded,
      Map<String, dynamic> parameters,
      dynamic headers}) async {
    var body = "";
    if (parameters != null) {
      if (coding == PostCoding.UrlEncoded) {
        headers["Content-Type"] = "application/x-www-form-urlencoded";
        parameters.forEach((String key, dynamic value) {
          body += "$key:$value\n";
        });
      } else if (coding == PostCoding.Json) {
        headers["Content-Type"] = "application/json";
        body = json.encode(parameters);
      }
    }
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      JsonArray jsn = JsonArray();
      jsn.jsonArray = json.decode(response.body);
      return jsn;
    } else {
      throw Exception('Failed to load data');
    }
  }

  object(int index) {
    dynamic item = jsonArray[index];
    JsonObject json = JsonObject();
    json.jsonMap = item as Map<String, dynamic>;
    return json;
  }

  string(int index) {
    dynamic item = jsonArray[index];
    return item as String;
  }
}

//// enums

enum PostCoding { UrlEncoded, PostForm, Json }
