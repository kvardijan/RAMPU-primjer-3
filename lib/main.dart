import 'package:flutter/material.dart';
import 'package:lokalne_obavijesti/servisi_notifikacija.dart';

import 'drugi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifikacije demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Notifikacije demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ServisiNotifikacija servisiNotifikacija;

  @override
  void initState() {
    servisiNotifikacija = ServisiNotifikacija();
    SlusajObavijest();
    servisiNotifikacija.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SizedBox(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Demonstracija različitih vrsta notifikacija"),
                  ElevatedButton(
                      onPressed: () async {
                        await servisiNotifikacija.showNotification(
                            id: 0,
                            title: "Naslov",
                            body: "Tijelo notifikacije");
                      },
                      child: const Text("Obična obavijest")),
                  ElevatedButton(
                      onPressed: () async {
                        await servisiNotifikacija.showScheduledNotification(
                            id: 0,
                            title: "Naslov",
                            body: "Tijelo notifikacije",
                            seconds: 3);
                      },
                      child: const Text("Planirana obavijest")),
                  ElevatedButton(
                      onPressed: () async {
                        await servisiNotifikacija.showNotificationWithPayload(
                            id: 0,
                            title: "Naslov",
                            body: "Tijelo notifikacije",
                            payload: "ovo je teret");
                      },
                      child: const Text("Payload obavijest"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void SlusajObavijest() =>
      servisiNotifikacija.onNotificationClick.stream.listen(Slusatelj);

  void Slusatelj(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => DrugiEkran(
                    payload: payload,
                  ))));
    }
  }
}
