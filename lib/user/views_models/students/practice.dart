import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  int num = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('practice'),
        actions: [
   
          PopupMenuButton(
            position: PopupMenuPosition.under,
            elevation: 20.0,
            shape: ContinuousRectangleBorder(),
            splashRadius: 50,
            shadowColor: Colors.red,
            tooltip: 'Menu',
            surfaceTintColor: Colors.deepOrange,
            color: Colors.amber,
            onSelected: (value) {
              if (value == 'settings') {
              } else if (value == 'hey') {}
              print(value);
            },
            // icon: Icon(ICons.),
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: 'Settings', child: Text('Settings')),
                PopupMenuItem(value: 'hey', child: Text('hey')),
                PopupMenuItem(value: 'acha', child: Text('acha'))
              ];
            },
          )
        ],
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        splashColor: Colors.green,
        elevation: 20.0,
        // mini: true,
        highlightElevation: 50.0,

        shape: BeveledRectangleBorder(),
        onPressed: () {
          print('hey whats up');
        },
        child: Text('jsdjhjshdjhdfjsfhjhsdfj'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$num',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Text(
              'You have pushed button $num',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  num = num + 1;
                  print(num);
                });
              },
              child: Container(
                width: 300,
                height: 60,
                color: Colors.amber,
                alignment: Alignment.center,
                child: Text(
                  'Press me',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
 