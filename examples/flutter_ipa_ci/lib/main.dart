import 'package:flutter/cupertino.dart';

void main() {
  runApp(const IpaCiDemoApp());
}

class IpaCiDemoApp extends StatelessWidget {
  const IpaCiDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: IpaCiDemoHome(),
    );
  }
}

class IpaCiDemoHome extends StatelessWidget {
  const IpaCiDemoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('IPA CI Demo'),
      ),
      child: Center(
        child: Text('Built by GitHub Actions on macOS.'),
      ),
    );
  }
}
