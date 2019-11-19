
import 'package:crypto_app_ui/util/data.dart';
import 'package:crypto_app_ui/widgets/wallet.dart';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'home.dart';



class Wallets extends StatefulWidget {
  @override
  _WalletsState createState() => _WalletsState();
}

class _WalletsState extends State<Wallets> {

@override
  void initState() {
  
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:sensores==null? ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        primary: false,
        itemCount: coins.length,
        itemBuilder: (BuildContext context, int index) {
          Map coin = coins[index];

          return Wallet(
            name: coin['name'],
            icon: coin['icon'],
            rate: coin['rate'],
            color: coin['color'],
          );
        },
      ):ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        primary: false,
        itemCount: sensores.length,
        itemBuilder: (BuildContext context, int index) {
          

          return Wallet(
            name: sensores[index]['nombre'],
            icon: "assets/eth.png",
            rate: sensores[index]['valor'],
            color:charts.MaterialPalette.blue.shadeDefault,
          );
        },
      ),
    );
  }























}

