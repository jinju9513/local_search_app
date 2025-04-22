import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DetailPage extends StatelessWidget {
  final String link;

  DetailPage({Key? key, required this.link}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("상세보기")),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(link)),
      ),
    );
  }
}
