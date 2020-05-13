import 'package:flutter/material.dart';
import 'package:morse/screens/chats/chats-conversations.dart';
import 'package:morse/screens/conversations-screen.dart';
import 'package:morse/screens/settings-screen.dart';
import 'package:morse/widgets/sidebar/sidebar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _selectedIndex;

  @override
  void initState() {
    setState(() {
      _selectedIndex = 1;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      ConversationsScreen(),
      SettingsScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        Future.value(false);
      },
      child: Scaffold(
          key: _scaffoldKey,
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            title: Text('Conversations'),
            centerTitle: true,
             backgroundColor: Colors.white,
              elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                Icons.sort,
                size: 30,
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
          ),
          drawer: Sidebar(),
          body: _widgetOptions.elementAt(_selectedIndex),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: new FloatingActionButton(
              elevation: 7.0,
              child: new Icon(Icons.add_comment),
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                print(prefs.getString('sessionid'));
                Navigator.push(context, MaterialPageRoute(builder: (context) => 
                ChatConversationsScreen(
                  title: 'Welcome dados',
                  channel: IOWebSocketChannel.connect('ws://186.207.238.21:8006/ws/mensagem/steeve', 
                    headers: {
                      'Cookie': 'sessionid=${prefs.getString('sessionid')}',
                    }
                  ),
                ),
                ));
              }),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
            ),
            child: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 11.0,
              elevation: 10.0,
              clipBehavior: Clip.antiAlias,
              child:  BottomNavigationBar(
                backgroundColor: Colors.white,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                unselectedItemColor: Colors.grey,
                currentIndex: _selectedIndex,
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        size: 30,
                      ),
                      title: Text('Home')),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.settings,
                        size: 30,
                      ),
                      title: Text('Settings')),
                ],
              ),
            ),
          )),
    );
  }
}