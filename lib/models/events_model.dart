/// events : [{"title":"Texas Rangers at Chicago White Sox","short_title":"Rangers at White Sox","datetime_local":"2022-06-11T13:10:00","venue":{"display_location":"Chicago, IL"},"performers":[{"image":"https://seatgeek.com/images/performers-landscape/chicago-white-sox-870367/23/huge.jpg"}]}]
/// meta : {"total":105,"took":6,"page":1,"per_page":10,"geolocation":null}

class EventsModel {
  List<Events>? _events;
  Meta? _meta;

  List<Events>? get events => _events;
  Meta? get meta => _meta;

  EventsModel({
      List<Events>? events,
      Meta? meta}){
    _events = events;
    _meta = meta;
}

  EventsModel.fromJson(dynamic json) {
    if (json["events"] != null) {
      _events = [];
      json["events"].forEach((v) {
        _events?.add(Events.fromJson(v));
      });
    }
    _meta = json["meta"] != null ? Meta.fromJson(json["meta"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_events != null) {
      map["events"] = _events?.map((v) => v.toJson()).toList();
    }
    if (_meta != null) {
      map["meta"] = _meta?.toJson();
    }
    return map;
  }

}

/// total : 105
/// took : 6
/// page : 1
/// per_page : 10
/// geolocation : null

class Meta {
  int? _total;
  int? _took;
  int? _page;
  int? _perPage;
  dynamic _geolocation;

  int? get total => _total;
  int? get took => _took;
  int? get page => _page;
  int? get perPage => _perPage;
  dynamic get geolocation => _geolocation;

  Meta({
      int? total,
      int? took,
      int? page,
      int? perPage,
      dynamic geolocation}){
    _total = total;
    _took = took;
    _page = page;
    _perPage = perPage;
    _geolocation = geolocation;
}

  Meta.fromJson(dynamic json) {
    _total = json["total"];
    _took = json["took"];
    _page = json["page"];
    _perPage = json["per_page"];
    _geolocation = json["geolocation"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["total"] = _total;
    map["took"] = _took;
    map["page"] = _page;
    map["per_page"] = _perPage;
    map["geolocation"] = _geolocation;
    return map;
  }

}

/// title : "Texas Rangers at Chicago White Sox"
/// short_title : "Rangers at White Sox"
/// datetime_local : "2022-06-11T13:10:00"
/// venue : {"display_location":"Chicago, IL"}
/// performers : [{"image":"https://seatgeek.com/images/performers-landscape/chicago-white-sox-870367/23/huge.jpg"}]

class Events {
  String? _title;
  String? _shortTitle;
  String? _datetimeLocal;
  Venue? _venue;
  List<Performers>? _performers;

  String? get title => _title;
  String? get shortTitle => _shortTitle;
  String? get datetimeLocal => _datetimeLocal;
  Venue? get venue => _venue;
  List<Performers>? get performers => _performers;

  Events({
      String? title,
      String? shortTitle,
      String? datetimeLocal,
      Venue? venue,
      List<Performers>? performers}){
    _title = title;
    _shortTitle = shortTitle;
    _datetimeLocal = datetimeLocal;
    _venue = venue;
    _performers = performers;
}

  Events.fromJson(dynamic json) {
    _title = json["title"];
    _shortTitle = json["short_title"];
    _datetimeLocal = json["datetime_local"];
    _venue = json["venue"] != null ? Venue.fromJson(json["venue"]) : null;
    if (json["performers"] != null) {
      _performers = [];
      json["performers"].forEach((v) {
        _performers?.add(Performers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    map["short_title"] = _shortTitle;
    map["datetime_local"] = _datetimeLocal;
    if (_venue != null) {
      map["venue"] = _venue?.toJson();
    }
    if (_performers != null) {
      map["performers"] = _performers?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// image : "https://seatgeek.com/images/performers-landscape/chicago-white-sox-870367/23/huge.jpg"

class Performers {
  String? _image;

  String? get image => _image;

  Performers({
      String? image}){
    _image = image;
}

  Performers.fromJson(dynamic json) {
    _image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["image"] = _image;
    return map;
  }

}

/// display_location : "Chicago, IL"

class Venue {
  String? _displayLocation;

  String? get displayLocation => _displayLocation;

  Venue({
      String? displayLocation}){
    _displayLocation = displayLocation;
}

  Venue.fromJson(dynamic json) {
    _displayLocation = json["display_location"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["display_location"] = _displayLocation;
    return map;
  }

}