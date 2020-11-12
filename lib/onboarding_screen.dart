import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantStore/Providers/utilities.dart';
import 'package:plantStore/models/app.dart';

import 'models/size_config.dart';

class OnboardingScreen extends StatefulWidget {
  static String id = 'OnboardingScreen';
  var eml;
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: SizeConfig.blockSizeVertical * 1,
      width: isActive
          ? SizeConfig.blockSizeHorizontal * 5
          : SizeConfig.blockSizeHorizontal * 2,
      decoration: BoxDecoration(
        color: isActive ? Color(0xffE7F0C3) : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var eml;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.blockSizeVertical * 2.3,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppWelcome.routename),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeHorizontal * 5,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Hero(
                      tag: 'eml',
                      child: Image(
                        image: AssetImage(
                          'assets/images/EML.png',
                        ),
                        height: SizeConfig.blockSizeVertical * 7,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 67,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/c.png',
                                ),
                                height: SizeConfig.blockSizeVertical * 35,
                                width: SizeConfig.blockSizeVertical * 35,
                              ),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 5),
                            Text(
                              'Get connected!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 7.2,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 2),
                            Text(
                              'Connect with people and business around.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.blockSizeHorizontal * 5.2,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/n.png',
                                ),
                                height: SizeConfig.blockSizeVertical * 35,
                                width: SizeConfig.blockSizeVertical * 35,
                              ),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 5),
                            Text(
                              'Know it first!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 7.2,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 2),
                            Text(
                              'Get the latest local news and daily articles from trusted sources real fast.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.blockSizeHorizontal * 5.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/d.png',
                                ),
                                height: SizeConfig.blockSizeVertical * 35,
                                width: SizeConfig.blockSizeVertical * 35,
                              ),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 5),
                            Text(
                              'Grab it before its gone!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 7.2,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 2),
                            Text(
                              'Get the best offers and deals around the town.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.blockSizeHorizontal * 5.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 5.2,
                                  ),
                                ),
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 2),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: SizeConfig.blockSizeHorizontal * 5.2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: SizeConfig.blockSizeVertical * 11,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, AppWelcome.routename),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      'Get started',
                      style: TextStyle(
                        color: Color(0xFF5B16D0),
                        fontSize: SizeConfig.blockSizeHorizontal * 5.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
