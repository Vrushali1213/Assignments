import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:appnew/parameter.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}


class _HomePageState extends State<HomePage>
{
  ScrollController _controller;
  List<Parameter> _list1=List<Parameter>();
  List<Parameter> _list2=List<Parameter>();

  Future<List<Parameter>> apiData() async {
    String url = "https://breakingbadapi.com/api/characters?limit=10&offset=0";
    var response = await http.get(url);
    var notes = List<Parameter>();
    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var notejson in notesJson) {
        notes.add(Parameter.fromJson(notejson));
      }
    }
    return notes;
  }

  final itemSize = 5.0;
  _moveUp() {
    _controller.animateTo(_controller.offset - itemSize,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }
  _moveDown() {
//    _controller.animateTo(itemSize,
//        curve: Curves.linear, duration: Duration (milliseconds: 500));
    _controller.animateTo(_controller.offset + itemSize,
        curve: Curves.linear, duration: Duration(milliseconds: 100));
  }

//  _scrollListener() {
//    if (_controller.offset >= _controller.position.maxScrollExtent &&
//        !_controller.position.outOfRange) {
//      setState(() {
////        message = "reach the bottom";
//      });
//    }
//    if (_controller.offset <= _controller.position.minScrollExtent &&
//        !_controller.position.outOfRange) {
//      setState(() {
////        message = "reach the top";
//      });
//    }
//  }
  @override
  void initState() {
    apiData().then((value) {
      setState(() {
        _list1.addAll(value);
        _list2.addAll(value);
      });
    });
    super.initState();
    _controller = ScrollController();
//    _controller.addListener(_scrollListener);

  }

  @override
  void dispose() {
//    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Text('list of Breaking Bad characters'.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 0.5,
//                  color: appBarIconsColor,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
      body:
      _list2.isNotEmpty?_list2.length==0?Container():
      Stack(
          children: <Widget>[
      ListView.builder(
          itemCount: _list2.length,
          controller: _controller,
//          itemExtent: itemSize,
          itemBuilder: (context, index) {

            String formatteddateofbirth;
            String given1=_list2[index].DateOfBirth;
            var newString = given1.substring(0,2);
            var newString1 = given1.substring(3,5);
            var newString2 = given1.substring(given1.length-4);
            if(_list2[index].DateOfBirth!="Unknown") {
              DateTime dateofbirth = DateTime.parse("$newString2-$newString-$newString1");
              formatteddateofbirth = (new DateFormat("d MMM, yyyy").format(dateofbirth));
            }
            else{
               formatteddateofbirth = _list2[index].DateOfBirth;
            };
            return new GestureDetector(
              onTap:(){ Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage(_list2[index])),
              );},
                child:
                Container(
                    child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
                            child: Row(children: <Widget>[
                              Container(
                                height: 60,width: 60,
                                child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                            NetworkImage(_list2[index].Image)
                                        )
                                    )
                                ),
                              ),
                              SizedBox(width: 20),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      _list2[index].Name,
                                      style: TextStyle(
                                        fontSize: 14.0,),
                                    ),
                                    Text(
                                      "$formatteddateofbirth",
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.grey.shade700),
                                    ),
                                  ])
                            ])
                        )))
            );}),
    Positioned.fill(
    child: Align(
    alignment: Alignment.bottomRight,
       child: new FloatingActionButton(
            tooltip: "Load Next",
            elevation: 0.0,
            child: new Icon(Icons.more_vert),

            onPressed: (){
              _moveDown();
            },
        )
    ))
      ])
          :Center(child: CircularProgressIndicator(),),
    );
  }
}

class SecondPage extends StatelessWidget{
  final Parameter note;
  SecondPage(this.note);
  @override
  Widget build(BuildContext context) {
    String formatteddateofbirth;
    String given1=note.DateOfBirth;
    var newString = given1.substring(0,2);
    var newString1 = given1.substring(3,5);
    var newString2 = given1.substring(given1.length-4);
    if(note.DateOfBirth!="Unknown") {
      DateTime dateofbirth = DateTime.parse("$newString2-$newString-$newString1");
      formatteddateofbirth = (new DateFormat("d MMM, yyyy").format(dateofbirth));
    }
    else{
      formatteddateofbirth = note.DateOfBirth;
    };
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text(note.Name,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
//            decoration: TextDecoration.underline,
          ),
        ),),
      body: Column(children: [
        Container(
            child: Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
                    child: Row(children: <Widget>[
                      Container(
                        height: 60,width: 60,
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                    NetworkImage(note.Image)
                                )
                            )
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              note.Name,
                              style: TextStyle(
                                fontSize: 14.0,),
                            ),
                            Text(
                              "$formatteddateofbirth",
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.grey.shade700),
                            ),
                          ])
                    ])
                )))

      ],),
    );
  }

}