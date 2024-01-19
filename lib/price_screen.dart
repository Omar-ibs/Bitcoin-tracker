// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'coindata.dart';
import 'behindthesene.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

Behindthesene frombehindthesene = Behindthesene();
var coin, realcoin, price, result, data;
var selectedcurrency = 'USD';
const apikey = '306A2E1D-683D-4903-83CA-B694019DCC8C';
const urL = 'https://rest.coinapi.io/v1/exchangerate/BTC';

class _PriceScreenState extends State<PriceScreen> {
  void setchanges(var change) {
    setState(() {
      coin = change['asset_id_base'];
      realcoin = change['asset_id_quote'];
      double pri = change['rate'];
      price = pri.toInt();
    });
  }

  CupertinoPicker iospickes() {
    List<Widget> pickes = [];
    for (int i = 0; i < currenciesList.length; i++) {
      var newvalue = Text(currenciesList[i]);
      pickes.add(newvalue);
    }

    return CupertinoPicker(
      itemExtent: 34.0,
      onSelectedItemChanged: (selectedindex) async {
        var data = await frombehindthesene
            .extramethod('$urL/$selectedcurrency?apikey=$apikey');
        setchanges(data);
      },
      children: pickes,
    );
  }

  DropdownButton<String> androiddropdown() {
    List<DropdownMenuItem<String>> dropdownitems = [];
    for (String currency in currenciesList) {
      var newitems = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownitems.add(newitems);
    }
    return DropdownButton(
      value: selectedcurrency,
      items: dropdownitems,
      onChanged: (value) async {
        setState(() {
          selectedcurrency = value!;
          realcoin = selectedcurrency;
        });

        data = await frombehindthesene
            .extramethod('$urL/$selectedcurrency?apikey=$apikey');
        setchanges(data);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Center(
            child: Text(
          '🤑 Coin Ticker',
        )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Column(
                children: [
                  Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 BTC = $price $selectedcurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ETH = $price $selectedcurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 LTC = $price $selectedcurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iospickes() : androiddropdown(),
          ),
        ],
      ),
    );
  }
}
