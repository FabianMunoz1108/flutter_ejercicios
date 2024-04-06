import 'package:flutter/cupertino.dart';

class MyScrollApp extends StatelessWidget {
  const MyScrollApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: HomeScroll(),
      title: 'MyScrollApp',
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemIndigo,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScroll extends StatelessWidget {
  const HomeScroll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('MyScrollApp'),
      ),
      child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(100, (index) => Text('Item $index')),
              ],
          ),
        ),
      )
      ),
    );
  }
}
