import 'package:flutter/material.dart';



class MyApp extends StatelessWidget {
  @override
  var data=['Item 1', 'Item 2', 'Item 3'];
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('PopupMenuButton Example'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (String value) {
                // Handle the menu item selection
                print('Selected: $value');
              },
              itemBuilder: (BuildContext context) {
                return data.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Center(
          child: Text('Press the menu button in the AppBar'),
        ),
      ),
    );
  }
}
