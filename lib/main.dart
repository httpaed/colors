import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Colors',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        fontFamily: 'Arvo',
        scaffoldBackgroundColor: Colors.transparent,
        primarySwatch: Colors.blue,
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _i = 0;
  int _p = 0;


  List<String> number = [
    '[50]', '[100]', '[200]', '[300]', '[400]', '[600]', '[700]', '800', '900'
  ];

  List<String> colorTitleStr;
  List<Color> colorTitle;
  List<Color> myGradient = [];
  List<String> myGStr = [];
  List<List<Color>> colorClass;
  List<List<String>> colorString;
  var _myType;
  String title = 'Colors.pink';
  Color _color = Colors.pink;

  @override
  Widget build(BuildContext context) {
    setState(() {});
    _myType = [Alignment.centerLeft, Alignment.centerRight];
    colorString = MyColors().colorString;
    colorClass = MyColors().colorClass;
    List<String> colorTitleStr = MyColors().colorTitleStr;
    List<Color> colorTitle = MyColors().colorTitle;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.blur_on),
            onPressed: () {
              _changeGrd(context);
            } ,
          )
        ],
        centerTitle: true,
        title: Text(title,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
        ),
      ),
      drawer: Drawer(
        child: new Container(
          color: Colors.white,
          child: new ListView.builder(
              itemCount: (myGradient.length == 0) ? 1
                  : (myGradient.length == 1) ? 2
                  : myGradient.length + 3,
              itemBuilder: (context, i) {
                if (i == 0) {
                  return DrawerHeader(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new ListTile(
                          title: Text("Flutter Colors", style: TextStyle(
                              fontSize: 32.0, color: Colors.black54),),
                        ),
                      ],
                    ),
                  );
                } else {
                  if (i == myGradient.length + 1 && myGradient.length != null) {
                    return ListTile(
                        title: FlatButton(
                            shape: StadiumBorder(),
                            color: Colors.black12,
                            onPressed: () {
                              setState(() {
                                myGradient = [];
                                myGStr = [];
                              });
                            },
                            child: Text('clear my colors', style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),)
                        )
                    );
                  }
                  if (i == myGradient.length + 2 && myGradient.length != null) {
                    return Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: myGradient),
                      ),
                      child: FlatButton(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: StadiumBorder(),
                          color: Colors.transparent,
                          onPressed: () {
                            showGradient();
                          },
                          child: Text('show gradient', style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),)
                      ),
                    );
                  } else {
                    _i = i;
                    return new ListTile(
                      title: GestureDetector(
                        onTap: () {
                          showGradient();
                        },
                        child: Container(
                          height: 50,
                          child: Card(
                            shape: StadiumBorder(),
                            color: myGradient[i - 1],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(myGStr[i - 1], style: TextStyle(color: Colors.white),),
                                ),
                                IconButton(icon: Icon(Icons.delete, color: Colors.white,), onPressed: () {
                                  setState(() {
                                    myGradient.removeAt(i - 1);
                                    myGStr.removeAt(i - 1);
                                  });
                                  print(myGradient.length);
                                })
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                }
              }),
        ),
      ),
      body: PageView.builder(
        onPageChanged: (pages) {
          setState(() {
            title = colorTitleStr[pages];
            _color = colorTitle[pages];
          });
        },
        pageSnapping: false,
        itemCount: colorClass.length,
        itemBuilder: ((BuildContext context, p) {
          _p = p;
          return ListView.builder(
              itemCount: colorClass[p].length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () => showColor(colorClass[p][i]),
                  onLongPress: () {
                    setState(() {
                      myGradient.add(colorClass[p][i]);
                      myGStr.add(colorString[p][i]);
                    });
                    print(myGradient);
                    if(myGradient.length == 1)
                      _alert(context);
                    else
                      showGradient();
                  },
                  child: Hero(
                    tag: 'color',
                    child: Container(
                      height: 80,
                      color: colorClass[p][i],
                      child: Center(
                          child: Text(colorString[_p][i],
                            style: TextStyle(fontSize: 24, color: Colors.white),)
                      ),
                    ),
                  ),
                );
              });
        }),
      ),
    );
  }


  Future<void> showColor(Color color) async {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext builder) {
          return Container(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Hero(
                tag: 'color',
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  color: color,
                ),
              ),
            ),
          );
        }
    );
  }

  int _t = 0;

  Future<void> showGradient() async {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext builder) {
          print("$_myType in showG");
          return Container(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: myGradient,
                        begin: _myType[0],
                        end: _myType[1]
                    )
                ),
              ),
            ),
          );
        }
    );
  }

  bool secondTypes = false;

  var _boringTypes = [
    [Alignment.topLeft, Alignment.bottomLeft],
    [Alignment.topLeft, Alignment.topRight],
    [Alignment.bottomLeft, Alignment.topLeft],
    [Alignment.bottomLeft, Alignment.bottomRight],
    [Alignment.center, Alignment.bottomRight],
    [Alignment.topRight, Alignment.topLeft],
    [Alignment.topRight, Alignment.bottomRight],
    [Alignment.bottomRight, Alignment.topRight],
    [Alignment.bottomRight, Alignment.bottomLeft],
  ];

  var _types = [
    [Alignment.topLeft, Alignment.bottomRight],
    [Alignment.topCenter, Alignment.bottomCenter],
    [Alignment.topRight, Alignment.bottomLeft],
    [Alignment.centerLeft, Alignment.centerRight],
    [Alignment.center, Alignment.topRight],
    [Alignment.centerRight, Alignment.centerLeft],
    [Alignment.bottomLeft, Alignment.topRight],
    [Alignment.bottomCenter, Alignment.topCenter],
    [Alignment.bottomRight, Alignment.topLeft],


  ];

  Future<void> _changeGrd(BuildContext context) async {
    Text title = Text("Change the type of gradient");
    Widget subtitle = Container(
        height: 400,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Center(child: Text((secondTypes) ? "Circular" : "Linear")),
              onTap: () {
                setState(() {
                  secondTypes = !secondTypes;
                });
                Navigator.pop(context);
                _changeGrd(context);
              },
            ),
            Container(
              height: 300,
              child: (secondTypes)
                  ? ListView.builder(
                itemCount: 9,
                  itemBuilder: (context, t) {
                    return new ListTile(
                      onTap: () {
                        setState(() {
                          _myType = [_boringTypes[t][0], _boringTypes[t][1]];
                        });
                        showGradient();
                        print("$_myType in changeG");

                      },
                      title: Container(
                        child: (t == 0)
                            ? Text("from left top to left bottom")
                            : (t == 1) ? Text("from left top to right top")
                            : (t == 2) ? Text("from left bottom to left top")
                            : (t == 3) ? Text("from left bottom to right bottom")
                            : (t == 5) ? Text("from right top to left top")
                            : (t == 6) ? Text("from right top to right bottom")
                            : (t == 7) ? Text("from right bottom to right top")
                            : (t == 8) ? Text("from right bottom to left bottom")
                            : Divider()
                      ),
                    );
              })
                  : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: 9,
                  itemBuilder: (context, t) {
                    return new ListTile(
                        onTap: () {
                          setState(() {
                            _myType = [_types[t][0], _types[t][1]];
                          });
                          showGradient();
                          print("$_myType in changeG");
                        },
                        title: (t == 0)
                            ? Icon(Icons.call_received, textDirection: TextDirection.rtl,)
                            : (t == 1) ? Icon(Icons.arrow_downward)
                            : (t == 2) ? Icon(Icons.call_received)
                            : (t == 3) ? Icon(Icons.arrow_forward)
                            : (t == 5) ? Icon(Icons.arrow_back)
                            : (t == 6) ? Icon(Icons.call_made)
                            : (t == 7) ? Icon(Icons.arrow_upward)
                            : (t == 8) ? Icon(Icons.call_made, textDirection: TextDirection.rtl,)
                            : Container()
                    );
                  }),
            ),
          ],
        )
    );

    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext build) {
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(title: title, content: subtitle)
              : AlertDialog(title: title, content: subtitle, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
        }
    );
  }

  Future<void> _alert(BuildContext context) async {
    Text title = Text("You added a color for your gradient");
    Widget subtitle = Container(
        height: 200,
        child: Column(
          children: <Widget>[
            Container(child: Text('\npush to see a color')),
            Container(child: Text('\npush 2 seconds to add a color to your gradient')),
            Container(child: Text("\nif there are colors in the gradient, it will display it at the screen")),
          ],
        )
    );

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext build) {
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(title: title, content: subtitle, actions: _actions(build),)
              : AlertDialog(title: title, content: subtitle, actions: _actions(build), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
        }
    );
  }

  List<Widget> _actions(BuildContext build) {
    List<Widget> widgets = [];

    widgets.add(
        FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Color(0xff8E4B71),
          textColor: Colors.white,
          onPressed: () {
            Navigator.of(build).pop();
          },
          child: Text("yes".toUpperCase()),
        )
    );

    return widgets;
  }

}
