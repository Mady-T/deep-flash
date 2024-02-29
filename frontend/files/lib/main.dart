import 'package:fitness/models/deck_model.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DeckAdapter());
  await Hive.openBox('userdata');
  await Hive.openBox<Deck>('decks');
  //Hive.deleteBoxFromDisk('decksdata');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const HomePage(),
    );
  }
}