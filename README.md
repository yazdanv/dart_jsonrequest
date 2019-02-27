# Network JSON Request package.
the package consists of JsonObject and JsonArray and handlers to get JsonArray from objects and JsonObject from arrays
the most important part of this package is the ability to get async json directly from network calls
it implements async GET and POST request simply by calling its network handlers



#### On Dart Packages : https://pub.dartlang.org/packages/jsonrequest



## Use this package as a library

#### 1. Depend on it
Add this to your package's pubspec.yaml file:

~~~~ yaml
dependencies:
  jsonrequest: ^0.1.1
~~~~

#### 2. Install it
You can install packages from the command line:

with pub:

~~~~ bash
$ pub get
~~~~
with Flutter:

~~~~ bash
$ flutter packages get
~~~~
Alternatively, your editor might support pub get or flutter packages get. Check the docs for your editor to learn more.

#### 3. Import it
Now in your Dart code, you can use:

~~~~dart
import 'package:jsonrequest/jsonrequest.dart';
~~~~



# Getting Started


### GET Request

##### Plain Request


~~~~ dart
Future<JsonObject> futureJson = JsonObject.get("http://example.com/api/get/", parameters: {"id": "1234"}, headers: {"Authorization": "Bearer 123456"});
~~~~

it has options to provide query parameters and headers


##### Using with FutureBuilder


~~~~ dart
FutureBuilder<JsonObject>(
  future: JsonObject.get("http://example.com/api/get/", parameters: {"id": "1234"}, headers: {"Authorization": "Bearer 123456"});
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      JsonArray list = snapshot.data.array("list");
      ListView lv = ListView.builder(
          padding: new EdgeInsets.all(8.0),
          itemExtent: 100.0,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            JsonObject json = list.object(index);
            return Text(json["key"]);
          }
      );
      return lv;
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }
    return CircularProgressIndicator();
  },
)
~~~~






### POST Request

##### Plain Request



~~~~ dart
Future<JsonObject> futureJson = JsonObject.post("http://example.com/api/get/", parameters: {"id": "1234"}, headers: {"Authorization": "Bearer 123456"}, coding: PostCoding.JSON);
~~~~

it has options to provide post parameters and headers
the parameter encoding could be three types :
~~~~ dart
PostCoding.UrlEncoded //url ecoded parameter encoding with 'application/json' Content-Type
PostCoding.JSON // json encoded parameter encoding with 'application/x-www-form-urlencoded' Content-Type
PostCoding.Form //post form encoding
~~~~


##### Using with FutureBuilder



~~~~ dart
FutureBuilder<JsonObject>(
  future: JsonObject.post("http://example.com/api/get/", parameters: {"id": "1234"}, headers: {"Authorization": "Bearer 123456"}, coding: PostCoding.JSON);
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      JsonArray list = snapshot.data.array("list");
      ListView lv = ListView.builder(
          padding: new EdgeInsets.all(8.0),
          itemExtent: 100.0,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            JsonObject json = list.object(index);
            return Text(json["key"]);
          }
      );
      return lv;
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    }
    return CircularProgressIndicator();
  },
)
~~~~

