import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './models/product.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Color(0xfffafafa), // Color for Android
      statusBarBrightness:
          Brightness.dark // Dark == white status bar -- for IOS.
      ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  //animation variable that change
  double _rowHeigt = 100;
  double _priceFontSize = 25;
  double _productImageHeight = 350;
  double _productImageWidth = 300;
  bool isOpen = false;
  double viewportFraction = 0.8;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1200),
    vsync: this,
  )..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
          begin: Offset(-1, 0), end: const Offset(0, 0))
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInExpo));
  late final Animation<double> _doubleAnimation =
      CurvedAnimation(parent: _controller, curve: Curves.easeInBack);

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  String _sizeValue = "SELECT A SIZE";
  String _colorValue = "SELECT A COLOR";
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<Product> products = [
    Product(
        id: "1",
        title: "Stylish Sweetpants",
        color: "Beige",
        price: "99.00",
        totalPrice: "349.00",
        imageUrl: "assets/images/pant.jpg"),
    Product(
        id: "2",
        title: "AKAI Cotton Printed T-Shirt",
        color: "Black",
        price: "20.00",
        totalPrice: "45.50",
        imageUrl: "assets/images/tshirt1.jpg")
  ];

  RadioListTile buildRadioListTile(txt) {
    return RadioListTile(
      activeColor: Colors.white,
      controlAffinity: ListTileControlAffinity.trailing,
      value: txt,
      groupValue: _sizeValue,
      onChanged: (value) {
        setState(() {
          if (scaffoldKey.currentState!.isDrawerOpen) _sizeValue = value;
          if (scaffoldKey.currentState!.isEndDrawerOpen) _colorValue = value;
          Navigator.of(context).pop();
        });
      },
      title: Text(txt, style: TextStyle(color: Colors.white60, fontSize: 17)),
    );
  }

  Widget _secondWidget() {
    return Container(
      height: 300,
      child: Column(key: ValueKey("2"), children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 18),
          child: SlideTransition(
            position: _offsetAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "- Made of pure cotton and non-blended with transfer printing to withstand the harshest conditions of consumption and washing.Fashionable, get attractive looks and comfortable clothes."),
                Text("- Cotton material", textAlign: TextAlign.end),
                Text("- with transfer printing"),
                SizedBox(height: 20),
                Text("- Heel height: 0.5"),
                Text("- Height: 5"),
                Text("- Style: B324 imported."),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ScaleTransition(
            scale: _doubleAnimation,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Container(
                          height: 60,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(width: 1.5)),
                              onPressed: () {
                                if (scaffoldKey.currentState!.isDrawerOpen)
                                  scaffoldKey.currentState!.openEndDrawer();
                                else
                                  scaffoldKey.currentState!.openDrawer();
                              },
                              child: Row(children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      _sizeValue,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                Icon(
                                    _sizeValue == "SELECT A SIZE"
                                        ? Icons.keyboard_arrow_down_sharp
                                        : Icons.keyboard_arrow_right_sharp,
                                    color: Colors.black,
                                    size: 25)
                              ])))),
                  SizedBox(width: 10),
                  Expanded(
                      child: Container(
                    height: 60,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 1.5)),
                        onPressed: () {
                          _openEndDrawer();
                        },
                        child: Row(children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                _colorValue,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          Icon(
                              _colorValue == "SELECT A COLOR"
                                  ? Icons.keyboard_arrow_down_sharp
                                  : Icons.keyboard_arrow_right_sharp,
                              color: Colors.black,
                              size: 25)
                        ])),
                  ))
                ]),
          ),
        )
      ]),
    );
  }

  Widget button(IconData icon) {
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(side: BorderSide(width: 1.5)),
          onPressed: () {},
          child: FaIcon(
            icon,
            color: Colors.black,
            size: 18,
          )),
    );
  }

  void _openEndDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        width: 350,
        color: Colors.black.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(Icons.close, size: 35, color: Colors.white),
                    Expanded(
                        child: Center(
                      child: Text(
                        "SELECT A SIZE",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )),
                  ],
                ),
              ),
              Divider(height: 3, color: Colors.white10),
              buildRadioListTile("XSMALL"),
              Divider(height: 3, color: Colors.white10),
              buildRadioListTile("SMALL"),
              Divider(height: 3, color: Colors.white10),
              buildRadioListTile("MEDIUM"),
              Divider(height: 3, color: Colors.white10),
              buildRadioListTile("LARGE"),
              Divider(height: 3, color: Colors.white10),
              buildRadioListTile("XLARGE"),
              Divider(height: 3, color: Colors.white10),
              buildRadioListTile("XXLARGE"),
              Divider(height: 3, color: Colors.white10),
            ],
          ),
        ),
      ),
      endDrawer: Container(
        alignment: Alignment.topRight,
        width: 350,
        color: Colors.black.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(Icons.close, size: 35, color: Colors.white),
                    Expanded(
                        child: Center(
                      child: Text(
                        "SELECT A COLOR",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )),
                  ],
                ),
              ),
              Divider(height: 3, color: Colors.white10),
              buildRadioListTile("SWEET CAROL"),
              Divider(height: 3, color: Colors.white10),
              buildRadioListTile("LIGHT HEATHER GREY"),
              Divider(height: 3, color: Colors.white10),
              buildRadioListTile("BLEACHER"),
              Divider(height: 3, color: Colors.white10),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            AnimatedContainer(
                curve: Curves.easeInExpo,
                duration: Duration(milliseconds: 1000),
                height: _rowHeigt,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isOpen = false;
                              _rowHeigt = 100;
                              _priceFontSize = 25;
                              _productImageHeight = 350;
                              _productImageWidth = 300;
                              _controller.reverse();
                              viewportFraction = 0.8;
                            });
                          },
                          icon: Icon(isOpen ? Icons.arrow_back : Icons.close,
                              size: 25, color: Colors.black)),
                      Spacer(),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset("assets/images/clothes-hanger.png",
                                width: 45, height: 45),
                            Text("MY CLOSET",
                                style: TextStyle(color: Colors.blue))
                          ]),
                      Spacer(),
                      Stack(children: [
                        Image.asset("assets/images/bag.png",
                            width: 30, height: 30),
                        Positioned(
                            right: 11,
                            top: 10,
                            child: Text("2",
                                style: TextStyle(color: Colors.white)))
                      ])
                    ])),
            SizedBox(height: 20),
            Expanded(
              child: CarouselSlider(
                  items: products
                      .map((e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${e.title}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text("${e.color}"),
                              AnimatedDefaultTextStyle(
                                curve: Curves.easeInExpo,
                                duration: Duration(milliseconds: 1000),
                                style: TextStyle(
                                    fontSize: _priceFontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                child: Text(
                                  "\$${e.price}",
                                ),
                              ),
                              Text("\$${e.totalPrice}"),
                              SizedBox(height: 15),
                              Expanded(
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 100),
                                        width: _productImageWidth,
                                        height: _productImageHeight,
                                        child: Image.asset(
                                          "${e.imageUrl}",
                                        ),
                                      ),
                                    ),
                                    !isOpen
                                        ? Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Text(
                                                  " ${e.id} of ${products.length}"),
                                            ))
                                        : Align(
                                            alignment: Alignment.bottomCenter,
                                            child: _secondWidget()),
                                  ],
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                  options: CarouselOptions(
                      scrollPhysics:
                          isOpen ? NeverScrollableScrollPhysics() : null,
                      aspectRatio: 0.7,
                      viewportFraction: viewportFraction,
                      initialPage: 2,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      enableInfiniteScroll: false)),
            ),
            Container(
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                height: 60,
                child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        isOpen = true;
                        _controller.forward();
                        _rowHeigt = 63;
                        _priceFontSize = 30;
                        _productImageHeight = 180;
                        _productImageWidth = 150;
                        viewportFraction = 1;
                      });
                    },
                    child: Text("ADD TO CART",
                        style: TextStyle(color: Colors.white)))),
            SizedBox(height: 25),
            !isOpen
                ? Container(
                    width: double.infinity,
                    height: 60,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1.5)),
                      onPressed: () {},
                      child: Text("REMOVE FROM CLOSET",
                          style: TextStyle(color: Colors.black)),
                    ),
                  )
                : SlideTransition(
                    position: _offsetAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        button(FontAwesomeIcons.facebookF),
                        button(FontAwesomeIcons.instagram),
                        button(FontAwesomeIcons.twitter),
                        button(mail),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

const IconData mail = IconData(0xe3c3, fontFamily: 'MaterialIcons');
