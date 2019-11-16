import 'package:flutter/cupertino.dart';
import 'package:tic_tac_toe_starter/single_player_file.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: FrontPage(),
  ));
}

class FrontPage extends StatefulWidget {
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  bool hideNameInput = true;
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0.0, 0.5, 0.9],
              colors: [
                Color.fromARGB(255, 0, 0, 55),
                Colors.blue,
                Colors.blueGrey,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Text(
                    "Tic-Tac-Toe",
                    style: TextStyle(
                        fontSize: 60, color: Colors.white, fontFamily: 'Quicksand'),
                  ),
                  SizedBox(
                    height: size.height * 0.2,
                  ),
                  Center(
                    child: ButtonTheme(
                      minWidth: 240,
                      height: 80,
                      child: RaisedButton(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white, width: 4),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        color: Colors.transparent,
                        onPressed: () {
                          hideNameInput ? hideNameInput = false : hideNameInput = true;
                          setState(() {

                          });
                        },
                        child: Text(
                                "Player VS Computer",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'Quicksand',
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Center(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 100),
                      child: hideNameInput
                        ? ButtonTheme(
                      minWidth: 240,
                      height: 80,
                      child: RaisedButton(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white, width: 4),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        color: Colors.transparent,
                        onPressed: () {},
                        child: Text(
                          "Player VS Player",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                      ),
                    )
                        : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 85,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                bottom: BorderSide(width: 4.0, color: Colors.white),
                              ),
                            ),
                            child: TextFormField(
                              style: new TextStyle(
                                fontSize: 34,
                                color: Colors.white,
                                fontFamily: 'Quicksand',
                              ),
                              //decoration: new InputDecoration(fillColor: Colors.orange, filled: true),
                              cursorColor: Colors.white,
                              cursorRadius: Radius.circular(8),
                              cursorWidth: 32,
                              autofocus: true,
                              controller: _controller,
                              // ...
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 15,
                        child: IconButton(
                          iconSize: 48,
                          icon: Icon(Icons.check_circle, color: Colors.white,),
                          onPressed:() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TicTacToePage(_controller.text)));
                          },
                        ),
                      )
                    ],
                  ),
                    ),
                  ),
                  
                  
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 50,
                            height: 50,
                            child: Image.asset('assets/mclaren_logo_white.png')),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Powered by",
                              style: TextStyle(color: Colors.white, fontSize: 16.0),
                            ),
                            Text(
                              'Team Mclaren',
                              style: TextStyle(color: Colors.white, fontSize: 22.0),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
