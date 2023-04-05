import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yash_sherpura_practical_task/view/login_screen.dart';
import 'package:yash_sherpura_practical_task/widget/pref_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
    );
  }
}
