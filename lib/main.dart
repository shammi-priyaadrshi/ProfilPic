import 'package:flutter/material.dart';

import 'custom_sliver_header_profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SliversBasicPage(),
    );
  }
}

class SliversBasicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CustomSliverHeaderForProfilePic());
  }
}
