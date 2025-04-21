import 'dart:io';

import 'package:flutter/foundation.dart';

class Location {
  String title;
  String category;
  String roadAddress;
  String link;
 
  Location(
      {
        required this.title, 
        required this.category, 
        required this.roadAddress,
        required this.link
        });

  Location.fromJson(Map<String, dynamic> map)
      : this(
            title: map['title'],
            category: map['category'],
            roadAddress: map['roadAddress'],
            link: map['link'],
            );

  Map<String, dynamic> toJson(){
    return {
      'title':title,
      'category': category,
      'roadAddress': roadAddress,
      'link':link
    };
  }
}
