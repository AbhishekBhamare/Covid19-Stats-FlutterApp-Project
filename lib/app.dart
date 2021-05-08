import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'Home.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MyHomePage(
        title: 'Countries',
     );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final formatter = new NumberFormat("#,###");


  Future<List<Data>> _getData() async{
    var data = await http.get(Uri.parse('https://api.covid19api.com/summary'));
    var jsonData = json.decode(data.body);
    List<Data> typeOfData = [];
    for(var i in jsonData['Countries']){
      Data temp = Data(i['Country'],i['CountryCode'].toLowerCase(), formatter.format(i['TotalConfirmed']),formatter.format(i['TotalDeaths']),formatter.format(i['TotalRecovered']),formatter.format(i['NewConfirmed']),formatter.format(i['NewRecovered']),formatter.format(i['NewDeaths']));
      typeOfData.add(temp);
    }
    return typeOfData;
  }

  @override
  Widget build(BuildContext context) {
    _getData();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.purple[500],
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
            future: _getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data == null){
                return Container(
                  child: SpinKitCircle(
                    color: Colors.purple[500],
                    size: 100.0,
                  ),
                );
              }
              else{
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      return SizedBox(
                        height: 50,
                        child: ListTile(
                          title: Center(
                            child: Text(
                              snapshot.data[index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context,
                                new MaterialPageRoute(builder: (context)=>DetailPage(snapshot.data[index]))
                            );
                          },
                        ),
                      );
                    }
                );
              }
            }
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Data data;
  DetailPage(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${data.name}'),
        backgroundColor: Colors.purple[500],
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/${data.code}.png'),
              ),
              SizedBox(height: 40),
              Text(
                'Total Cases:- ${data.TotalConfirmed}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.orange,
                ),
              ),
              Text(
                'New Cases:- +${data.NewConfirmed}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Total Recovered:- ${data.TotalRecovered}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.green[400],
                ),
              ),
              Text(
                'New Recovered:- +${data.NewRecovered}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.green[400],
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Total Deaths:- ${data.TotalDeaths}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.redAccent[400],
                ),
              ),
              Text(
                'New Deaths:- +${data.NewDeaths}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.redAccent[400],
                ),
              ),
              SizedBox(height: 50),
              Card(
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: RichText(
                    text: new TextSpan(
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        new TextSpan(text: 'The data fields\b'),
                        new TextSpan(text: 'New Confirmed, New Recovered\b',style: new TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                        new TextSpan(text: 'and\b'),
                        new TextSpan(text: 'New Deaths\b',style: new TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                        new TextSpan(text: 'shows data from\b'),
                        new TextSpan(text: 'last 24 Hours.',style: new TextStyle(fontSize:15,fontWeight: FontWeight.bold)),
                      ],
                    ),

                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}


class Data{
  String name,code;
  dynamic TotalConfirmed, TotalDeaths, TotalRecovered;
  dynamic NewConfirmed, NewDeaths, NewRecovered;
  Data(this.name, this.code, this.TotalConfirmed, this.TotalDeaths, this.TotalRecovered, this.NewConfirmed, this.NewRecovered, this.NewDeaths);
}