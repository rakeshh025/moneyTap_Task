import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_search_app/src/blocs/search_bloc.dart';
import 'package:wiki_search_app/src/blocs/search_event.dart';
import 'package:wiki_search_app/src/ui/search_result_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Wiki Search'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class TextValidate {
  static String validate(String value) {
    return (value.isEmpty) ? 'Please enter something to search' : null;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String _searchText;
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle buttonStyle = TextStyle(
      fontFamily: "Ubuntu-Medium",
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      color: Color(0XFFFFFFFF),
    );

    TextStyle inputFieldStyle = TextStyle(
      fontFamily: "Ubuntu",
      fontSize: 12,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      color: Colors.grey,
    );

    final searchField = TextFormField(
      scrollPadding: EdgeInsets.only(top: 5, bottom: 5),
      textAlign: TextAlign.left,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Enter text to search',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(0.0),
          ),
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
        errorStyle: inputFieldStyle.copyWith(color: Colors.orange),
      ),
      validator: (value) => TextValidate.validate(value),
      onSaved: (val) => _searchText = val,
    );

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: searchField),
              Padding(
                padding:  EdgeInsets.fromLTRB(
                    size.width *.3,
                    0,
                    size.width *.3,
                    0),
                child: RaisedButton(
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Search ",
                        style: buttonStyle,),
                      Image.asset('images/wiki_logo.png', height: 25,width: 25)
                    ],
                  ),
                  onPressed: () {
                    final form = formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return BlocProvider<SearchBloc>(
                          create: (context) => SearchBloc()..add(UserReachesSearchPageEvent(searchString: _searchText)),
                          child: SearchResultPage(),
                        );
                      }));
                    }
                    return null;
                  },
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
