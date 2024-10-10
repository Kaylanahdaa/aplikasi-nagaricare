import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Iphone11proxWidget - FRAME

    return Container(
        width: 375,
        height: 812,
        decoration: BoxDecoration(
          color: Color.fromRGBO(253, 253, 253, 1),
        ),
        child: Stack(children: <Widget>[
          Positioned(
              top: 32.00006103515625,
              left: 35,
              child: Container(
                  width: 305.4840087890625,
                  height: 37,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: -0.00006103515625,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                              bottomLeft: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                            ),
                            color: Color.fromRGBO(18, 18, 33, 1),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'News     Portal',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Playfair Display',
                                    fontSize: 16,
                                    letterSpacing:
                                        0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                        top: 15.99993896484375,
                        left: 219,
                        child: SizedBox(
                          height: 1,
                        )),
                    Positioned(
                        top: 7.99993896484375,
                        left: 281.879150390625,
                        child: SizedBox(
                          height: 1,
                        )),
                  ]))),
          Positioned(
              top: 109,
              left: 35,
              child: Container(
                  width: 305,
                  height: 258,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Text(
                          'Hot Topics',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Roboto',
                              fontSize: 36,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                    Positioned(
                        top: 58,
                        left: 0,
                        child: Container(
                            width: 305,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                              color: Color.fromRGBO(196, 196, 196, 1),
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/rectangle1.png'),
                                  fit: BoxFit.fitWidth),
                            ))),
                    Positioned(
                        top: 58,
                        left: 0,
                        child: Container(
                            width: 305,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                              gradient: LinearGradient(
                                  begin: Alignment(-5.281334600029696e-16,
                                      1.7316017150878906),
                                  end: Alignment(-1.7316017150878906,
                                      6.569699241374273e-16),
                                  colors: [
                                    Color.fromRGBO(0, 0, 0, 0),
                                    Color.fromRGBO(0, 0, 0, 0.6499999761581421)
                                  ]),
                            ))),
                    Positioned(
                        top: 234,
                        left: 12,
                        child: Text(
                          '2 Hours Agoi',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(248, 248, 248, 1),
                              fontFamily: 'Roboto',
                              fontSize: 8,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1.5 /*PERCENT not supported*/
                              ),
                        )),
                    Positioned(
                        top: 234,
                        left: 75,
                        child: Text(
                          'CNN Indonesia',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(248, 248, 248, 1),
                              fontFamily: 'Roboto',
                              fontSize: 8,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1.5 /*PERCENT not supported*/
                              ),
                        )),
                    Positioned(
                        top: 184,
                        left: 12,
                        child: Text(
                          'Massa tortor nibh nulla condimentum imperdiet scelerisque...',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(248, 248, 248, 1),
                              fontFamily: 'Playfair Display',
                              fontSize: 16,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                  ]))),
          Positioned(
              top: 407,
              left: 35,
              child: Container(
                  width: 305,
                  height: 460,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Text(
                          'Latest News',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(18, 18, 33, 1),
                              fontFamily: 'Roboto',
                              fontSize: 24,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                    Positioned(
                        top: 44,
                        left: 0,
                        child: Container(
                            width: 143,
                            height: 192,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 183,
                                  left: 0,
                                  child: Text(
                                    '1 Hour Ago',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(148, 148, 148, 1),
                                        fontFamily: 'Roboto',
                                        fontSize: 8,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  )),
                              Positioned(
                                  top: 183,
                                  left: 57,
                                  child: Text(
                                    'CNN Indonesia',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(148, 148, 148, 1),
                                        fontFamily: 'Roboto',
                                        fontSize: 8,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  )),
                              Positioned(
                                  top: 104,
                                  left: 0,
                                  child: Text(
                                    'News Title Lorem Ipsum Dolor Sit Amet',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 18, 33, 1),
                                        fontFamily: 'Playfair Display',
                                        fontSize: 16,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  )),
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 143,
                                      height: 96,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                        color: Color.fromRGBO(196, 196, 196, 1),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/rectangle3.png'),
                                            fit: BoxFit.fitWidth),
                                      ))),
                            ]))),
                    Positioned(
                        top: 268,
                        left: 0,
                        child: Container(
                            width: 143,
                            height: 192,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 183,
                                  left: 0,
                                  child: Text(
                                    '1 Hour Ago',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(148, 148, 148, 1),
                                        fontFamily: 'Roboto',
                                        fontSize: 8,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  )),
                              Positioned(
                                  top: 183,
                                  left: 57,
                                  child: Text(
                                    'CNN Indonesia',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(148, 148, 148, 1),
                                        fontFamily: 'Roboto',
                                        fontSize: 8,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  )),
                              Positioned(
                                  top: 104,
                                  left: 0,
                                  child: Text(
                                    'News Title Lorem Ipsum Dolor Sit Amet',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 18, 33, 1),
                                        fontFamily: 'Playfair Display',
                                        fontSize: 16,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  )),
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 143,
                                      height: 96,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                        color: Color.fromRGBO(196, 196, 196, 1),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/rectangle2.png'),
                                            fit: BoxFit.fitWidth),
                                      ))),
                            ]))),
                    Positioned(
                        top: 44,
                        left: 163,
                        child: Container(
                            width: 142,
                            height: 192,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 183,
                                  left: 0,
                                  child: Text(
                                    '1 Hour Ago',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(148, 148, 148, 1),
                                        fontFamily: 'Roboto',
                                        fontSize: 8,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  )),
                              Positioned(
                                  top: 183,
                                  left: 56.60139846801758,
                                  child: Text(
                                    'CNN Indonesia',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(148, 148, 148, 1),
                                        fontFamily: 'Roboto',
                                        fontSize: 8,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  )),
                              Positioned(
                                  top: 104,
                                  left: 0,
                                  child: Text(
                                    'News Title Lorem Ipsum Dolor Sit Amet',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 18, 33, 1),
                                        fontFamily: 'Playfair Display',
                                        fontSize: 16,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  )),
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 142,
                                      height: 96,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                        color: Color.fromRGBO(196, 196, 196, 1),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/rectangle0.png'),
                                            fit: BoxFit.fitWidth),
                                      ))),
                            ]))),
                    Positioned(
                        top: 268,
                        left: 163,
                        child: Container(
                            width: 142,
                            height: 192,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 183,
                                  left: 0,
                                  child: Text(
                                    '1 Hour Ago',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(148, 148, 148, 1),
                                        fontFamily: 'Roboto',
                                        fontSize: 8,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  )),
                              Positioned(
                                  top: 183,
                                  left: 56.60139846801758,
                                  child: Text(
                                    'CNN Indonesia',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(148, 148, 148, 1),
                                        fontFamily: 'Roboto',
                                        fontSize: 8,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  )),
                              Positioned(
                                  top: 104,
                                  left: 0,
                                  child: Text(
                                    'News Title Lorem Ipsum Dolor Sit Amet',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(18, 18, 33, 1),
                                        fontFamily: 'Playfair Display',
                                        fontSize: 16,
                                        letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  )),
                              Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                      width: 142,
                                      height: 96,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                        color: Color.fromRGBO(196, 196, 196, 1),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/rectangle.png'),
                                            fit: BoxFit.fitWidth),
                                      ))),
                            ]))),
                  ]))),
        ]));
  }
}
