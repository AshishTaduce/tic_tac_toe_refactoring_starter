import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:tic_tac_toe_starter/single_player_file.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

void main() {
  runApp(
    MaterialApp(
      home: FrontPage(),
    ),
  );
}

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: Color(0xffD38312), end: Colors.red.shade900)),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin: Color(0xffA83279), end: Colors.blue.shade600))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [animation["color1"], animation["color2"]])),
        );
      },
    );
  }
}

class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;

  AnimatedWave({this.height, this.speed, this.offset = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: ControlledAnimation(
            playback: Playback.LOOP,
            duration: Duration(milliseconds: (5000 / speed).round()),
            tween: Tween(begin: 0.0, end: 2 * pi),
            builder: (context, value) {
              return CustomPaint(
                foregroundPainter: CurvePainter(value + offset),
              );
            }),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.white.withAlpha(60);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
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
      body: Stack(
        children: <Widget>[
          (AnimatedBackground()),
          Positioned.fill(
              bottom: 0,
              child:AnimatedWave(
            height: 180,
            speed: 1.0,
          )),
          Positioned.fill(
              bottom: 0,
              child:AnimatedWave(
            height: 120,
            speed: 0.9,
            offset: pi/2,
          )),
          Positioned.fill(
              bottom: 0,
              child:AnimatedWave(
            height: 180,
            speed: 0.5,
            offset: pi/4,
          )),
          Positioned(
              top: 0,
              child: SingleChildScrollView(
                child: Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
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
                                fontSize: 60,
                                color: Colors.white,
                                fontFamily: 'Quicksand'),
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
                                  side:
                                      BorderSide(color: Colors.white, width: 4),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                ),
                                color: Colors.transparent,
                                onPressed: () {
                                  hideNameInput
                                      ? hideNameInput = false
                                      : hideNameInput = true;
                                  setState(() {});
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
                                          side: BorderSide(
                                              color: Colors.white, width: 4),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 85,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                16, 0, 8, 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border(
                                                  bottom: BorderSide(
                                                      width: 4.0,
                                                      color: Colors.white),
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
                                                cursorRadius:
                                                    Radius.circular(8),
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
                                            icon: Icon(
                                              Icons.check_circle,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TicTacToePage(
                                                              _controller
                                                                  .text)));
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
                                    child: Image.asset(
                                        'assets/mclaren_logo_white.png')),
                              ),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Powered by",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                    Text(
                                      'Team Mclaren',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22.0),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
