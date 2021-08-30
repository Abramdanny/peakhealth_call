import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:peakhealth_call/call_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'login_api.dart';

void main(){
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}
class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  Future<Login> hee(data) async {
    var uri = "https://pc1f6cogce.execute-api.us-west-2.amazonaws.com/peakHealth/userlogin";
    var body = json.encode(data);
    final response = await http.post(
        uri,body: body, headers: {
      "Accept": "application/json","Content-Type": "application/json"}

    );
    if (response.statusCode == 200) {
      String responseBody = response.body;
      print(responseBody);
      return loginFromJson(responseBody);
    } else {
      // If the server did not return a 200 OK response,
      String responseBody = response.body;
      print(responseBody);
      return loginFromJson(responseBody);
    }
  }
  @override
  void initState() {
    //hee().then((user) => print(user.token));
    print("hee");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Align(alignment: Alignment.center,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    child: Image.asset(
                      "asset/Ccslogos.jpeg", height: 200, width: 300,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 100),
                  child: TextFormField(
                    controller: _emailcontroller,

                    keyboardType: TextInputType.emailAddress,

                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.email_outlined, color: Color(0xff64DBFF),
                        ),
                        hintText: "Enter Email"
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 30),
                  child: TextFormField(
                      controller: _passwordcontroller,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key, color: Color(0xff64DBFF),
                          ),
                          hintText: "Enter your password")
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100, left: 132),
                      child: InkWell(splashColor: Color(0xff64DBFF),
                        onTap: () {
                          var data = {
                            "email":_emailcontroller.text,
                            "password":_passwordcontroller.text,
                          };
                          hee(data).then((value)  {
                            if (value.success){
                              var token = value.token;
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Screen(token:token,email:_emailcontroller.text ))
                              );

                            }
                            else {
                              Fluttertoast.showToast(
                                  msg: value.message,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );

                            }
                          });
                          print(_emailcontroller.text);
                          print(_passwordcontroller.text);

                        },
                        child: Container(
                          decoration: BoxDecoration(color: Color(0xff64DBFF),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(9))),
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 14,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 2.9,
                          child: Align(alignment: Alignment.center,
                              child: Text("Enter",
                                style:
                                TextStyle(
                                    color: Colors.white, fontSize: 20),)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),

          ),

        ),
      ),

    );
  }
}