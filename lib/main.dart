import 'package:flutter/material.dart';
import 'package:flutter_url_shortener/src/controllers/url_shortner_controller.dart';
import 'package:flutter_url_shortener/src/views/url_shorner_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UrlShortnerController()),
      ],
      child: MaterialApp(
        title: 'Flutter URL Shortener',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const UrlShortenerScreen(),
      ),
    );
  }
}
