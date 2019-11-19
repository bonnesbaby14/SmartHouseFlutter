import 'dart:convert';

import 'package:crypto_app_ui/screens/wallets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../multi_form.dart';

var sensores;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await getInfo();
        await Future.delayed(Duration(milliseconds: 500));
        setState(() {});
      },
      child: Scaffold(
        appBar: AppBar(
            leading: InkWell(
          onTap: () {
            Navigator.push(
                context, CupertinoPageRoute(builder: (context) => MultiForm()));
          },
          child: Icon(
            Icons.settings,
          ),
        )),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: <Widget>[
            SizedBox(height: 20),
            Container(
                margin: EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height * 2,
                child: Wallets()),
          ],
        ),
      ),
    );
  }

  Future getInfo() async {
    var cliente1 = new http.Client();
    try {
      final response = await cliente1.post(
          "http://empresaslaraza.com/smartHouse/getSensors.php",
          body: {}).timeout(Duration(seconds: 7));

      var datauser = json.decode(response.body);
      print(datauser);
      sensores = datauser;

      print(sensores);
    } catch (d) {
      print("hubo un error obteniendo los sensores");
      print(d.toString());
    } finally {
      cliente1.close();
      setState(() {});
    }
  }
}
