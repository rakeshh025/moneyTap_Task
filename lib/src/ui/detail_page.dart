import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wiki_search_app/src/models/search_results.dart' as Page;


class DetailPage extends StatelessWidget {
  final Page.Page item;
  final String url;
  DetailPage({Key key, this.item, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final webView = WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,

    );

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(item.title),
      ),
      body: webView,
    );
  }
}