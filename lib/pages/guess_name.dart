//import 'dart:html';

import 'package:flutter/material.dart';

import 'api.dart';

class GuessAge extends StatefulWidget {
  static const routeName = '/guess';

  const GuessAge({Key? key}) : super(key: key);

  @override
  _GuessAgeState createState() => _GuessAgeState();
}

class _GuessAgeState extends State<GuessAge> {
  int _year = 0;
  int _month = 0;
  var _ansyear = 32;
  var _ansmonth = 8;
  var _isload = false;

  void minus() {
    setState(() {
      if (_year != 0) {
        _year--;
      }
    });
  }

  void add() {
    setState(() {
      _year++;
    });
  }

  void minus2() {
    setState(() {
      if (_month != 0) {
        _month--;
      }
    });
  }

  void add2() {
    setState(() {
      if (_month != 11) {
        _month++;
      }
    });
  }

  Future<void> guess() async {
    /*var isGuess = await _guessAgeApi(_year,_month);
    if (_year == _ansyear && _month == _ansmonth ) {
      if (isGuess == null) return;
      if (isGuess) {
        Navigator.pushReplacementNamed(context, CorrectAnswer.routeName);
      }
    }else {
      _showMaterialDialog('ไม่ถูกต้อง', 'ทายมากไป');
    }*/
    setState(() {
      if (_year == _ansyear && _month == _ansmonth) {
        Navigator.pushReplacementNamed(context, CorrectAnswer.routeName);
      } else {
        if (_year <= _ansyear) {
          if (_month >= _ansmonth) {
            _showMaterialDialog("ไม่ถูกต้อง", "ทายมากไป");
          } else {
            _showMaterialDialog("ไม่ถูกต้อง","ทายน้อยไป",);
          }
        } else {
          _showMaterialDialog("ไม่ถูกต้อง", "ทายมากไป");
        }
      }
    });
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 40.0,
              color: Colors.red,
            ),
          ),
          content: Text(
            msg,
            style: const TextStyle(
              fontSize: 25.0,
              color: Colors.brown,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.redAccent.shade200,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _guessAgeApi(int _year,int _month) async {
    try {
      setState(() {
        _isload = true;
      });
      var isGuess = (await Api().submit('guess', {'year': _year, 'month': _month })) as bool;
      print('GUESS: $isGuess');
      return isGuess;
    } catch (e) {
      print(e);
      _showMaterialDialog('ERROR', e.toString());
      return null;
    } finally {
      setState(() {
        _isload = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.calculate,
              ),
            ),
            Text(
              "GUESS TEACHER'S AGE",
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsetsDirectional.only(
              top: 20.0,
            ),
            color: Colors.blueAccent.shade100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox( height: 20.0,),
                Text("อายุอาจารย์",style: Theme.of(context).textTheme.headline1,),
                Card(
                  color: Colors.white,
                  margin: const EdgeInsets.all(12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 10,
                  child: Column(
                    children: [
                      Text( "ปี",style: Theme.of(context).textTheme.headline3,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FloatingActionButton(
                            onPressed: minus,
                            child: const Icon(
                              Icons.remove,
                              color: Colors.deepPurpleAccent,
                            ),
                            backgroundColor: Colors.teal.shade100,
                          ),
                          Text(
                            '$_year',
                            style: const TextStyle(
                              fontSize: 60.0,
                              color: Colors.teal,
                            ),
                          ),
                          FloatingActionButton(
                            onPressed: add,
                            child: const Icon(
                              Icons.add,
                              color: Colors.redAccent,
                            ),
                            backgroundColor: Colors.teal.shade100,
                          ),
                        ],
                      ),
                      const Divider(
                        height: 20,
                        thickness: 4.0,
                        color: Colors.grey,
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      Text("เดือน",style: Theme.of(context).textTheme.headline3,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FloatingActionButton(
                            onPressed: minus2,
                            child: const Icon(
                              Icons.remove,
                              color: Colors.deepPurpleAccent,
                            ),
                            backgroundColor: Colors.teal.shade100,
                          ),
                          Text(
                            '$_month',
                            style: const TextStyle(
                              fontSize: 60.0,
                              color: Colors.teal,
                            ),
                          ),
                          FloatingActionButton(
                            onPressed: add2,
                            child: const Icon(
                              Icons.add,
                              color: Colors.redAccent,
                            ),
                            backgroundColor: Colors.teal.shade100,
                          ),
                        ],
                      ),
                      const Divider(
                        height: 20,
                        thickness: 4.0,
                        color: Colors.grey,
                        indent: 20.0,
                        endIndent: 20.0,
                      ),
                      //ปุ่มกดทาย
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 50),
                            primary: Colors.redAccent,
                          ),
                          onPressed: guess,
                          child: const Text(
                            'ทายอายุ',
                            style: TextStyle(
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "ตัวอย่างนี้กำหนดอายุเป็น $_ansyear ปี $_ansmonth เดือน",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          if (_isload)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

}

class CorrectAnswer extends StatefulWidget {
  static const routeName = '/correct';

  const CorrectAnswer({Key? key}) : super(key: key);

  @override
  _CorrectAnswerState createState() => _CorrectAnswerState();
}

class _CorrectAnswerState extends State<CorrectAnswer> {
  var _ansyear = 32;
  var _ansmonth = 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.calculate,
              ),
            ),
            Text(
              "GUESS TEACHER'S AGE",
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "ทายถูกต้อง",
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "อายุ $_ansyear ปี $_ansmonth เดือน",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Icon(
                Icons.check_circle_sharp,
                size: 100.0,
                color: Colors.teal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
