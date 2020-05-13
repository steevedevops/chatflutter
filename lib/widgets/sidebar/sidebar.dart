import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:morse/widgets/sidebar/sidbar_items.dart';

class Sidebar extends StatefulWidget {
  Sidebar();

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: this._scaffoldKey,
      child: Drawer(
          child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          children: <Widget>[
            SafeArea(
                child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 175,
                    color: Colors.grey.withOpacity(0.1),
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(50)
                          ),
                          child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: SvgPicture.asset(
                                  'lib/assets/images/male_avatar.svg',
                                  width: 100,
                                ),
                              ),
                            ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                          child: Align(
                          alignment: Alignment.center,
                          child: new Text(
                            'Miguel hernandez',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                            ),
                          ))
                        ),
                      ]
                    )
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SidebarItem(Icons.featured_play_list, "Contactos", () {
                    Navigator.pop(context);
                  }),
                  SidebarItem(Icons.bookmark, "Mensagem salvas", () {
                    Navigator.pop(context);
                  }),
                  SidebarItem(Icons.settings, "Configurações", () {
                     Navigator.pop(context);
                  }),
                  SidebarItem(Icons.favorite, "Favoritos", () {
                    Navigator.pop(context);
                  }),
                  SizedBox(height: 15,),
                ],
              ),
            )),
          ],
        ),
      )),
    );
  }
}
