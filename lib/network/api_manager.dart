import 'package:http/http.dart' as http;
import '../logs.dart';
import '../models/events_model.dart';
import 'apis.dart';
import 'dart:convert' as convert;

class APIManager {
  // Self Instance since we are creating a Singleton Class
  static final APIManager _shared = APIManager._internal();

  // Private Constructor
  APIManager._internal();

  // Factory Constructor
  factory APIManager() {
    return _shared;
  }

  // Dummy Method of fetchData
  // This will generate a String list and return that list
  Future fetchData(int currentPage, String q) async {
    String api = '${APIs.BASE_URL}$q&page=$currentPage';
    var response = await http.get(Uri.parse(api)).timeout(
      const Duration(seconds: 100),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response('Timeout exception', 500);
      },
    );

    appLogs('api=$api response ${response}');
    if (response.statusCode == 200) {
      appLogs('response=${response.body}');
      try{
        EventsModel? model = EventsModel.fromJson(convert.jsonDecode(response.body));
        return model;

      } on Exception catch(e){
        appLogs('Exception: $e');
      }
    } else {
      appLogs('Request failed with status: ${response.statusCode}.');
      return null;
    }

    // List<String> _list = [];
    // int startIndex = currentPage * 10;
    // for (int i = startIndex; i < startIndex + 10; i++) {
    //   _list.add("Item #$i");
    // }
    // return _list;
  }
}