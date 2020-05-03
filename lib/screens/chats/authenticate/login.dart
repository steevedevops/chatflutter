import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morse/animations/FadeAnimation.dart';
import 'package:morse/controllers/authenticate.dart';
import 'package:morse/screens/home-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _loadState = false;
  bool _obscure = true;
  String tokenNotification;

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    _getLasteruserlogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushNamed(context, '/homeauth');
        },
        child: Scaffold(
            key: _scaffoldKey,
            body: SingleChildScrollView(
              child: new Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.05), BlendMode.dstATop),
                    image: AssetImage('lib/assets/images/bg-building.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Form(
                    key: _formKey,
                    child: FadeAnimation(
                        1.3,
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(30.0),
                              child: new SvgPicture.asset(
                                'lib/assets/images/login.svg',
                                width: 150,
                              ),
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Campo não pode estar vazio!';
                                  }
                                  return null;
                                },
                                controller: usernameController,
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    contentPadding: EdgeInsets.fromLTRB(
                                        10.0, 9.0, 10.0, 9.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              ),
                            ),
                            SizedBox(
                              height: 24.0,
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Campo não pode estar vazio!';
                                  }
                                  return null;
                                },
                                controller: passwordController,
                                obscureText: _obscure,
                                decoration: InputDecoration(
                                    labelText: 'Senha',
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscure = !_obscure;
                                        });
                                      },
                                      child: Icon(
                                        _obscure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        size: 20.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        10.0, 9.0, 10.0, 9.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            new Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(
                                  left: 30.0, right: 30.0, top: 5.0),
                              alignment: Alignment.center,
                              child: new Row(
                                      children: <Widget>[
                                        new Expanded(
                                          child: new FlatButton(
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      6.0),
                                            ),
                                            color:
                                                Theme.of(context).primaryColor,
                                            onPressed: () {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _dologin();
                                              }
                                            },
                                            child: new Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 17.0,
                                                horizontal: 17.0,
                                              ),
                                              child: new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  new Expanded(
                                                    child: Text(
                                                      "LOGIN",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                            // Aqui va el codigo de hacer login con la cuenta de google
                          ],
                        ))),
              ),
            )));
  }

  Future<void> _getLasteruserlogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('email'));
    usernameController.text = prefs.getString('email');
  }

  _dologin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map params = {
      "username": usernameController.text.trim(),
      "password": passwordController.text.trim(),
    };

    var userlogin = await Authenticate().dologin(params);
    
    if (userlogin != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      print(prefs.getString('msg_api'));
      // _scaffoldKey.currentState.showSnackBar(snackBar(prefs.getString('msg_api')));
    }
    setState(() {
      _loadState = false;
    });
  }
}
