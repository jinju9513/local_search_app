import 'package:flutter/foundation.dart';

class Location {
  String title;
  String category;
  String roadAddress;
 
  Location(
      {
        required this.title, 
        required this.category, 
        required this.roadAddress});

  Location.fromJson(Map<String, dynamic> map)
      : this(
            title: map['title'],
            category: map['category'],
            roadAddress: map['roadAddress']);

  Map<String, dynamic> toJson(){
    return {
      'title':title,
      'category': category,
      'roadAddress': roadAddress
    };
  }
}
