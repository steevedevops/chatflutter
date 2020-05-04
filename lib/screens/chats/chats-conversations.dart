import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:flutter/foundation.dart';
import 'package:morse/controllers/conversation.dart';
import 'package:morse/db/database-helper.dart';
import 'package:morse/models/mensagem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatConversationsScreen extends StatefulWidget {
  final String title;
  final WebSocketChannel channel;

  ChatConversationsScreen({Key key, @required this.title, @required this.channel})
      : super(key: key);

  @override
  _ChatConversationsScreenState createState() => _ChatConversationsScreenState(channel: channel);
}

class _ChatConversationsScreenState extends State<ChatConversationsScreen> {
  TextEditingController _controller = TextEditingController();
  final WebSocketChannel channel;
  final TextEditingController textEditingController = new TextEditingController();
  List<FieldsMensagem> mensagemList = new List();

  // Fica escutando o canal por aqui
  _ChatConversationsScreenState({this.channel}) {
    channel.stream.listen((data) {
      var responseSnap = json.decode(data);
      _insertMsg(responseSnap['payload']['fields']);
    });
  }
  
  ScrollController _sc = new ScrollController();
  int pageIndex = 1;
  bool isLoading = false;
  static int pageSize = 10;
  FieldsMensagem fieldsMensagem = FieldsMensagem();
  Mensagem mensagem = Mensagem();

  @override
  void initState() {
    this._getMoreData(pageIndex);
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        _getMoreData(pageIndex);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFf0f0f0),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:  new Container(
        decoration: BoxDecoration(
          color: Color(0xFFf0f0f0),
          image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.09), BlendMode.dstATop),
            image: AssetImage('lib/assets/images/bg-chat.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      child: Stack(children: <Widget>[
        Column(
          children: <Widget>[
            chatList(context),
            inputBar(context)
          ],
        ),
      ])
    ));
  }

  Widget chatListMsg(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: mensagemList.length,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == mensagemList.length) {
          return _buildProgressIndicator();
        } else {
          return Padding(
            padding: EdgeInsets.only(left:5, right: 5),
            child: _itemPublicadosBuilder(context, index),
          );
        }
      },
      controller: _sc,
    );
  }


  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget chatList(BuildContext context) {
    return Flexible(
      child:chatListMsg(context)
    );
  }

  Widget _itemPublicadosBuilder(context, index) {

    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

    BubbleStyle styleSomebody = BubbleStyle(
      // nip: BubbleNip.leftBottom,
      color: Colors.white,
      elevation: 1 * px,
      radius: Radius.circular(15.0),
      padding: BubbleEdges.all(14),
      margin: BubbleEdges.only(top: 8.0, right: 50.0, left: 0),
      alignment: Alignment.topLeft,
    );

    BubbleStyle styleMe = BubbleStyle(
      // nip: BubbleNip.rightBottom,
      radius: Radius.circular(15.0),
      color: Theme.of(context).primaryColor,
      elevation: 1 * px,
      padding: BubbleEdges.all(14),
      margin: BubbleEdges.only(top: 8.0, left: 50.0, right: 0),
      alignment: Alignment.topRight,
    );

    if(mensagemList[index].menDest == 3){
      return Container(
        padding: EdgeInsets.only(left: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(50.0)
                    ),
                    width: 30,
                    height: 30,
                    child: Text('')
                  ),
                  SizedBox(height: 5,),
                  Center(
                    child: Text('19:20',style: TextStyle(
                        fontSize: 10.0,
                        color: Theme.of(context).primaryColor,
                        fontStyle: FontStyle.normal))),
                    
                ],
              ) 
            ),
            GestureDetector(
              onTap: () async {
              },
              child: Bubble(
                style: styleSomebody,
                child: Text('${mensagemList[index].menMensagem} ',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).primaryColor,
                    fontStyle: FontStyle.normal)
                ),
              ),
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: 0.0),
      );
    }else{
      return Container(
        padding: EdgeInsets.only(right: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
              },
              child: Bubble(
                style: styleMe,
                child: Text('${mensagemList[index].menMensagem} ',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontStyle: FontStyle.normal)
                ),
              ),
            ),
            Container(
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text('19:20',style: TextStyle(
                        fontSize: 10.0,
                        color: Theme.of(context).primaryColor,
                        // color: Colors.black45,
                        fontStyle: FontStyle.normal))),
                  SizedBox(height: 2,),
                  Center(
                    child: Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 18,)
                    // child: Icon(Icons.check_circle_outline, color: Colors.black45, size: 18,)
                  ),
                  SizedBox(height: 5,),
                ],
              ) 
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: 0.0),
      );
    }
  }

  Widget inputBar(BuildContext context) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 5.0,
            ),
            // GestureDetector(
            //   onTap: () async {
            //     DatabaseHelper db = DatabaseHelper.instance;
            //     await db.deleteallMensagem();
            //     _getMoreData(1);
            //   },
            //   child: Container(child: Icon(Icons.delete, color: Theme.of(context).primaryColor,),),),
            //   SizedBox(
            //     width: 5.0,
            //   ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 8.0),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            hintText: 'Digite uma mensagem...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                    ],
                  ),
                ),
              )
            ),
            SizedBox(
              width: 10.0,
            ),
            InkWell(
              onTap: () async {
                _sendMessage();
              },
              child: Container(
                decoration: new BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: new BorderRadius.circular(50)),
                padding: EdgeInsets.only(left: 11, right: 8, top: 8, bottom: 11),
                child: Transform.rotate(
                  angle: 12.0,
                  child: Center(child:Icon(Icons.send, color: Colors.white,)),
                ),
              ),
              // child: CircleAvatar(
              //   child: Icon(Icons.send),
              // ),
            ),
            SizedBox(
              width: 4.0,
            ),
          ],
        ),
      );
  }

  void _sendMessage() async {
    DatabaseHelper db = DatabaseHelper.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (textEditingController.text.isNotEmpty) {
      var jsonMsgLocal = {
        "men_mensagem": textEditingController.text,
        "men_datacriacao" : '${DateTime.now()}',
        "men_datalido": null,
        "men_dataalterado": null,
        "men_from": 3,
        "men_dest": 2
      };

      var jsonMsgWeb = {
          "model": "mensagem.mensagem",
          "fields": {
              "men_mensagem": textEditingController.text,
              "men_dest": 2
          }
      };
      await Conversations().sendmessages(jsonMsgWeb);
      await _insertMsg(jsonMsgLocal);
      textEditingController.text = '';
    }
  }
  
  Future<void> _insertMsg(fieldsMensagem) async {
    DatabaseHelper db = DatabaseHelper.instance;
    var fieldMsg = FieldsMensagem.fromJson(fieldsMensagem);
    var result =  await db.insertMensagem(fieldMsg);
    if(result != 0){
      _getLastmessages();
    }
  }

  void _getMoreData(int index) async {
    DatabaseHelper db = DatabaseHelper.instance;
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      var mensagemPaginator = await db.getMensagemlist(10, 0);

      for (var i = 0; i < mensagemPaginator.length; i++) {
        mensagemList.add(mensagemPaginator[i]);
      }

      setState(() {
        isLoading = false;
        pageIndex++;
      });
    }
  }

  void _getLastmessages() async {
    DatabaseHelper db = DatabaseHelper.instance;
    var lastMensagem = await db.getLastmessages();
    setState(() {
      mensagemList.insert(0, lastMensagem);
    });
  }
}