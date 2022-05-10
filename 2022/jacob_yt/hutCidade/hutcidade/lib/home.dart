import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hutcidade/layout/body_home.dart';

enum Request {
  bus,
  trash,
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String title = 'Joaçaba';
  String horarios = 'Ônibus';
  Request request = Request.bus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.location_city,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: DropdownButton<String>(
          dropdownColor: Theme.of(context).primaryColor,
          value: title,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          icon: const Padding(
            padding: EdgeInsets.only(left: 5),
            child: Icon(
              Icons.arrow_downward,
              color: Colors.white,
            ),
          ),
          items: <String>['Joaçaba', 'Herval D"Oeste']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              title = value!;
            });
          },
        ),
      ),
      body: const BodyHome(),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: null,
              child: Text(
                'Horários do $horarios',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            IconButton(
              color: Colors.white,
              onPressed: () {
                setState(() {
                  horarios = 'caminhão do lixo';
                  request = Request.trash;
                });
                if (kDebugMode) {
                  print('Trash request');
                }
              },
              icon: Icon(
                Icons.restore_from_trash,
                size: request == Request.trash ? 30 : 20,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.bus_alert,
                size: request == Request.bus ? 30 : 20,
              ),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  horarios = 'Ônibus';
                  request = Request.bus;
                });
                if (kDebugMode) {
                  print('Bus horários request');
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
