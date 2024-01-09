import 'package:flutter/material.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map? data = {};
  Object? parameters;

  @override
  Widget build(BuildContext context) {
    //final parameters = ModalRoute.of(context)!.settings.arguments;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      data = data!.isNotEmpty
          ? data
          : ModalRoute.of(context)!.settings.arguments as Map;
      //data = jsonDecode(jsonEncode(parameters));
      // statement(s) will execute if the Boolean expression is true.
      //if (data?['isDaytime'] != null) {
      //}
    }
    String bgImage =
        data!['location'] == 'Seoul' ? 'assets/night.png' : 'assets/day.png';

    var loc = data?['location'];
    var timev = data?['time'];

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('$bgImage'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: <Widget>[
                FilledButton.tonal(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.green)),
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag'],
                      };
                    });
                  },
                  child: Text('choose location'),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$loc',
                      style: TextStyle(fontSize: 20, letterSpacing: 2),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '$timev',
                  style: TextStyle(
                    fontSize: 66,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
