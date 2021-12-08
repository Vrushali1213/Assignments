import 'package:appnew/map.dart';
import 'package:flutter/material.dart';
import 'package:appnew/home.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Assignment'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(children: [
          SizedBox(height: 300,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SizedBox(
              width: 200.0,
              height: 50.0,
              //padding: const EdgeInsets.only(left: 20.0, top: 20.0),
              child:
              RaisedButton(
                color: Colors.grey,//Color(0xff09a8d9),
                splashColor: Colors.lightBlue,
                shape: StadiumBorder(),
                onPressed: () {
                  Get.to(() => HomePage());
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => HomePage(),
//                      ));

//                    Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Exercise 1',
                      style: TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),),
          SizedBox(height: 20,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SizedBox(
              width: 200.0,
              height: 50.0,
              //padding: const EdgeInsets.only(left: 20.0, top: 20.0),
              child:
              RaisedButton(
                color: Colors.grey,//Color(0xff09a8d9),
                splashColor: Colors.lightBlue,
                shape: StadiumBorder(),
                onPressed: () {
                  Get.to(() => MapPage());
                  },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Exercise 2',
                      style: TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),),

        ],
        ),
      ),
    );
  }
}
