import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peakhealth_call/call.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MaterialApp(
    home: Screen(),
  ));
}
class Screen extends StatefulWidget {
 final String token;
 final String email;
  const Screen( {Key key, this.token,  this.email}) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();

}

class _ScreenState extends State<Screen> {
  Future<Call> he([String token,String email]) async {
    var querydata = {'email': email, "Authorization": token};
    String querystring = Uri(queryParameters: querydata).query;
    var uri = "https://pc1f6cogce.execute-api.us-west-2.amazonaws.com/peakHealth/userphonenumbers?$querystring";

    final response = await http.get(
      uri, headers: {
      "Accept": "application/json","Content-Type": "application/json",
      "token": token,
      },

    );
    if (response.statusCode == 200) {
      String responseBody = response.body;
      log(responseBody);
      return callFromJson(responseBody);
      // return ;
    } else {
      // If the server did not return a 200 OK response,
      String responseBody = response.body;
      print(responseBody);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(

      leading: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ), onPressed: () {
          Navigator.pop(context, MaterialPageRoute(builder: (context) => Screen() ));
        },
        ),
      ),
      backgroundColor: Colors.white,
    ),
      body:FutureBuilder<Call>(
        future: he(widget.token,widget.email), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<Call> snapshot) {

        if (snapshot.hasData) { return ListView.builder(shrinkWrap: true, itemCount: snapshot.data.phoneNumbers.length, itemBuilder: (BuildContext context, int index) { return rowcontainer(snapshot.data.phoneNumbers [index]); },);

        }else{ return Center(child: CircularProgressIndicator()); }})
    );
  }
 Widget rowcontainer(String phonenumber){

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            Image.asset("asset/Person.jpeg",height: MediaQuery.of(context).size.height /8.5,width: MediaQuery.of(context).size.width /6.7,),
            Row(
             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text( phonenumber,style: TextStyle(fontSize: 20),),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(border:Border.all(color: Colors.white,width: 1),color:Color(0xff64DBFF),borderRadius: BorderRadius.all(Radius.circular(15),),boxShadow: [BoxShadow(color: Colors.grey.shade400,blurRadius: 10,offset:Offset(1, 5),)]),
                    height: MediaQuery.of(context).size.height/26,
                    width: MediaQuery.of(context).size.width/6.1,
                    child: Align(alignment: Alignment.center,child: Text("Reset",style: TextStyle(fontSize: 18,color: Colors.white),)),
                  ),
                ],
              ),

            ),
          ],

        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 100,right: 0,top: 0),
              child: Container(
                height: MediaQuery.of(context).size.height/300,
                width: MediaQuery.of(context).size.width/1.43,
                color: Colors.grey.shade300,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
