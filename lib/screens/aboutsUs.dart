import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plantStore/Providers/call_provider.dart';
import 'package:plantStore/screens/cart-screen.dart';
import 'package:plantStore/widgets/myOrders.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ente Manjeri',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: 'Lato',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.routename);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Center(
                  child: Text(
                    'About Us',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 2,
                indent: 90,
                endIndent: 90,
                color: Color(0xff32AFA9),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 15),
                child: Container(
                  child: Text(
                    "This is a joint venture of TMC Company Limited and Endezine Technologies.",
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 60),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Image.asset(
                          'assets/images/20200614_165332_0000.png',
                          height: 120,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Image.asset(
                          'assets/images/OGLogo.png',
                          height: 100,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Divider(
                color: Colors.cyan,
                indent: 30,
                endIndent: 30,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Contact Us.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        RaisedButton.icon(
                            elevation: .5,
                            color: Colors.white,
                            onPressed: () async {
                              launchCaller('+917907623337');
                            },
                            icon: Icon(
                              Icons.call,
                              color: Colors.green,
                            ),
                            label: Text(
                              'Call',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Or connect to us through:',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, bottom: 10),
                              child: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.facebookSquare,
                                  size: 40,
                                  color: Colors.blue,
                                ),
                                onPressed: () => launch(
                                    "https://www.facebook.com/ente.manjeri.562"),
                                tooltip: "facebook",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, bottom: 10),
                              child: IconButton(
                                icon: Icon(
                                  Icons.email_sharp,
                                  size: 45,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () =>
                                    launch("mailto:anjoomshareef@gmail.com"),
                                tooltip: "eMail",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, bottom: 10),
                              child: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.instagram,
                                  size: 40,
                                  color: Colors.amber,
                                ),
                                onPressed: () => launch(
                                    "https://instagram.com/ente.manjeri?igshid=vba0dmlcs4y1"),
                                tooltip: "Instagram",
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
