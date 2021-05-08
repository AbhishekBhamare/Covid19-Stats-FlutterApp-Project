import 'package:flutter/material.dart';
import 'app.dart';


class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Covid-19 Info',
          style: TextStyle(
            color: Colors.white,
          ),
        ),

        backgroundColor: Colors.purple[500],
        centerTitle: true,
      ),
      body:Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
      text: new TextSpan(
          style: new TextStyle(
          fontSize: 18.0,
          color: Colors.black,
      ),
      children: <TextSpan>[
        new TextSpan(text: 'Most common symptoms:\n',style: new TextStyle(fontSize:22,fontWeight: FontWeight.bold)),
        new TextSpan(text: '\b1. fever\n\b2. dry cough\n\b3. tiredness\n'),
        new TextSpan(text: '\n'),
        new TextSpan(text: 'Less common symptoms:\n',style: new TextStyle(fontSize:22,fontWeight: FontWeight.bold)),
        new TextSpan(text: '\b1. aches and pains\n\b2. sore throat\n\b3. diarrhoea\n\b4. conjunctivitis\n\b5. headache\n'),
        new TextSpan(text: '\b6. loss of taste or smell\n\b7. a rash on skin, or discolouration of \b\b\b\bfingers or toes\n'),
        new TextSpan(text: '\nSerious symptoms:\n',style: new TextStyle(fontSize:22,fontWeight: FontWeight.bold)),
        new TextSpan(text: '\b1. difficulty breathing or shortness of \bbreath\n\b2. chest pain or pressure\n\b3. loss of speech or movement\n\n\n\n'),
        new TextSpan(text: 'Click Button below to check covid19 status of different Countries',style: new TextStyle(fontSize:20,fontWeight: FontWeight.bold) ),
      ],
    ),
    ),
        ),
      ),
      floatingActionButton: FlatButton.icon(
        onPressed: (){
          Navigator.pushNamed(context, '/myapp');
        },
        icon: Icon(Icons.map),
        label: Text('Check'),
        color: Colors.purple[500],
        textColor: Colors.white,
       ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
