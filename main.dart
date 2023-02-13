import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_as_default/open_as_default.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}
//The main logic goes here.
class _MyAppState extends State<MyApp> {
  File? file;
  @override
  void initState() {
    super.initState();
    OpenAsDefault.getFileIntent.then((value) {
      if (value != null) {
        setState(() {
          print(value);
          file = value;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: (file == null) ? empty() : valid(path: file!.path),
    );
  }
}

class empty extends StatelessWidget {
  const empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile IDs"),
      ),
    );
  }
}

class valid extends StatelessWidget {

  valid({Key? key, required this.path}) : super(key: key);
  final String path;
  var cred;
  readContent(String path) {
    var result =File(path).readAsStringSync();
    String bs64string = result;
    List<int> decodedval = base64.decode(bs64string);
    String id = utf8.decode(decodedval);
    cred = id;
    print(cred);
    return cred;
    //return File(path).readAsStringSync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mobile IDs'),
        ),
        body: Center(
          child: Container(
              alignment: Alignment.center, //align to center
              height:250, //height to 250
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text("${readContent(path)}",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                  ),
                  Container(
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SecondRoute()),
                          );
                        },
                        child:Text("Redeem code",
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                      )
                  ) ,

                ],)
          ),
        )
    );
  }
}
class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mobile IDs"),
        backgroundColor: Colors.blue,
        actions: [
          ElevatedButton(
            onPressed: () {
              _navigateToNextScreen(context);
            },
            child: Icon(
              Icons.add_circle_outline_sharp,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Center(
            child: Container(
              height: 205.0,
              width: 340.0,
              color: Colors.blueAccent,
              child: Row(
                  crossAxisAlignment : CrossAxisAlignment.start,
                  children : [
                    Padding(padding: EdgeInsets.only(left: 20, top:13),
                      child: Container(
                          child: Image.asset("assets/images/profile3.png",
                            height: 180,
                            width: 130,
                          )
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 15, top:79),
                      child: Container(
                        child: Text('Sadhana Lakshmanan\n ID: LKJH-UT4D-TEDR-AZXS',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
void _navigateToNextScreen(BuildContext context) {

  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen()));
}
class NewScreen extends StatelessWidget {

  List<String> itemsList = [
    'Enter Invitation Code',
    'Scan QR Code',
    'Upload QR Code'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a Mobile ID')),
      body:
      ListView.builder(
          itemCount: itemsList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(itemsList[index]),
              ),
            );
          }),
    );
  }
}
