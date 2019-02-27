import 'dart:async';

import '../lib/jsonrequest.dart';

void main() {
  Future<JsonObject> jsonRequest = JsonObject.get("https://jsonplaceholder.typicode.com/todos/1");
  jsonRequest.then((json) {
    print(json["title"]);
  });
}