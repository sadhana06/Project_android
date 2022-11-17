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
  File? _file;

  @override
  void initState() {
    super.initState();
    OpenAsDefault.getFileIntent.then((value) {
      if (value != null) {
        setState(() {
          print(value);
          _file = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: (_file == null) ? empty() : valid(path: _file!.path),
    );
  }
}

class empty extends StatelessWidget {
  const empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
    );
  }
}

class valid extends StatelessWidget {
  final String path;
  const valid({Key? key, required this.path}) : super(key: key);


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
            //color: Colors.blue,
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
                onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       settings: RouteSettings(arguments: itemsList[index]),
                //       builder: (context) => nextScreen(),
                //     ),
                //   );
                },
              ),
            );
          }),
    );
  }
}