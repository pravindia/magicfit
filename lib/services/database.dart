import 'package:flutter/material.dart';

class DbService with ChangeNotifier {
  initDb() async {
    WidgetsFlutterBinding.ensureInitialized();
  }
}
