import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morse/controllers/conversation.dart';
import 'package:morse/models/usersconversations.dart';
import 'package:morse/screens/chats/chats-conversations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';

class ConversationsScreen extends StatefulWidget {
  @override
  _ConversationsScreenState createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static int PAGE_SIZE = 10;
  String url_api = "";
  final _pageLoadController = PagewiseLoadController(pageSize: 10, pageFuture: (pageIndex) => Conversations().listConversations(PAGE_SIZE, pageIndex));

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
               Expanded(
                child: SizedBox(
                  height: 100.0,
                  child: PagewiseListView(
                      noItemsFoundBuilder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height/1.5,
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: SvgPicture.asset(
                                'lib/assets/images/no_data.svg',
                                width: 150,
                              ),
                            ),
                          ),
                        );
                      },
                      itemBuilder: this._itemPublicadosBuilder,
                      pageLoadController: this._pageLoadController)
                ),
              ),
            ],
          ),
      ),
    );
  }

  Widget _itemPublicadosBuilder(context, ConversationsList entry, _) {
    return InkWell(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
          print(prefs.getString('sessionid'));
          Navigator.push(context, MaterialPageRoute(builder: (context) => 
          ChatConversationsScreen(
            title: 'Fábio Dornel',
            channel: IOWebSocketChannel.connect('ws://186.207.238.21:8006/ws/mensagem/steeve', 
              headers: {
                'Cookie': 'sessionid=${prefs.getString('sessionid')}',
              }
            ),
          ),
        ));
      },
      child: Container(
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.3, color: Colors.black26),
            ),
          ),
          child: Row(
            children: <Widget>[
              SizedBox(width: 15,),
              Container(
                decoration: BoxDecoration(
                  // color: Colors.red,
                  borderRadius: new BorderRadius.circular(50)
                ),
                height: 55,
                width: 55,
                child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: SvgPicture.asset(
                        'lib/assets/images/male_avatar.svg',
                        width: 150,
                      ),
                    ),
                  ),
              ),
              SizedBox(width: 15,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Container(
                        child: Text('${entry.fields.firstName} ${entry.fields.lastName}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      child: Container(
                        child: Text('que pasa'),
                      ),
                    )
                  ],
                )
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(50)
                ),
                height: 55,
                // width: 55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text('10:30 pm'),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: new BorderRadius.circular(50)
                      ),
                      child: Text('1',
                      textAlign: TextAlign.center,
                        style: TextStyle(
                          // fontSize: 16,
                          color: Theme.of(context).backgroundColor,
                          fontWeight: FontWeight.bold
                        ),),
                    ),
                  ],
                )
              ),
              SizedBox(width: 15,),
            ],
          )
        ),
      )
    );

  }
}